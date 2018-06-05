require 'test_helper'

module SteamySanta
  class ParticipantTest < TestCase
    def test_creating_a_participant
      participant = Participant.new('Raws', 'raws@example.com', 'rawsosaurus', %w(Mac Windows),
        'High heels, suspenders and a bra.')

      assert_equal 'Raws', participant.nickname
      assert_equal 'raws@example.com', participant.email
      assert_equal 'rawsosaurus', participant.steam_username
      assert_equal %w(Mac Windows), participant.steam_platforms
      assert_equal 'High heels, suspenders and a bra.', participant.wearing

      other_participant = :stubbed_participant
      participant.victim = other_participant

      assert_equal :stubbed_participant, participant.victim
    end

    def test_comparing_participants
      participant = Participant.new('Raws', 'raws@example.com', 'rawsosaurus', %w(Mac Windows),
        'High heels, suspenders and a bra.')
      equal_participant = Participant.new('Raws', 'raws2@example.com', 'rawsosaurus2', %w(Mac), 'Merino wool.')
      different_participant = Participant.new('Doolan', 'raws@example.com', 'rawsosaurus', %w(Mac Windows),
        'High heels, suspenders and a bra.')

      assert_equal participant, equal_participant
      refute_equal participant, different_participant
    end

    def test_view_binding
      participant = Participant.new('Raws', 'raws@example.com', 'rawsosaurus', %w(Mac Windows),
        'High heels, suspenders and a bra.')

      assert_instance_of Binding, participant.view_binding
    end

    def test_to_json
      participant = Participant.new('Raws', 'raws@example.com', 'rawsosaurus', %w(Mac Windows),
        'High heels, suspenders and a bra.')
      victim = Participant.new('Doolan', 'raws@example.com', 'rawsosaurus', %w(Mac Windows),
        'High heels, suspenders and a bra.')
      participant.victim = victim

      expected_json = {
        'email' => 'raws@example.com',
        'steam_username' => 'rawsosaurus',
        'steam_platforms' => ['Mac', 'Windows'],
        'wearing' => 'High heels, suspenders and a bra.',
        'victim' => 'Doolan'
      }

      assert_equal expected_json, participant.to_json
    end
  end
end
