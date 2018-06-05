require 'minitest/autorun'
require 'mocha/setup'
require 'stringio'

$:.unshift File.dirname(__FILE__) + '../lib'
require 'steamy_santa'

$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'steamy_santa/test_case'

settings_path = File.join(File.dirname(__FILE__), '../config/settings.example.json')
settings = JSON.parse(File.read(settings_path), symbolize_names: true)
SteamySanta.instance_variable_set(:@settings, settings)
