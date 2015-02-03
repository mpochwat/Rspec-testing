def caesar_cipher(str, num)
	cipher = ''
	str.each_char do |char|
		#Converts char into ascii num given current shift
		val = char.ord + (num % 26)
		#Keeps capital letters capital
		if char =~ /[A-Z]/ && val > 90
			val = (val % 90) + 64
			cipher += val.chr
		#Keeps lower case letters lower case
		elsif char =~ /[a-z]/ && val > 122
			val = (val % 122) + 96
			cipher += val.chr
		#Ignores calculation for non-letters
		elsif char =~ /\W/
			cipher += char
		else
			cipher += val.chr
		end
	end
	return cipher
end

#Tests
caesar_cipher("", 1)
caesar_cipher("What a string!", 104)
caesar_cipher("What a string!", 5)
caesar_cipher("What a string!", 34)


