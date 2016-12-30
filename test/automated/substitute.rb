require_relative './automated_init'

context "Substitute" do
  hostname = Controls::Hostname.example

  context "No IP addresses are specified for given hostname" do
    substitute = SubstAttr::Substitute.build DNS::ResolveHost

    test "Resolution error is raised" do
      assert proc { substitute.(hostname) } do
        raises_error? DNS::ResolveHost::ResolutionError
      end
    end
  end

  context "Single IP address is specified for a given hostname" do
    substitute = SubstAttr::Substitute.build DNS::ResolveHost

    ip_address = Controls::IPAddress.example

    substitute.set hostname, ip_address

    context "Specified hostname is queried" do
      ip_addresses = substitute.(hostname)

      test "List containing specified IP address is returned" do
        assert ip_addresses == [ip_address]
      end
    end

    context "Other hostname is queried" do
      other_hostname = Controls::Hostname.example 'other-hostname'

      test "Resolution error is raised" do
        assert proc { substitute.(other_hostname) } do
          raises_error? DNS::ResolveHost::ResolutionError
        end
      end
    end
  end

  context "Mutliple IP addresses are specified for a given hostname" do
    substitute = SubstAttr::Substitute.build DNS::ResolveHost

    control_ip_addresses = Controls::IPAddress.list

    substitute.set hostname, control_ip_addresses

    context "Specified hostname is queried" do
      ip_addresses = substitute.(hostname)

      test "List containing specified IP addresses is returned" do
        assert ip_addresses == control_ip_addresses
      end
    end

    context "Other hostname is queried" do
      other_hostname = Controls::Hostname.example 'other-hostname'

      test "Resolution error is raised" do
        assert proc { substitute.(other_hostname) } do
          raises_error? DNS::ResolveHost::ResolutionError
        end
      end
    end
  end
end
