require_relative 'CountryEntry.rb'
require_relative 'CountryNameManager.rb'
require 'logger'
require 'sequel'
require 'pg'

#TODO: No debería tenerlo en varios ficheros a la vez, esto debería estar en un fichero de configuración 

class CountryDBReader
	def get_data(type, article, since_year, since_month, until_year, until_month, country)
		country_name = CountryNameManager.new.get_ISO2(country)

		db = Sequel.postgres(DB_NAME, :user => DB_UNAME, :password => DB_PASSWD,
													 :host => DB_IP)

		#dataset = db[type.to_sym].where('year >= ?', since_year).where('year <= ?', until_year).where
		year_range = since_year.to_i .. until_year.to_i

		#TODO: Pasar mes/año a DATE solucionaría esto, pero, probamos el rendimiento con tres queries
		#TODO: Todavía no tenemos en cuenta los artículos
		
		dataset = ((db[type.to_sym].where('country_from = ?', country_name).where('year > ?', since_year.to_i).where('year < ?', until_year.to_i)).union(db[type.to_sym].where('year = ?', since_year.to_i).where('month >= ?', since_month.to_i)).union(db[type.to_sym].where('year = ?', until_year.to_i).where('month <= ?', until_month))).where('article = ?', article)



		entries = Array.new
		dataset.each do |row|
			e = CountryEntry.new(nil)
			#TODO: Quitamos NIU? (not in use)
			e.initialize_from_arguments(row[:year], row[:month], "NIU", row[:country_from],
																		row[:article], row[:weight_unit], "NIU",
																		row[:country_to], row[:val], row[:quantity])
			entries << e
		end

		return entries
	end
end

