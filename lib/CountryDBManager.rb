=begin
	Esta librería se utiliza para realizar las escrituras en la base de datos
		Uso:
			import_csv(ruta_del_csv, tipo)	; tipo puede ser 'imports' o 'exports'
																				(sin comillas)
=end

require_relative 'CountryEntry.rb'
require 'logger'
require 'sequel'
require 'pg'

#TABLE_NAME : imports 

class CountryDBManager
	#This is the only class that should be called from the outside
	#Type must be imports or exports
	def import_csv(csv_path, type)
		csv_txt = File.read(csv_path, :encoding => 'ISO8859-1').encode("UTF-8")
		csv = CSV.parse(csv_txt, :headers => true )

		entries = Array.new

		csv.each do |row|
			#Creating instance for the entry
			entries << CountryEntry.new(row)
		end	

		store_entries(entries, type)

	end

	def store_entries(entries_array, type)
		if entries_array.class == Array
			#Connecting to the DB
			db = Sequel.postgres(DB_NAME, :user => DB_UNAME, :password => DB_PASSWD, 
																	:host => DB_IP)
	
			dataset = db[type.to_sym]
			#Ejemplo de entrada en norepeatset [201412ESKO]
			norepeatset = db["#{type}_collisions".to_sym]

			entries_array.each do |entry| 
				#entry.print
				#puts entry.year
				#TODO:Añadir entry.article => requeriría cambiar el valor del campo en la base de datos //IDEA:Hash 
				if norepeatset.insert(:hash => "#{entry.year}#{entry.month}#{entry.country_report_iso}#{entry.country_partner_iso}")
					dataset.insert(:year => entry.year,
										:month => entry.month,
										:country_from => entry.country_report_iso,
										:article => entry.article,
										:weight_unit => entry.weight_unit,
										:country_to => entry.country_partner_iso,
										:val => entry.value,
										:quantity => entry.quantity)
				else
					#TODO: Quizás vendría bien poner un logger aquí
					puts "Estás intentando importar datos que ya están en la BBDD"
				end
			end

			#dataset.insert

		else
			logger = Logger.new("./log/CountryDBManagerArray.log")
			logger.error "Trying to travel across something which is not an Array"
		end
	end

	#Unused, delete
	def store_entry(centry)
		if centry.class == CountryEntry
			#TODO: database stuff
			
			#puts centry.year
		else
			logger = Logger.new("./log/CountryDBManager.log")
			logger.error "Trying to store something which is not a country entry"
		end
	end

	private :store_entries, :store_entry
end
