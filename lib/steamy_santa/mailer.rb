module SteamySanta
  class Mailer
    include Settings

    def initialize(participant)
      @participant = participant
    end

    def deliver
      Pony.mail(pony_options)
    end

    def to_s
      <<-EOS.strip_heredoc
           From: #{from}
             To: #{to}
        Subject: #{subject}

        #{indented_body}
      EOS
    end

    private

    def body
      @body ||= view.result(@participant.view_binding).strip
    end

    def from
      settings[:from]
    end

    def indented_body
      body.lines.join("        ")
    end

    def pony_options
      {
        from: from,
        html_body: body,
        subject: subject,
        to: to,
        via: :smtp,
        via_options: settings[:smtp]
      }
    end

    def subject
      settings[:subject]
    end

    def to
      settings[:to] || "#{@participant.nickname} <#{@participant.email}>"
    end

    def view
      File.open(view_path, 'r') do |io|
        ERB.new(io.read)
      end
    end

    def view_path
      view_file_or_path = settings[:view].sub(/\.erb\z/, '') + '.erb'

      if view_file_or_path.start_with?('/')
        view_file_or_path
      else
        File.join(File.dirname(__FILE__), '..', '..', 'views', view_file_or_path)
      end
    end
  end
end
