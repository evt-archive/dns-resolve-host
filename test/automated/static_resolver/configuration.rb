require_relative '../automated_init'

context "Configuring Static Resolver" do
  receiver = OpenStruct.new

  context "Default attribute name" do
    static_resolver = DNS::ResolveHost::StaticResolver.configure receiver

    test "Static resolver attribute is set on receiver" do
      assert receiver.static_resolver.instance_of?(Resolv::Hosts)
      assert receiver.static_resolver == static_resolver
    end
  end

  context "Local path is specified" do
    local_path = 'settings/hosts.dns_resolve_host'

    static_resolver = DNS::ResolveHost::StaticResolver.configure receiver, local_path

    test "Configured host resolver uses specified file" do
      assert static_resolver do
        file? local_path
      end
    end
  end

  context "Attribute name is specified" do
    static_resolver = DNS::ResolveHost::StaticResolver.configure receiver, attr_name: :some_attr

    test "Static resolver attribute is set on receiver" do
      assert receiver.some_attr.instance_of?(Resolv::Hosts)
      assert receiver.some_attr == static_resolver
    end
  end
end
