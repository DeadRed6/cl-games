require_relative 'hangman_methods.rb'
require_relative 'savefile.rb'
#TODO: Add option to save to a file every turn.
class Hangman
	include HangmanMethods
	include SaveFile

	def initialize()
		puts "Before we start, do you want to load a save file? (y/n)"
		response = gets.chomp
		if response == "y"
			filename = choose_save # returns false if no saves.
		end

		if filename
			set_game_variables_from_file(filename)
		else
			set_new_game_variables	
		end
	end

	def set_new_game_variables
		@secret_word = pick_word
                @lives_left = 5
                @attempt = []
                @secret_word.length.times {@attempt << "_"}
                @letters_used = []
	end

	def set_game_variables_from_file(filename)
		saved_game = JSON.parse(File.read("saved-games/#{filename}"))
  		@secret_word = saved_game['@secret_word']
		@lives_left = saved_game['@lives_left']
		@attempt = saved_game['@attempt']
		@letters_used = saved_game['@letters_used']
	end

	def play_turn
		puts @attempt.join(" ")
		puts "\n#{@lives_left} lives left."
		puts "Letters used: #{@letters_used}"
		
		loop do
			print "\nEnter your letter or type SAVE. Will repeat until valid. "
			@letter_guess = gets.chomp
			break if correct_input?(@letter_guess, @letters_used)
		end
		if correct_input?(@letter_guess, @letters_used) == "Save"
			puts "What is your name?"
			uname = gets.chomp.split.join("").downcase
			create_new_save(uname, self.to_json)
			puts "Game saved."
			exit
		end	
		response = check_guess(@letter_guess, @secret_word)
		if response == []
			puts "\n\n\nIncorrect! You lose a life."
			@lives_left -= 1
			@letters_used << @letter_guess
		else
			puts "\n\n\nCorrect! Your letter was in the word."
			response.each do |i|
				@attempt[i.to_i] = @letter_guess
			end
			@letters_used << @letter_guess
		end
	end

	def start
		puts "\n\nWelcome to COMMAND LINE HANGMAN!\n\n"
		loop do
			play_turn
			break if @lives_left == 0 || (@attempt.join("") == @secret_word)
		end

		puts @lives_left == 0 ? "You lose." : "You win!."
		puts "The word was #{@secret_word}. Yes, it's a word."
	end
end
