original = Array.new

class Cosa
	def initialize(name, val)
		@name = name
		@val = val
	end

	def name
		@name
	end

	def val
		@val
	end
end

original << Cosa.new("sergio", 8)
original << Cosa.new("sergio", 10)
original << Cosa.new("sergio", 3)
original << Cosa.new("irene", 10)
original << Cosa.new("irene", 7)

red = Hash.new

original.each do |entry|
	red[entry.name] = 0
end
original.each do |entry|
	red[entry.name] += entry.val
end
puts red
