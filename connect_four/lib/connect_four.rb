ARROW = '\u2b07'
PIECE = '\u2b24'
class Game
	PIECE = '\u2b24'
	ARROW = '\u2b07'

	attr_reader :gameboard

	def initialize
		@gameboard = Board.new
	end

	def valid_input?(input)
		if input.is_a?(String) || input < 0 || input > 6
			false
		else 
			true
		end
	end	

	def get_input(prompt)
		loop do
			print prompt + ": "
			input = gets.chomp
			return input unless input.empty?
		end
	end

	def play
		player = [1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2]
		token = [PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW, PIECE, ARROW]
		while !gameboard.win?
			input = get_input("Player #{player.shift}, select a column to drop your token")
			if valid_input?(input.to_i)
				gameboard.place_piece(input.to_i, token.shift)
				gameboard.show_board
			end
		end
		gameboard.show_board
		puts ""
	end

end

class Board
	ROWS, COLS = 6,7
	PIECE = '\u2b24'
	ARROW = '\u2b07'

	attr_reader :board

	def initialize
		@four_pieces = [PIECE, PIECE, PIECE, PIECE]
		@four_arrows = [ARROW, ARROW, ARROW, ARROW]
		clear_board
	end

	# Make board full of blank spaces
	def clear_board
		@board = []
		COLS.times do 
			blank_col = []
			ROWS.times { blank_col << :blank }
			@board << blank_col
		end
	end

    # Display the game board
	def show_board
		puts "Choose column to place a piece by the numbers below"
		puts "\t" + " 1   2   3   4   5   6   7"
		puts "\t" + (" #{ARROW}  " * COLS)

		(ROWS - 1).downto(0) do |row|
			print "\t"
			0.upto(COLS - 1) { |col| print color(" #{PIECE}  ", @board[col][row]) }
			puts "\n\t" + color(" " * (4 * COLS), :blank)
		end
	end

  # Color is expected as a symbol. Eg :yellow or :red
	def color(text, color)
		case color
		when :red then colorize(text, "1;31;44")
		when :yellow then colorize(text, "1;33;44")
		when :flip then colorize(text, "7")
		when :blank then colorize(text, "1;34;44")
		else colorize(text, "0")
		end
	end

	# Color code is expected. Eg "1;34;44"
	def colorize(text, color_code)
		"\033[#{color_code}m#{text}\033[0m"
	end	

	def place_piece(col, piece)
		first_blank_index = @board[col].index(:blank)
		@board[col][first_blank_index] = piece unless first_blank_index.nil?
	end

	def win_col?
		@board.any? do |col|
			col[0..3] == @four_pieces ||
			col[0..3] == @four_arrows || 
			col[1..4] == @four_pieces ||
			col[1..4] == @four_arrows ||
			col[2..5] == @four_pieces ||
			col[2..5] == @four_arrows
		end
	end

	def row_check(row)
		if (row[0..3] == @four_pieces ||
			row[0..3] == @four_arrows || 
			row[1..4] == @four_pieces ||
			row[1..4] == @four_arrows ||
			row[2..5] == @four_pieces ||
			row[2..5] == @four_arrows ||
			row[3..6] == @four_pieces ||
			row[3..6] == @four_arrows    )	
			true	
		else
			false	
		end
	end	

	# Checks if there are 4 in-a-row in all rows
	def win_row?
		result = false

		row = []
		row_num = [0,1,2,3,4,5,6]
		# Builds an array of single row, then checks if 4-in-a-row
		while !result && !row_num.empty?
			i = row_num.shift
			@board.each do |col|
				row << col[i]
			end
			result = row_check(row)
			row = []
		end
		result
	end

	def diag_check(diag)
		if diag.length == 4
			if (diag[0..3] == @four_pieces ||
				diag[0..3] == @four_arrows   )
				true
			else
				false
			end

		elsif diag.length == 5
			if (diag[0..3] == @four_pieces ||
				diag[0..3] == @four_arrows || 
				diag[1..4] == @four_pieces ||
				diag[1..4] == @four_arrows
				)
				true
			else
				false
			end

		else
			if (diag[0..3] == @four_pieces ||
				diag[0..3] == @four_arrows || 
				diag[1..4] == @four_pieces ||
				diag[1..4] == @four_arrows ||
				diag[2..5] == @four_pieces ||
				diag[2..5] == @four_arrows 				
				)
				true
			else
				false
			end	
		end
	end

	def win_diag?
		result = []

		# Collects all diagonals going up/right. Starting at left-most diagonal
		diag = []
		diag.push(@board[0][3]).push(@board[1][2]).push(@board[2][1]).push(@board[3][0])
		result << diag_check(diag)
		diag = []	
		diag.push(@board[0][4]).push(@board[1][3]).push(@board[2][2]).push(@board[3][1]).push(@board[4][0])
		result << diag_check(diag)
		diag = []
		diag.push(@board[0][0]).push(@board[1][1]).push(@board[2][2]).push(@board[3][3]).push(@board[4][4]).push(@board[5][5])
		result << diag_check(diag)
		diag = []	
		diag.push(@board[1][0]).push(@board[2][1]).push(@board[3][2]).push(@board[4][3]).push(@board[5][4]).push(@board[6][5])
		result << diag_check(diag)
		diag = []
		diag.push(@board[2][0]).push(@board[3][1]).push(@board[4][2]).push(@board[5][3]).push(@board[6][4])
		result << diag_check(diag)
		diag = []
		diag.push(@board[3][0]).push(@board[4][1]).push(@board[5][2]).push(@board[6][3])
		result << diag_check(diag)	

		# Collects all diagonals going down/left.. Starting at left-most diagonal
		diag = []
		diag.push(@board[0][2]).push(@board[1][3]).push(@board[2][4]).push(@board[3][5])
		result << diag_check(diag)
		diag = []	
		diag.push(@board[0][1]).push(@board[1][2]).push(@board[2][3]).push(@board[3][4]).push(@board[4][5])
		result << diag_check(diag)
		diag = []
		diag.push(@board[0][5]).push(@board[1][4]).push(@board[2][3]).push(@board[3][2]).push(@board[4][1]).push(@board[5][0])
		result << diag_check(diag)
		diag = []	
		diag.push(@board[1][5]).push(@board[2][4]).push(@board[3][3]).push(@board[4][2]).push(@board[5][1]).push(@board[6][0])
		result << diag_check(diag)
		diag = []
		diag.push(@board[2][5]).push(@board[3][4]).push(@board[4][3]).push(@board[5][2]).push(@board[6][1])
		result << diag_check(diag)
		diag = []
		diag.push(@board[3][5]).push(@board[4][4]).push(@board[5][3]).push(@board[6][2])
		result << diag_check(diag)					

		if result.include?(true)
			true
		else
			false
		end
	end

	def win?
		if win_col? || win_row? || win_diag? || game_over?
			true
		else
			false
		end
	end

	def game_over?
		@board.include?(:blank)
	end
end

#game = Game.new
#game.play