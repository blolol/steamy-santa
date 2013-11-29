require 'test_helper'

module SteamySanta
  class MarshalTest < TestCase
    test '.load_participants_from_json' do
      json = StringIO.new(<<-EOJSON)
        {
          "CCP": {
            "email": "ccp@example.com",
            "steam_username": "goeatfood",
            "steam_platforms": [
              "Mac"
            ],
            "wearing": "And now for something completely different!",
            "victim": "Doolan"
          },
          "Doolan": {
            "email": "doolan@example.com",
            "steam_username": "stdoolan",
            "steam_platforms": [
              "Windows"
            ],
            "wearing": "High heels, suspenders and a bra.",
            "victim": "CCP"
          }
        }
      EOJSON

      participants = Marshal.load_participants_from_json(json)

      ccp = participants[0]
      doolan = participants[1]

      assert_equal 'CCP', ccp.nickname
      assert_equal 'ccp@example.com', ccp.email
      assert_equal 'goeatfood', ccp.steam_username
      assert_equal ['Mac'], ccp.steam_platforms
      assert_equal 'And now for something completely different!', ccp.wearing
      assert ccp.victim, 'expected CCP to have a victim'
      assert_equal doolan, ccp.victim

      assert_equal 'Doolan', doolan.nickname
      assert_equal 'doolan@example.com', doolan.email
      assert_equal 'stdoolan', doolan.steam_username
      assert_equal ['Windows'], doolan.steam_platforms
      assert_equal 'High heels, suspenders and a bra.', doolan.wearing
      assert doolan.victim, 'expected Doolan to have a victim'
      assert_equal ccp, doolan.victim
    end
  end
end
