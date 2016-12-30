require_relative './automated_init'

context "IP Address Cannot Be Resolved From Hostname" do
  resolve_host = DNS::ResolveHost.new
  hostname = Controls::Hostname.example 'other-hostname'

  Controls::Server.start do |nameserver|
    resolve_host.nameserver = nameserver

    test "Address resolution error is raised" do
      assert proc { resolve_host.(hostname) } do
        raises_error? DNS::ResolveHost::ResolutionError
      end
    end
  end
end
