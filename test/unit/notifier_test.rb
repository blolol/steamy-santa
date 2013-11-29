require 'test_helper'

module SteamySanta
  class NotifierTest < TestCase
    test 'that the default is a dry run' do
      stub_mailer_body
      Mailer.any_instance.expects(:deliver).never

      valid_json = StringIO.new(fixture('valid.json'))

      notifier = Notifier.new(valid_json)
      notifier.expects(:log).times(3)
      notifier.notify
    end

    test 'sending actual emails' do
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
