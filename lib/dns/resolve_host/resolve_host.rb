module DNS
  class ResolveHost
    include Log::Dependency

    configure :resolve_host

    attr_accessor :nameserver

    singleton_class.send :alias_method, :build, :new

    def self.call(hostname, &block)
      instance = new
      instance.()
    end

    def call(hostname, &block)
      if nameserver
        options = { :nameserver_port => [nameserver.to_a] }
      else
        options = nil
      end

      logger.trace { "Resolving host (#{LogAttributes.get self, hostname})" }

      Resolv::DNS.open options do |dns|
        block.(dns) if block

        addresses = dns.getaddresses hostname

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
  end
end
