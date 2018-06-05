module SteamySanta
  class TestCase < Minitest::Test
    private

    def fixture(name)
      path = File.expand_path(File.join(File.dirname(__FILE__), "../../fixtures/#{name}"))
      File.read(path)
    end
  end
end
