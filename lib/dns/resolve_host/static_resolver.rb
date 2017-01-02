module DNS
  class ResolveHost
    module StaticResolver
      def self.get(local_path=nil)
        logger.trace { "Constructing static resolver (LocalPath: #{local_path.inspect})" }

        local_path ||= Defaults.local_hosts_file

        if File.exist? local_path
          hosts_file = local_path
        else
          hosts_file = Resolv::Hosts::DefaultFileName
        end

        static_resolver = Resolv::Hosts.new hosts_file

        logger.trace { "Static resolver constructed (LocalPath: #{local_path.inspect}, HostsFile: #{hosts_file})" }

        static_resolver
      end

      def self.configure(receiver, local_path=nil, attr_name: nil)
        attr_name ||= :static_resolver

        instance = get local_path
        receiver.public_send "#{attr_name}=", instance
        instance
      end

      def self.logger
        @logger ||= Log.get self
      end

      module Assertions
        def file?(file)
          @filename == file
        end
      end
    end
  end
end
