module DNS
  class ResolveHost
    include Log::Dependency

    configure :resolve_host

    setting :nameserver_address
    setting :nameserver_port

    def self.build(settings=nil)
      settings ||= Settings.instance

      instance = new
      settings.set instance
      instance
    end

    def self.call(hostname, &block)
      instance = new
      instance.(hostname, &block)
    end

    def call(hostname, &block)
      logger.trace { "Resolving host (#{LogAttributes.get self, hostname})" }

      Resolv::DNS.open resolv_options do |dns|
        resolver = Resolv.new [Resolv::Hosts.new, dns]

        block.(dns) if block

        addresses = resolver.getaddresses hostname

        addresses.map! &:to_s

        if addresses.empty?
          error_message = "Could not resolve host (#{LogAttributes.get self, hostname})"
          logger.error { error_message }
          raise ResolutionError, error_message
        end

        logger.info { "Resolved host (#{LogAttributes.get self, hostname}, Address#{'es' unless addresses.count == 1}: #{addresses * ', '})" }

        return addresses
      end
    end

    def resolv_options
      if nameserver_address
        { :nameserver_port => [[nameserver_address, nameserver_port]] }
      else
        nil
      end
    end

    def nameserver_port
      @nameserver_port ||= Defaults.port
    end
  end
end
