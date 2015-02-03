require_relative 'spec_helper'
require './lib/tic_tac_toe'

describe Board do
	let(:game) { Board.new("Martin", "Angelica", [[0,1,2],[3,4,5],[6,7,8]]) }
	before(:each) do
		allow(game).to receive(:puts)
		allow(game).to receive(:print)
	end

	describe "#show_board" do

		context "returns nil since shows board using puts" do
			it { expect(game.show_board).to eq(nil)}
		end
	end

	describe "#check_columns" do

		context "return false if not columns win" do
			it {expect(game.check_columns).to eq(false)}
			it {expect(game.victory?).to eq(nil)}
		end

		context "return true if column 1 wins" do
			game = Board.new("Martin", "Angelica", [['X','X','O'],['X','4','O'],['X',7,8]])
			it {expect(game.check_columns).to eq(true)}
			it {expect(game.victory?).to eq(true)}
		end		

		context "return true if column 2 wins" do
			game = Board.new("Martin", "Angelica", [[0,'O',2],[3,'O',5],[6,'O',8]])
			it {expect(game.check_columns).to eq(true)}
			it {expect(game.victory?).to eq(true)}
		end	

		context "return true if column 3 wins" do
			game = Board.new("Martin", "Angelica", [[0,'O','X'],[3,4,'X'],[6,'O','X']])
			it {expect(game.check_columns).to eq(true)}
			it {expect(game.victory?).to eq(true)}
		end									
	end

	describe "#check_rows" do

		context "return false if no row win" do
			it {expect(game.check_rows).to eq(false)}
			it {expect(game.victory?).to eq(nil)}
		end

		context "return true if row 1 wins" do
			game = Board.new("Martin", "Angelica", [['X','X','X'],['X',4,'O'],['O',7,8]])
			it {expect(game.check_rows).to eq(true)}
			it {expect(game.victory?).to eq(true)}
		end		

		context "return true if row 2 wins" do
			game = Board.new("Martin", "Angelica", [[0,'X',2],['O','O','O'],['X','X',8]])
			it {expect(game.check_rows).to eq(true)}
			it {expect(game.victory?).to eq(true)}
		end	

		context "return true if row 3 wins" do
			game = Board.new("Martin", "Angelica", [[0,'O','O'],[3,4,'O'],['X','X','X']])
			it {expect(game.check_rows).to eq(true)}
			it {expect(game.victory?).to eq(true)}
		end									
	end	

	describe "#check_diagonals" do

		context "return false if no diag wins" do
			it {expect(game.check_diagonals).to eq(false)}
			it {expect(game.victory?).to eq(nil)}
		end

		context "return true if diag 1 wins" do
			game = Board.new("Martin", "Angelica", [['X','X','X'],['O','X','O'],['O',7,'X']])
			it {expect(game.check_diagonals).to eq(true)}
			it {expect(game.victory?).to eq(true)}
		end		

		context "return true if diag 2 wins" do
			game = Board.new("Martin", "Angelica", [[0,'X','O'],[3,'O','X'],['O','X',8]])
			it {expect(game.check_diagonals).to eq(true)}
			it {expect(game.victory?).to eq(true)}
		end	

	end	

	describe "#check_board" do

		context "return false if game board starting position" do
			it {expect(game.check_board).to eq(false)}
			it {expect(game.victory?).to eq(nil)}
		end

		context "return false if game board full" do
			game=Board.new("Martin", "Angelica", [['X','O',2],['X','X','O'],['O','X','X']])
			it {expect(game.check_board).to eq(false)}
		end

		context "return true if game board full" do
			game=Board.new("Martin", "Angelica", [['X','O','X'],['X','X','O'],['O','X','X']])
			it {expect(game.check_board).to eq(true)}
		end
	end

	describe "#set_move" do

		context "return new board with 'X' in 0 position" do
			it {expect(game.set_move(0,'X')).to eq([["X", 1, 2], [3, 4, 5], [6, 7, 8]])}
		end

		context "return updated board with 'O' in 4 position" do
			it {expect(game.set_move(4,'O')).to eq([[0, 1, 2], [3, 'O', 5], [6, 7, 8]])}
		end		

	end		

end