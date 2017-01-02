require_relative './automated_init'

context "Configuration" do
  context do
    receiver = OpenStruct.new

    DNS::ResolveHost.configure receiver

    test "Resolve host attribute is configured" do
      assert receiver.resolve_host do
        instance_of? DNS::ResolveHost
      end
    end

    test "Resolv library options is set to nil" do
      assert receiver.resolv_options == nil
    end
  end

  context "Settings are specified" do
    settings = Controls::Settings.example
  end
end
