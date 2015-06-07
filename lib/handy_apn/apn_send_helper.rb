require "./lib/handy_apn/colored_logger.rb"
require "./lib/handy_apn/string_helper.rb"
require "./lib/handy_apn/apn_connection.rb"
require "./lib/handy_apn/apn_send_helper.rb"

class ApnSendHelper

	attr_reader :device_token
	attr_reader :is_dev_or_prod
	attr_reader :apn_cer_file_full_path
	attr_reader :apn_pass_phrase

	def initialize(apn_cer_file_full_path, apn_pass_phrase, device_token, is_dev_or_prod)
		@apn_cer_file_full_path = apn_cer_file_full_path
		@apn_pass_phrase = apn_pass_phrase
		@device_token = device_token
		@is_dev_or_prod = is_dev_or_prod
	end

	def send_push_notification
		result = false

		if !StringHelper.is_valid(apn_cer_file_full_path)
			ColoredLogger.debug(__method__, 
				"Cannot send push notification as no certificate file is provided.")
			return result
		end

		if !StringHelper.is_valid(apn_pass_phrase)
			ColoredLogger.debug(__method__, 
				"Cannot send push notification as pass-pharse is not provided for the certificate.")
			return result
		end

		if !StringHelper.is_valid(device_token)
			ColoredLogger.debug(__method__, 
				"Cannot send push notification as device_token is not provided.")
			return result
		end

		ColoredLogger.debug(__method__, 
			"Sending push notification to device_token #{@device_token} - #{@is_dev_or_prod}")

		reset_apn_configurations

		begin
	      ApnConnection.open_for_delivery() do |conn, sock|
	        conn.write(ApnSendHelper.data_to_send(@device_token))
	      end
	      result = true
	    rescue Exception => err
	      ColoredLogger.debug(__method__, 
	      "Incurred while sending notifications [#{err.message}]")
	    end

		result
	end

	def reset_apn_configurations
		configatron.apn.cert = @apn_cer_file_full_path
		configatron.apn.passphrase = @apn_pass_phrase

		if @is_dev_or_prod
			configatron.apn.host = configatron.apn.prod.host
		else
			configatron.apn.host = configatron.apn.dev.host
		end
	end

	def self.data_to_send(device_token)
	  json = self.to_apple_json
	  message = "\0\0 #{self.to_hexa(device_token)}\0#{json.length.chr}#{json}"
	  raise ApnErrorsHelper::ExceededMessageSizeError.new(message) if message.size.to_i > 256
	  message
	end

	def self.to_hexa(device_token)
	  [device_token.delete(' ')].pack('H*')
	end

	def self.apple_hash
	  result = {}
	  result['aps'] = {}
	  result['aps']['alert'] = "Testing: #{Time.now}"
	  result['aps']['badge'] = 1
	  result['aps']['sound'] = "1.aiff"
	  result
	end

	def self.to_apple_json
	  self.apple_hash.to_json
	end
end