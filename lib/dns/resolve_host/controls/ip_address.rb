module DNS
  class ResolveHost
    module Controls
      module IPAddress
        def self.example(i=nil)
          i ||= 1

          ip_address = IPAddr.new "127.0.0.#{i}"

          ip_address.to_s
        end

        def self.list(count=nil)
          count ||= 3

          (1..count).map do |i|
            example i
          end
        end
      end
    end
  end
end
