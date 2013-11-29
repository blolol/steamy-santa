require 'minitest/autorun'
require 'mocha/setup'
require 'stringio'

$:.unshift File.dirname(__FILE__) + '../lib'
require 'steamy_santa'

$:.unshift File.dirname(__FILE__) + '/lib'
require 'steamy_santa/test_case'
