require_relative('CountryNameManager')

class ViewDataController 
	def get_level quantity
		case quantity
			when 0..40
				'LEVEL_4'
			when 41..60
				'LEVEL_3'
			when 61..80
				'LEVEL_2'
			when 81..100
				'LEVEL_1'
			else
				'LEVEL_0'
			end
	end

	def get_ISO3(name)
		return CountryNameManager.new.get_ISO3(name)
	end

	def reduce_data(values)
		red = Hash.new
		values.each do |val|
			red[val.country_partner_iso] = 0	
		end
		values.each do |val|
			red[val.country_partner_iso] += val.quantity
		end	
		return red
	end

	def reduce_data2(values)
		red = Hash.new{|hash, key| hash[key] = Hash.new}
		values.each do |val|
			red[val.country_partner_iso] = Hash.new
			red[val.country_partner_iso][val.article] = 0
		end

		values.each do |val|
			red[val.country_partner_iso][val.article] = val.quantity
		end
		return red
	end

end
