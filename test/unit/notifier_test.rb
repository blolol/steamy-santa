require 'test_helper'

module SteamySanta
  class NotifierTest < TestCase
    def test_that_default_is_dry_run
      stub_mailer_body
      Mailer.any_instance.expects(:deliver).never

      valid_json = StringIO.new(fixture('valid.json'))

      notifier = Notifier.new(valid_json)
      notifier.expects(:log).times(3)
      notifier.notify
    end

    def test_sending_actual_emails
      stub_mailer_body
      Mailer.any_instance.expects(:deliver).times(3)

      valid_json = StringIO.new(fixture('valid.json'))

      notifier = Notifier.new(valid_json, dry_run: false)
      notifier.expects(:log).times(3)
      notifier.notify
    end

    private

    def stub_mailer_body
      Mailer.any_instance.stubs(:body).returns('example')
    end
  end
end
