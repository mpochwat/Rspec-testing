require_relative 'spec_helper'
require './lib/caesar_cipher'

describe "caesar_cipher" do
	
	context "when empty string is provided" do
		it { expect(caesar_cipher('',1)).to eq("") }
	end

	context "returns 'Tqxxa iadxp' for string 'Hello world' shifted by 12" do
		it { expect(caesar_cipher('Hello world',12)).to eq('Tqxxa iadxp') }
	end	

	context "returns 'Fcjjm umpjb' for string 'Hello world' shifted by -2" do
		it { expect(caesar_cipher('Hello world',-2)).to eq('Fcjjm umpjb') }
	end	

	context "returns same string when shifted by 0" do
		it { expect(caesar_cipher('Hello world',0)).to eq('Hello world') }
	end	

	context "returns same string when shifted by 26" do
		it { expect(caesar_cipher('Hello world',26)).to eq('Hello world') }
	end	

	context "returns new string when shifted by 122" do
		it { expect(caesar_cipher('Hello world',122)).to eq('Zwddg ogjdv') }
	end	

	context "returns new string when shifted by -27" do
		it { expect(caesar_cipher('Hello world',-27)).to eq('Gdkkn vnqkc') }
	end	

	context "returns new string when shifted by -122" do
		it { expect(caesar_cipher('Hello world',-122)).to eq('Pmttw ewztl') }
	end				

end