require_relative './automated_init'

context "IP Address Cannot Be Resolved From Hostname" do
  resolve_host = DNS::ResolveHost.new
  hostname = Controls::Hostname.example 'other-hostname'

  Controls::Server.start do |nameserver|
    resolve_host.nameserver = nameserver

    ip_addresses = resolve_host.(hostname)

    test "Empty list of addresses is returned" do
      assert ip_addresses = []
    end
  end
end
