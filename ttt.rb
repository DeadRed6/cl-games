class GameBoard
	attr_accessor :grid

	def initialize
		@grid = [["-", "-", "-"], 
			["-", "-", "-"], 
			["-", "-", "-"]]
	end

	def show_grid
		print "\nCurrent Game Board:"
		@grid.each do |r|
			puts "\n"
			print "#{r[0]}  #{r[1]}  #{r[2]}"
		end	
		puts "\n"
	end

	def move(chr)
		puts "Player #{chr}'s move."
		puts "Select your position in the format (row column) e.g. 1 1"
		player_move = gets.chomp.split(" ")
		while !valid_move?(player_move[0], player_move[1]) do
			puts "Invalid move. Try again."
			player_move = gets.chomp.split(" ")
		end
		@grid[player_move[0].to_i - 1][player_move[1].to_i - 1] = chr
	end
	
	def valid_move?(r, c)
		r_valid = Integer(r) rescue false
		c_valid = Integer(c) rescue false
		
		return false if !r_valid || !c_valid
		return false if !r.to_i.between?(1, 3) || !c.to_i.between?(1, 3)
		return false if @grid[r.to_i - 1][c.to_i - 1] != "-"
		return true
	end

	def game_over?
		#check rows
		@grid.each do |r|
			return true if winning_vector?(r)
		end
		
		#check columns
		0.upto(2) do |i|
			c = []
			@grid.each { |r| c.push(r[i]) }
			return true if winning_vector?(c)
		end

		#check diagonals
		d1 = []
		0.upto(2) { |i| d1.push(@grid[i][i]) }
		return true if winning_vector?(d1)

		d2 = []
		0.upto(2) { |i| d2.push(@grid[2-i][i]) }
		return true if winning_vector?(d2)
	end
	
	private
	def winning_vector?(arr)
		return true if arr.count("X") == 3 or arr.count("O") == 3
		return false
	end
end

game1 = GameBoard.new
move_count = 0
while move_count < 9 do
	game1.show_grid
	if move_count % 2 == 0
		game1.move("X")
	else
		game1.move("O")
	end
	if game1.game_over?
		puts "You win, player #{move_count % 2 == 0 ? "X" : "O"}!"
		exit
	end
	move_count += 1
end

game1.show_grid
puts "Game ended in a draw."
