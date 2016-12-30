require_relative './automated_init'

context "System (Default) Nameservers" do
  resolve_host = DNS::ResolveHost.new
  hostname = 'example.com'

  ip_addresses = resolve_host.(hostname) do |dns|
    dns.timeouts = 0.1
  end

  test "List of IP addresses is returned" do
    refute ip_addresses.none?

    ip_addresses.each do |ip_address|
      refute proc { IPAddr.new ip_address } do
        raises_error? IPAddr::InvalidAddressError
      end
    end
  end
end
