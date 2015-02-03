module Enumerable
	def my_each
		for i in self
			yield i
		end
	end

	def my_each_with_index
		counter = 0
		self.my_each do |element| 
			yield(element,counter)
			counter += 1
		end
	end

	def my_select
		list = []
		self.my_each { |element| list.push(element) if yield(element)}
		list
	end

	def my_all?
		condition = true
		for i in self
			condition = false unless yield i
		end
		condition
	end

	def my_any?
		condition = false
		for i in self
			condition = true if yield i
		end
		condition
	end

	def my_none?
		condition = true
		for i in self
			condition = false if yield i
		end
		condition
	end

	def my_count
		list = []
		for i in self
			list.push(i) if yield i
		end
		list.length
	end

	def my_map(proc=nil)
		result = []	
		if proc && block_given?
			self.my_each { |element| result << proc.call(yield(element)) }
		elsif proc && !block_given?
			self.my_each { |element| result << proc.call(element) }
		else
			self.my_each { |element| result << yield(element) }
		end
		result
	end

	def my_inject(initial = nil)
		initial = self[0] if initial.nil?
		memo = initial
		self.my_each { |element| memo = yield(memo, element) }
		memo
	end
end

def multiply_els(arr)
	arr.my_inject(1) { |product, element| product * element }
end

p [1,2,3].my_each { |num| num**2 }
p [1,2,3].my_each_with_index { |num, index| p "#{index}. Square of #{num} is #{num**2}" }
p [1,2,3,4].my_select { |num| num%2==0 }
p [1,2,3,4,5].my_all? { |num| num<6 }
p [1,2,3,4,5].my_all? { |num| num<5 }
p [10,9,8,4,5].my_any? { |num| num<5 }
p [1,2,3,4,5].my_any? { |num| num>5 }
p [10,9,8,4,5].my_none? { |num| num<5 }
p [1,2,3,4,5].my_none? { |num| num>5 }
p [1,2,3,4,5].my_count { |x| x>2 }
p [1,2,3].my_map { |num| num**2 }
test = Proc.new {|num| num ** 3 }
p [1,2,3].my_map(&test)
p [5,6,7,8].inject { |result_memo, object| result_memo + object }
p multiply_els([2,4,5])