require_relative './automated_init'

context "Configuration" do
  receiver = OpenStruct.new

  DNS::ResolveHost.configure receiver

  test "Resolve host attribute is configured" do
    assert receiver.resolve_host do
      instance_of? DNS::ResolveHost
    end
  end
end
