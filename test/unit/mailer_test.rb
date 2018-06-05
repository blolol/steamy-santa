require 'test_helper'

module SteamySanta
  class MailerTest < TestCase
    def setup
      stub_settings
      build_participant
      build_mailer
    end

    def test_delivery
      expected_body = <<-EOS.strip_heredoc.strip
        Ho, ho, ho, CCP!
        You get to buy a game for Doolan, whose Steam username is "stdoolan"!
        Doolan can play Mac and Windows games.
        Upon signing up, Doolan was wearing "High heels, suspenders and a bra."
      EOS

      expected_options = {
        from: 'Santa Claus <santa@example.com>',
        html_body: expected_body,
        subject: "Ho, ho, ho! It's time to get steamy, CCP!",
        to: 'CCP <ccp@example.com>',
        via: :smtp,
        via_options: {
          address: 'smtp.example.com',
          enable_starttls_auto: true,
          password: 's3cr3t',
          port: 587,
          username: 'example'
        }
      }

      Pony.expects(:mail).once.with(expected_options)

      @mailer.deliver
    end

    def test_overriding_recipient_address
      stub_settings to: 'Expected <expected@example.com>'

      assert_includes @mailer.to_s, 'To: Expected <expected@example.com>'

      expected_body = <<-EOS.strip_heredoc.strip
        Ho, ho, ho, CCP!
        You get to buy a game for Doolan, whose Steam username is "stdoolan"!
        Doolan can play Mac and Windows games.
        Upon signing up, Doolan was wearing "High heels, suspenders and a bra."
      EOS

      expected_options = {
        from: 'Santa Claus <santa@example.com>',
        html_body: expected_body,
        subject: "Ho, ho, ho! It's time to get steamy, CCP!",
        to: 'Expected <expected@example.com>',
        via: :smtp,
        via_options: {
          address: 'smtp.example.com',
          enable_starttls_auto: true,
          password: 's3cr3t',
          port: 587,
          username: 'example'
        }
      }

      Pony.expects(:mail).once.with(expected_options)

      @mailer.deliver
    end

    def test_to_s
      expected = <<-EOS.strip_heredoc.strip
           From: Santa Claus <santa@example.com>
             To: CCP <ccp@example.com>
        Subject: Ho, ho, ho! It's time to get steamy, CCP!

        Ho, ho, ho, CCP!
        You get to buy a game for Doolan, whose Steam username is "stdoolan"!
        Doolan can play Mac and Windows games.
        Upon signing up, Doolan was wearing "High heels, suspenders and a bra."
      EOS

      assert_equal expected, @mailer.to_s.strip
    end

    private

    def build_mailer
      @mailer = Mailer.new(@participant)
    end

    def build_participant
      @participant = Participant.new('CCP', 'ccp@example.com', 'goeatfood', %w(Mac),
        'And now for something completely different.')
      victim = Participant.new('Doolan', 'doolan@example.com', 'stdoolan', %w(Mac Windows),
        'High heels, suspenders and a bra.')
      @participant.victim = victim
    end

    def stub_settings(settings = {})
      view_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'views', 'mailer.erb'))

      SteamySanta.stubs(:settings).returns({
        from: 'Santa Claus <santa@example.com>',
        smtp: {
          address: 'smtp.example.com',
          enable_starttls_auto: true,
          password: 's3cr3t',
          port: 587,
          username: 'example'
        },
        subject: "Ho, ho, ho! It's time to get steamy, %{nickname}!",
        view: view_path
      }.merge(settings))
    end
  end
end
