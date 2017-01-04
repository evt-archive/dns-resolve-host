module DNS
  class ResolveHost
    module Substitute
      def self.build
        ResolveHost.new
      end

      class ResolveHost
        def call(hostname)
          if map.key? hostname
            map[hostname]
          elsif ip_address? hostname
            hostname
          else
            raise ResolutionError
          end
        end

        def ip_address?(string)
          IPAddr.new string
          true
        rescue IPAddr::InvalidAddressError
          false
        end

        def set(hostname, ip_addresses)
          ip_addresses = Array(ip_addresses)

          map[hostname] = ip_addresses

          ip_addresses
        end

        def map
          @map ||= {}
        end
      end
    end
  end
end
