require_relative 'hangman_methods.rb'

class Hangman
	include HangmanMethods
	
	def initialize()
		@secret_word = pick_word
		@lives_left = 5
		@attempt = []
		@secret_word.length.times {@attempt << "_"}
		@letters_used = []
	end

	def play_turn
		puts @attempt.join(" ")
		puts "\n#{@lives_left} lives left."
		puts "Letters used: #{@letters_used}"
		
		loop do
			print "\nEnter your letter. Will repeat until valid. "
			@letter_guess = gets.chomp
			break if correct_input?(@letter_guess, @letters_used)
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
