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

      sorter.participants.each do |participant|
        assert participant.nickname, 'expected participant to have a nickname'
        assert participant.email, 'expected participant to have an email address'
        assert participant.steam_username, 'expected participant to have a Steam username'
        assert participant.steam_platforms, 'expected participant to have Steam platforms'
        assert participant.wearing, 'expected participant to be wearing something'
        assert participant.victim, 'expected participant to have a victim'
        refute_equal participant, participant.victim
      end
    end

    test '#to_json' do
      ccp = Participant.new('CCP', 'ccp@example.com', 'goeatfood', %w(Mac),
        'And now for something completely different!')
      doolan = Participant.new('Doolan', 'doolan@example.com', 'stdoolan', %w(Windows),
        'High heels, suspenders and a bra.')
      raws = Participant.new('Raws', 'raws@example.com', 'rawsosaurus', %w(Mac Windows),
        'I wish I was a girly, just like my dear papa.')

      ccp.victim = doolan
      doolan.victim = raws
      raws.victim = ccp

      participants = [ccp, doolan, raws]

      sorter = Sorter.new('')
      sorter.stubs(:participants).returns(participants)

      expected_json = {
        'CCP' => {
          'email' => 'ccp@example.com',
          'steam_username' => 'goeatfood',
          'steam_platforms' => ['Mac'],
          'wearing' => 'And now for something completely different!',
          'victim' => 'Doolan'
        },
        'Doolan' => {
          'email' => 'doolan@example.com',
          'steam_username' => 'stdoolan',
          'steam_platforms' => ['Windows'],
          'wearing' => 'High heels, suspenders and a bra.',
          'victim' => 'Raws'
        },
        'Raws' => {
          'email' => 'raws@example.com',
          'steam_username' => 'rawsosaurus',
          'steam_platforms' => ['Mac', 'Windows'],
          'wearing' => 'I wish I was a girly, just like my dear papa.',
          'victim' => 'CCP'
        }
      }

      assert_equal expected_json, sorter.to_json
    end
  end
end
