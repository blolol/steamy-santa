module SteamySanta
  class << self
    def settings
      if @settings
        @settings
      else
        settings_path = File.dirname(__FILE__) + '/../../config/settings.json'

        File.open(settings_path, 'r') do |io|
          @settings = JSON.parse(io.read, symbolize_names: true)
        end
      end
    end
  end

  module Settings
    def settings
      SteamySanta.settings
    end
  end
end
