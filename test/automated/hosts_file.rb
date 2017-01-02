require_relative './automated_init'

context "Hostname Resolves Entry In Hosts File" do
  hostname = Controls::HostsFile.hostname

  resolve_host = DNS::ResolveHost.new

  Controls::Server.start do |host, port|
    resolve_host.nameserver_address = host
    resolve_host.nameserver_port = port

    ip_addresses = resolve_host.(hostname)

    test "IP address is returned" do
      assert ip_addresses.include?(Controls::HostsFile.ip_address)
    end
  end
end
