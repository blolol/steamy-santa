module SteamySanta
  class << self
    def settings
      if @settings
        @settings
      else
        settings_path = File.join(File.dirname(__FILE__), '../../config/settings.json')
        @settings = JSON.parse(File.read(settings_path), symbolize_names: true)
      end
    end
  end

  module Settings
    def settings
      SteamySanta.settings
    end
  end
end
