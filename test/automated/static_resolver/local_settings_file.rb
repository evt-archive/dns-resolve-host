require_relative '../automated_init'

context "Static Resolver, Local Settings File" do
  hostname = Controls::Hostname.example

  context "Project-local file is not specified" do
    static_resolver = DNS::ResolveHost::StaticResolver.get

    test "Static resolver uses system hosts file" do
      assert static_resolver do
        file? Resolv::Hosts::DefaultFileName
      end
    end
  end

  context "Project-local file is specified" do
    static_resolver = DNS::ResolveHost::StaticResolver.get 'settings/hosts.example'

    test "Static resolver uses specified hosts file" do
      assert static_resolver do
        file? 'settings/hosts.example'
      end
    end
  end

  context "Project-local file is not found" do
    test "Error is raised" do
      assert proc { DNS::ResolveHost::StaticResolver.get 'not-a-file' } do
        raises_error? Errno::ENOENT
      end
    end
  end
end
