require_relative './automated_init'

context "Standard library DNS resolver options" do
  port = 1111

  context "Address is not specified" do
    context "Port is not specified" do
      resolve_host = DNS::ResolveHost.build

      test "Nil is returned" do
        assert resolve_host.dns_resolver_options == nil
      end
    end

    context "Port is specified" do
      test "Argument error is raised" do
        assert proc { DNS::ResolveHost.build port: port } do
          raises_error? ArgumentError
        end
      end
    end
  end

  context "Address is specified" do
    address = Controls::IPAddress.example

    context "Port is not specified" do
      resolve_host = DNS::ResolveHost.build address: address

      test "Specified address and default DNS port are returned" do
        assert resolve_host.dns_resolver_options == { :nameserver_port => [[address, 53]] }
      end
    end

    context "Port is specified" do
      resolve_host = DNS::ResolveHost.build address: address, port: port

      test "Specified address and port are returned" do
        assert resolve_host.dns_resolver_options == { :nameserver_port => [[address, port]] }
      end
    end
  end
end
