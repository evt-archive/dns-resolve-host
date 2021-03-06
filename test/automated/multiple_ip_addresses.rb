require_relative './automated_init'

context "Hostname Resolves To Multiple Addresses" do
  resolve_host = DNS::ResolveHost.new
  hostname = Controls::Hostname.example

  control_ip_addresses = Controls::IPAddress.list

  Controls::Server.start ip_addresses: control_ip_addresses do |host, port|
    resolve_host.nameserver_address = host
    resolve_host.nameserver_port = port

    ip_addresses = resolve_host.(hostname)

    test "IP address is returned" do
      assert ip_addresses == control_ip_addresses
    end
  end
end
