require "json"

module SaveFile
	#overrides the default method
	def to_json
		hash = {}
		self.instance_variables.each do |var|
			hash[var] = self.instance_variable_get var
		end
		hash.to_json
	end

	def create_new_save(name, json)
		current_time = Time.now
		filename = name + current_time.strftime("%Y%m%d-%H:%S") + ".json"
		file = File.open("saved-games/#{filename}", "w")
		file.puts json
		file.close
	end

	def choose_save
		files = Dir.entries("saved-games/")
		if files != [] && files.length != 2
			puts "Select the number of the file you want to load: "
			files[2..files.length].each_with_index do |fn, idx|
				puts "#{idx}: #{fn}"
			end
			response = gets.chomp[0].to_i
			return files[response] 
		else
			puts "No saves to load."
			return false
		end
	end
end

include SaveFile
