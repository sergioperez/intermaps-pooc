require 'pg'
require 'sequel'

class CountryNameManager
	def get_countries 
		db = Sequel.postgres(DB_NAME, :user => DB_UNAME, :password => DB_PASSWD, :host => DB_IP)
		dataset = db[:countries]
		return dataset
	end

	def get_ISO3(name)
		return name if name.length == 3
	
		dataset = get_countries
		return dataset.where('alpha2 = ?', name).first[:alpha3]
	end

	def get_ISO2(name)
		return name if name.length == 2

		dataset = get_countries
		return dataset.where('alpha3 = ?', name).first[:alpha2]
	end

	def get_name(iso)
		return iso if iso.length != 3 && iso.length != 2

		dataset = get_countries
		if iso.length == 2
			return dataset.where('alpha2 = ?', iso).first[:langes]
		elsif iso.length == 3
			return dataset.where('alpha3 = ?', iso).first[:langes]
		end
	end
end
