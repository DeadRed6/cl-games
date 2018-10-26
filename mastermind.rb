class Mastermind
	def initialize
		@colours = ["P", "R", "G", "Y", "B", "O"]
		@code = @colours.sample(4) #creates an array of random colours
		@guesses_remaining = 12
		@game_over = false
	end

	def start
		while true
			player_make_guess
		end
	end

	def player_make_guess
		puts "\nYou have #{@guesses_remaining} guesses left."
		puts "Colours available: #{@colours.join(" ")}"
		puts "Make your choice in the format (1234) using the letters."
		player_guess = gets.chomp
		until valid_guess?(player_guess)
			puts "Invalid choice, please try again."
			player_guess = gets.chomp
		end
		puts "\nComputer response: #{cpu_master_response(player_guess.split(""))}"
		@guesses_remaining -= 1
		exit if(@guesses_remaining == 0 || @game_over)
	end

	def valid_guess?(g)
		return false if g.length != 4
		g.each_char do |l|
			return false if !@colours.include?(l)
		end
	end

	def cpu_master_response(g) #receives an array
		return player_wins if @code == g
		correct_colour = 0
		correct_position = 0
		for i in 0..3 do
   			if g[i] == @code[i]
				correct_position += 1
			else
				correct_colour += 1
			end
		end
		return "#{correct_position} exact. #{correct_colour} partial."
	end

	def player_wins
		@game_over = true
		return "Congratulations! You won!"
	end
end	

game = Mastermind.new
game.start
