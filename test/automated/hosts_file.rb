require_relative './automated_init'

context "Hostname Resolves Entry In Hosts File" do
  hostname = Controls::Hostname.example

  Controls::Server.start do |address, port|
    resolve_host = DNS::ResolveHost.build address: address, port: port

    ip_addresses = resolve_host.(hostname)

    test "IP addresses are returned" do
      assert ip_addresses == Controls::IPAddress.list
    end
  end
end
