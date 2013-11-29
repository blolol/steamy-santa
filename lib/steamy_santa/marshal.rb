module SteamySanta
  module Marshal
    def self.load_participants_from_json(io)
      json = JSON.parse(io.read)

      participants = json.map do |nickname, details|
        email = details['email']
        steam_username = details['steam_username']
        steam_platforms = details['steam_platforms']
        wearing = details['wearing']

        participant = Participant.new(nickname, email, steam_username, steam_platforms, wearing)
        participant.victim = details['victim']
        participant
      end

      participants.each do |participant|
        victim = find_participant_by_nickname(participants, participant.victim)
        participant.victim = victim
      end

      participants
    end

    private

    def self.find_participant_by_nickname(participants, nickname)
      participants.find do |participant|
        participant.nickname == nickname
      end
    end
  end
end
