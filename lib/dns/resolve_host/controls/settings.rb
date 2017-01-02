module DNS
  class ResolveHost
    module Controls
      module Settings
        def self.example
          DNS::ResolveHost::Settings.build({
            nameserver_host: address,
            nameserver_port: port
          })
        end

        def self.address
          '10.0.0.0'
        end

        def self.port
          1111
        end
      end
    end
  end
end
