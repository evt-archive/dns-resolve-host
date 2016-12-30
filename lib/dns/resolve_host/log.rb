module DNS
  class ResolveHost
    class Log < ::Log
      def tag!(tags)
        tags << :dns_resolve_host
        tags << :dns
        tags << :verbose
      end
    end
  end
end
