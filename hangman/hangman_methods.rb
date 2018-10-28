module HangmanMethods
	#Selects a random word lowercase between 5 and 12 letters long.
	def pick_word
		words = File.read("words.txt")
		words.split("\n").select { |w| w.length > 4 && w.length < 13}.sample.chomp.downcase
	end
	
	#Returns an array of all the indexes where the letter matches.
	def check_guess(letter, word)
		indexes = []
		word.split("").each_with_index do |l, idx|
			if letter == l
				indexes << idx
			end
		end
		indexes
	end

	def correct_input?(input, letters_used) #returns true if the input is a letter
        	begin
			l = input.to_s.downcase[0]
			return l =~ /[a-z]/ && !letters_used.include?(l)
		rescue
			return false
		end
        end
end
