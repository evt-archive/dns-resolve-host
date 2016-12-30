module DNS
  class ResolveHost
    module Substitute
      def self.build
        ResolveHost.new
      end

      class ResolveHost
        def call(hostname)
          map[hostname]
        end

        def set(hostname, ip_addresses)
          ip_addresses = Array(ip_addresses)

          map[hostname] = ip_addresses

          ip_addresses
        end

        def map
          @map ||= Hash.new { [] }
        end
      end
    end
  end
end
