module SteamySanta
  class Notifier
    DEFAULT_OPTIONS = { dry_run: true }

    include Logging

    def initialize(io, options = {})
      @io = io
      @options = DEFAULT_OPTIONS.merge(options)
    end

    def notify
      mailers.each do |mailer|
        log :info, "Preparing message...\n#{mailer}"

        unless dry_run?
          mailer.deliver
        end
      end
    end

    private

    def dry_run?
      @options[:dry_run]
    end

    def mailers
      participants.map do |participant|
        Mailer.new(participant)
      end
    end

    def participants
      @participants ||= Marshal.load_participants_from_json(@io)
    end
  end
end
