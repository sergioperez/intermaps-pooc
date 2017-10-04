#TODO:
#	unit = char?
#
# Reqs: Ruby >= 1.9.1

require 'csv'
require_relative 'lib/CountryDBManager.rb'
require_relative 'lib/CountryEntry.rb'

DEBUG = true

exporter = CountryDBManager.new()
exporter.export_csv("./csv/reduced.csv")
