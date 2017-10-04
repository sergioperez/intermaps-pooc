require 'logger'

class CountryEntry
  def initialize_from_arguments(year, month, country_report, country_report_iso,
									article, weight_unit, country_partner, country_partner_iso,
									value, quantity)
		@year = year.to_i
		@month = month.to_i
		@country_report = country_report
		@country_report_iso = country_report_iso
		@article = article
		@weight_unit = weight_unit[0]
		@country_partner = country_partner
		@country_partner_iso = country_partner_iso
		@value = value
		@quantity = quantity
  end

	def get_data
		{	"year"								=>	@year,
			"month"								=>	@month,
			"country_report"			=>	@country_report,
			"country_report_iso"	=>	@country_report_iso,
			"article"							=>	@article,
			"weight_unit"					=>	@weight_unit,
			"country_partner"			=>	@country_partner,
			"country_partner_iso"	=>	@country_partner_iso,
			"value"								=>	@value,
			"quantity"						=>	@quantity }
	end

	def year
		@year
	end

	def month
		@month
	end

	def country_report
		@country_report
	end

	def country_report_iso
		@country_report_iso
	end

	def article
		@article
	end

	def weight_unit
		@weight_unit
	end

	def country_partner
		@country_partner
	end

	def country_partner_iso
		@country_partner_iso
	end

	def value
		@value
	end

	def quantity
		@quantity
	end

	def initialize(csv_row)
		if(csv_row == nil)
			return
		end
		if csv_row.class == CSV::Row
			year            = csv_row["Año"]
			month           = csv_row["Mes"]
			country_report  = csv_row[" País Reportante"]
			country_report_iso = csv_row["ISO"]
			article         = csv_row["Artículo"]
			unit            = csv_row["Unidad"]
			country_partner = csv_row["País Socio"]
			#TODO: Chapuza
			country_partner_iso = csv_row[6]
			value           = csv_row["Valor"]
			quantity        = csv_row["Cantidad"]
			initialize_from_arguments(year, month, country_report, country_report_iso,
									article, unit, country_partner, country_partner_iso,
									value, quantity)
		else
			logger = Logger.new("./log/CountryEntry.log")
			logger.error "Trying to parse something that is not a CSV row as a CSV row"
		end
	end

  def print
    puts "Year:\n\t#{@year}"
    puts "Month:\n\t#{@month}"
    puts "Reportant Country:\n\t#{@country_report} ISO:[#{country_report_iso}]"
    puts "Article:\n\t#{@article}"
    puts "Unit:\n\t#{@unit}"
    puts "Partner country:\n\t#{@country_partner} ISO:[#{country_partner_iso}]"
    puts "Value:\n\t#{@value}"
    puts "Quantity:\n\t#{@quantity}"
  end

end

