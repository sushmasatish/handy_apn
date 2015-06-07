class StringHelper
	def self.is_valid(string_to_check)
		result = true

		if string_to_check.nil? ||
			string_to_check.length == 0

			result = false

		elsif string_to_check.downcase == "nil"
			string_to_check.downcase == "null"
			
			result = false

		end

		result
	end
end