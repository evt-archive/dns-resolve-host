require_relative './automated_init'

context "Hostname Resolves To Single IP Address" do
  resolve_host = DNS::ResolveHost.new
  hostname = Controls::Hostname.example

  Controls::Server.start do |nameserver|
    resolve_host.nameserver = nameserver

    ip_addresses = resolve_host.(hostname)

    test "IP address is returned" do
      assert ip_addresses == [Controls::IPAddress.example]
    end
  end
end
