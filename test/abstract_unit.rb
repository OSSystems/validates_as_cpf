require File.dirname(__FILE__) + '/../../../../config/environment'

$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'test/unit'
require 'active_record'
require File.dirname(__FILE__) + '/connection'
