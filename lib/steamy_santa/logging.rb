module SteamySanta
  module Logging
    class << self
      attr_accessor :logger
    end

    def log(level, *args)
      if Logging.logger
        line = args.join(' ')
        Logging.logger.send(level, line)
      end
    end
  end
end
