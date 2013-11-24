require 'test_helper'

module SteamySanta
  class SorterTest < TestCase
    test 'parsing invalid CSV data' do
      invalid_csv_data = fixture('invalid.csv')
      sorter = Sorter.new(invalid_csv_data)

      assert_raises CSV::MalformedCSVError do
        sorter.participants
      end
    end

    test 'parsing CSV data with not enough participants' do
      incomplete_csv_data = fixture('not_enough_participants.csv')
      sorter = Sorter.new(incomplete_csv_data)

      assert_raises NotEnoughParticipantsError do
        sorter.participants
      end
    end

    test 'parsing participants from valid CSV data' do
      valid_csv_data = fixture('valid.csv')
      sorter = Sorter.new(valid_csv_data)

      assert_equal 3, sorter.participants.size

      first_participant = sorter.participants.first
      assert_equal 'CCP', first_participant.nickname
      assert_equal 'ccp@example.com', first_participant.email
      assert_equal 'goeatfood', first_participant.steam_username
      assert_equal %w(Mac), first_participant.steam_platforms
      assert_equal 'And now for something completely different!', first_participant.wearing

      last_participant = sorter.participants.last
      assert_equal 'Raws', last_participant.nickname
      assert_equal 'raws@example.com', last_participant.email
      assert_equal 'rawsosaurus', last_participant.steam_username
      assert_equal %w(Mac Windows), last_participant.steam_platforms
      assert_equal 'I wish I was a girly, just like my dear papa.', last_participant.wearing

      sorter.participants.each do |participant|
        assert participant.victim, 'expected participant to have a victim'
        refute_equal participant, participant.victim
      end
    end
  end
end
