require_relative 'spec_helper'
require './lib/connect_four'

PIECE = '\u2b24'
ARROW = '\u2b07'

describe Board do
	let(:game_board) { Board.new }
	let(:start_board) { [[:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank]] }
	let(:new_board) { [['\u2b07', :blank, :blank, :blank, :blank, :blank], 
						 ['\u2b07', '\u2b24', :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank]] }						 
	let(:full_col_board) { [[:blank, :blank, :blank, :blank, :blank, :blank],
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 ['\u2b07', '\u2b07', '\u2b07', '\u2b07', '\u2b07', '\u2b07'], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank]] }	
	before(:each) do
		allow(game_board).to receive(:puts)
		allow(game_board).to receive(:print)
	end

	describe "#new" do

		context "returns a new game_board" do
			it { expect(game_board).to be_a(Board) }
		end
	end

	describe "#place_piece" do

		context "PIECE placed" do
			it { expect(game_board.place_piece(1,PIECE)).to eql(PIECE)}
			#it { expect(game_board.board).to eql(start_board) }
		end

		context "ARROW placed" do
			it { expect(game_board.place_piece(2,ARROW)).to eql(ARROW)}
		end		
	end

	describe "#board" do

		context "when three game_boards played" do
			before(:each) do
				allow(game_board).to receive(game_board.place_piece(0,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(1,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(1,PIECE)).and_return(PIECE)	
			end

			context "return pieces in correct board position" do
				it { expect(game_board.board).to eql(new_board) }
			end

			context "return no more pieces after 7 pieces in 1 row" do
				game_board = Board.new
				game_board.place_piece(2,ARROW)
				game_board.place_piece(2,ARROW)
				game_board.place_piece(2,ARROW)
				game_board.place_piece(2,ARROW)
				game_board.place_piece(2,ARROW)
				game_board.place_piece(2,ARROW)
				game_board.place_piece(2,ARROW)
				it { expect(game_board.board).to eql(full_col_board) }

			end
		end
	end

	describe "#win_col?" do

		context "return true if column has 4 in a row" do
			game_board = Board.new
			game_board.place_piece(0,ARROW)
			game_board.place_piece(0,ARROW)
			game_board.place_piece(0,ARROW)
			game_board.place_piece(0,ARROW)
			it { expect(game_board.win_col?).to eql(true) }
			it { expect(game_board.win?).to eql(true) }
		end

		context "return true if column has 4 in a row" do
			game_board = Board.new
			game_board.place_piece(1,ARROW)
			game_board.place_piece(1,PIECE)
			game_board.place_piece(1,PIECE)
			game_board.place_piece(1,PIECE)
			game_board.place_piece(1,PIECE)			
			it { expect(game_board.win_col?).to eql(true) }
		end

	end

	describe "#win_row?" do

		context "return false if not 4 in a row" do
			it { expect(game_board.win_row?).to eql(false)}
		end

		context "return true if a row has 4 in a row" do
			game_board = Board.new
			game_board.place_piece(1,ARROW)
			game_board.place_piece(2,ARROW)
			game_board.place_piece(3,ARROW)
			game_board.place_piece(4,ARROW)
			it { expect(game_board.win_row?).to eql(true) }
			it { expect(game_board.win?).to eql(true) }
		end

		context "return true if a row has 4 in a row" do
			game_board = Board.new
			game_board.place_piece(0,ARROW)
			game_board.place_piece(0,PIECE)
			game_board.place_piece(1,PIECE)
			game_board.place_piece(1,PIECE)
			game_board.place_piece(2,ARROW)
			game_board.place_piece(2,PIECE)
			game_board.place_piece(3,ARROW)
			game_board.place_piece(3,PIECE)											
			it { expect(game_board.win_row?).to eql(true) }
			it { expect(game_board.win?).to eql(true) }
		end

	end

	describe "#win_diag?" do

		context "return false if not 4 in a diagonal" do
			it { expect(game_board.win_diag?).to eql(false)}
		end

		context "return true if a diagonal going up/right has 4-in-a-row" do
			game_board = Board.new
			game_board.place_piece(1,PIECE)
			game_board.place_piece(2,ARROW)
			game_board.place_piece(2,ARROW)
			game_board.place_piece(3,PIECE)
			game_board.place_piece(3,PIECE)
			game_board.place_piece(3,ARROW)
			game_board.place_piece(4,ARROW)
			game_board.place_piece(4,PIECE)
			game_board.place_piece(4,PIECE)
			game_board.place_piece(4,ARROW)
			game_board.place_piece(5,ARROW)
			game_board.place_piece(5,PIECE)
			game_board.place_piece(5,PIECE)
			game_board.place_piece(5,ARROW)
			game_board.place_piece(5,ARROW)					
			it { expect(game_board.win_diag?).to eql(true) }
			it { expect(game_board.win?).to eql(true) }
		end

		context "return true if a diagonal going down/left has 4-in-a-row" do
			game_board = Board.new
			game_board.place_piece(0,ARROW)
			game_board.place_piece(0,PIECE)
			game_board.place_piece(0,PIECE)
			game_board.place_piece(0,ARROW)
			game_board.place_piece(1,PIECE)	
			game_board.place_piece(1,PIECE)
			game_board.place_piece(1,ARROW)
			game_board.place_piece(2,ARROW)
			game_board.place_piece(2,ARROW)
			game_board.place_piece(3,ARROW)			
			it { expect(game_board.win_diag?).to eql(true) }
		end		
	end	

	describe "#win?" do
		context "returns false if not 4 in a row" do
			it { expect(game_board.win?).to eql(false)}
		end
	end

	describe "#board_full" do 
			before(:each) do
				allow(game_board).to receive(game_board.place_piece(0,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(0,PIECE)).and_return(ARROW)	
				allow(game_board).to receive(game_board.place_piece(0,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(0,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(0,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(0,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(1,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(1,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(1,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(1,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(1,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(1,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(2,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(2,PIECE)).and_return(ARROW)	
				allow(game_board).to receive(game_board.place_piece(2,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(2,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(2,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(2,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(3,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(3,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(3,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(3,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(3,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(3,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(4,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(4,PIECE)).and_return(ARROW)	
				allow(game_board).to receive(game_board.place_piece(4,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(4,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(4,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(4,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(5,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(5,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(5,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(5,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(5,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(5,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(6,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(6,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(6,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(6,PIECE)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(6,ARROW)).and_return(ARROW)
				allow(game_board).to receive(game_board.place_piece(6,PIECE)).and_return(ARROW)
			end		

			context "game_over over when board full" do
				it { expect(game_board.game_over?).to eql(false)}
			end

	end

end

describe Game do
	let(:game) { Game.new }
	let(:start_board) { [[:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank], 
						 [:blank, :blank, :blank, :blank, :blank, :blank]] }

	before (:each) do
		allow(game).to receive(:puts)
		allow(game).to receive(:print)
		#allow(game.gameboard).to receive(:display_board)
	end

	describe "#new" do

		context "returns a new game" do
			it { expect(game).to be_a(Game) }
		end

		context "returns the game_board's starting board" do
			it { expect(game.gameboard.board).to eql(start_board) }
		end
	end

	describe "#valid_input?" do

		context "rejects non-numbers as input" do
			it { expect(game.valid_input?('hello')).to be false }
		end

		context "rejects negative numbers as input" do
			it { expect(game.valid_input?(-1)).to be false }
		end

		context "rejects numbers > 6 as input" do
			it { expect(game.valid_input?(7)).to be false }
		end		

		context "accepts numbers 0 - 6 as input" do
			it { expect(game.valid_input?(3)).to be true }
		end				
	end

	describe "#get_input" do

		context "does not accept empty response" do
			it do
				allow(game).to receive(:gets).and_return("","2","3")
				expect(game.get_input("Input")).to eq("2")
			end	
		end

		context "accepts all other inputs" do
			it do
				allow(game).to receive(:gets).and_return("yes", "no")
				expect(game.get_input("Input")).to eq("yes")
			end	
		end			
	end

	describe "#play" do

		context "play the game" do
			it do
				allow(game).to receive(:get_input).and_return(1,2,1,2,1,2,1,2)
				#expect(game).to receive(:win?) #.and_call_original(7).times
				game.play
			end	
		end		

	end

#	describe "#get_valid_response" do
#
#		context "returns a valid response" do
#			it { expect(game.get_valid_response("Hello")).to eql('') }
#		end

	#	context "returns the game_board's starting board" do
	#		it { expect(game.gameboard.board).to eql(start_board) }
	#	end
	#end	
end