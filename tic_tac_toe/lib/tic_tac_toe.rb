class Player
  def initialize(name)
	@name = name
  end
end

class Board
  attr_accessor :player1, :player2, :board

  def initialize(player1, player2, board)
	@player1 = Player.new(player1)
	@player2 = Player.new(player2)
	@board = board
  end

  def board
    @board
  end

  # Show the Tic Tac Board
  def show_board                 
   	puts
   	puts " #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}"
   	puts "-----------"
   	puts " #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}"
   	puts "-----------"
   	puts " #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}"
   	puts
  end

  # Player choose a spot for their token.
  def go(player, token)
	  puts "#{player} select a spot on the board by typing in its number:"
	  ans = gets.chomp.to_i
    set_move(ans, token)
  end

  def set_move(pos, token)
    @board.each do |row|
      row.map! { |x| x == pos ? token : x }
    end
  end

  def victory?
	if check_rows || check_columns || check_diagonals || board_full
	  print "Game over. "
	  true
	end
  end

  def board_full
	if check_board
  	  puts "It's a draw."
	  true
	end
  end

  def check_board
	@board.all? do |row|
	  row.all? do |num|
		(num == "X") || (num == "O")
	  end
	end
  end

  def check_columns
  	col = []
  	# Checks if each row is all X's or all O's. Adds answers to Array col.
  	for i in 0..2
  		col << (@board.all? { |row| row[i] == 'X' } ||
				@board.all? { |row| row[i] == 'O' })
  	end
  	col.include?(true)
  end

  def check_rows
	@board.any? do |row|
	  (row == ['X','X','X']) || (row == ['O','O','O'])
	end
  end

  def check_diagonals
	diag1_x = @board[0][0] == 'X' && @board[1][1] == 'X' && @board[2][2] == 'X'
	diag1_o = @board[0][0] == 'O' && @board[1][1] == 'O' && @board[2][2] == 'O'
	diag2_x = @board[0][2] == 'X' && @board[1][1] == 'X' && @board[2][0] == 'X'
	diag2_o = @board[0][2] == 'O' && @board[1][1] == 'O' && @board[2][0] == 'O'		
	diag1_x || diag1_o || diag2_x || diag2_o
  end
end

victory = false

#puts "Enter name of player 1:"
#player1 = gets.chomp.to_s
#player1 = "Marty"
#puts "Enter name of player 2:"
#player2 = gets.chomp.to_s
#player2 = "Angelica"

#player = ['player2','player1','player2','player1','player2','player1','player2','player1','player2','player1','player2','player1']
#token = ['O','X','O','X','O','X','O','X','O','X','O','X']

#game = Board.new(player1, player2, [[0,1,2],[3,4,5],[6,7,8]])

#while !victory
#  game.show_board
#  game.go(player.pop, token.pop)
#  game.show_board
#  victory = game.victory?	
#end

#puts "Play again?"