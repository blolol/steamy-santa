module SteamySanta
  class Participant
    attr_accessor :victim
    attr_reader :nickname, :email, :steam_username, :steam_platforms, :wearing

    def initialize(nickname, email, steam_username, steam_platforms, wearing)
      @nickname = nickname
      @email = email
      @steam_username = steam_username
      @steam_platforms = steam_platforms
      @wearing = wearing
    end

    def to_json
      {
        'email' => email,
        'steam_username' => steam_username,
        'steam_platforms' => steam_platforms,
        'wearing' => wearing,
        'victim' => victim.nickname
      }
    end

    def ==(other)
      nickname == other.nickname
    end
  end
end
