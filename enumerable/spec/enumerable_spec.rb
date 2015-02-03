require_relative 'spec_helper'
require './lib/enumerable'

describe "Enumerable" do
	describe "#my_each" do

		context "returns empty array when empty array called" do
			it { expect([].my_each { |num| num**2 }).to eq([]) }
		end

		context "returns same array when called on an array" do
			it { expect([1,2,3].my_each { |num| num**2 }).to eq([1,2,3]) }
		end		
	end

	describe "#my_select" do

		context "returns empty array when called on empty array" do
			it { expect([].my_select {} ).to eq([]) }
		end

		context "returns [2,4]" do
			it { expect([1,2,3,4].my_select { |num| num%2==0 } ).to eq([2,4]) }
		end
	end

	describe "#my_any?" do

		context "returns true since a number in array is <5" do
			it { expect([10,9,8,4,5].my_any? { |num| num<5 }).to eq(true) }
		end

		context "returns false since a number in array is not <5" do
			it { expect([1,2,3,4,5].my_any? { |num| num<5 }).to eq(true) }
		end
	end

	describe "#my_count" do

		context "returns 3 since 3 numbers in array are greater than 2" do
			it { expect([1,2,3,4,5].my_count { |num| num >2 }).to eq(3)}
		end

		context "returns 0 since 0 numbers in array are greater than 5" do
			it { expect([1,2,3,4,5].my_count { |num| num >5 }).to eq(0)}
		end		
	end

	describe "#my_map" do

		context "returns array of squares of input array" do
			it { expect([1,2,3].my_map { |num| num**2 }).to eq([1,4,9])}
		end

		context "returns array of cubes of input array" do
			test = Proc.new {|num| num ** 3 }
			it { expect([1,2,3].my_map(&test)).to eq([1,8,27])}
		end
	end

	describe "#my_inject" do

		context "returns array of squares of input array" do
			it { expect([5,6,7,8].inject { |result_memo, object| result_memo + object }).to eq(26)}
		end

		context "returns array of squares of input array" do
			test = Proc.new {|num| num ** 3 }
			it { expect([1,2,3].my_map(&test)).to eq([1,8,27])}
		end
	end		

end