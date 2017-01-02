require_relative '../automated_init'

context "Static Resolver, Local Settings File" do
  hostname = Controls::Hostname.example

  context "Project-local file is found (default path)" do
    static_resolver = DNS::ResolveHost::StaticResolver.get

    test "Static resolver uses specified file" do
      assert static_resolver do
        file? 'settings/hosts.dns_resolve_host'
      end
    end

    test "Hosts specified in file can be resolved" do
      ip_addresses = static_resolver.getaddresses hostname

      ip_addresses.map! &:to_s

      assert ip_addresses == Controls::IPAddress.list
    end
  end

  context "Project-local file is not found" do
    static_resolver = DNS::ResolveHost::StaticResolver.get 'not-a-file'

    static_resolver.getaddresses hostname

    test "Static resolver uses system hosts file" do
      assert static_resolver do
        file? Resolv::Hosts::DefaultFileName
      end
    end
  end
end