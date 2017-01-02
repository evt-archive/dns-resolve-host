module DNS
  class ResolveHost
    module Controls
      module Server
        def self.start(hostname: nil, ip_addresses: nil, &block)
          hostname ||= Hostname.example
          ip_addresses ||= [IPAddress.example]

          bind_address = BindAddress.example
          port = Port.example

          interfaces = [[:udp, bind_address, port], [:tcp, bind_address, port]]

          Celluloid.logger = Log.get self

          dns_server = RubyDNS.run_server :listen => interfaces, :asynchronous => true do
            match %r{\A#{Regexp.escape hostname}\z} do |request|
              ip_addresses.each do |ip_address|
                request.respond! ip_address
              end
            end
          end

          block.(bind_address, port)

          # The rubydns library does not properly unbind its server socket when
          # the actor terminates. See the following github issue:
          #
          #     https://github.com/ioquatix/rubydns/issues/60
          #
          # The workaround discovered by the person who filed the issue is
          # pasted here. The proper way to stop the DNS server would be this:
          #
          #     dns_server.terminate
          #
          # [Nathan Ladd, Fri 30 Dec 2016]
          dns_server.actors.first.links.each(&:terminate)
        end

        class Log < ::Log
          def tag!(tags)
            tags << :celluloid
            tags << :control_dns_server
          end
        end

        module BindAddress
          def self.example
            '127.0.0.1'
          end
        end

        module Port
          def self.example
            10053
          end
        end
      end
    end
  end
end
