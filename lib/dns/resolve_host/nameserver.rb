module DNS
  class ResolveHost
    Nameserver = Struct.new :ip_address, :port do
      def to_a
        [ip_address, port]
      end
    end
  end
end
