#require 'uri'
#require 'open-uri'
require 'bundler/setup'
Bundler.require

#require_relative 'lib/credentials'
require_relative 'lib/driver'
require_relative 'lib/business'

#credentials = Credentials.new
#credentials.validate!

Driver.configure

business = Business.new

#p business.windows
#puts mint_exporter.csv
