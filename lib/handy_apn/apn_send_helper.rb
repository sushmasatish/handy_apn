class ApnSendHelper

	attr_reader :device_token
	attr_reader :should_send_message_to_apn_prod
	attr_reader :apn_pem_file_path
	attr_reader :apn_pass_phrase
	attr_reader :message

	def initialize(apn_pem_file_path, apn_pass_phrase, device_token, should_send_message_to_apn_prod, message)
		@apn_pem_file_path = apn_pem_file_path
		@apn_pass_phrase = apn_pass_phrase
		@device_token = device_token
		@should_send_message_to_apn_prod = should_send_message_to_apn_prod
		@message = "Testing: #{Time.now}"
		if (message && 
			message.strip.length > 0) 
			@message = message.strip
		end
	end

	def send_push_notification
		result = false

		if !StringHelper.is_valid(apn_pem_file_path)
			ColouredLogger::CLogger.debug(__method__, 
				"Cannot send push notification as no certificate file is provided.")
			return result
		end

		if !StringHelper.is_valid(apn_pass_phrase)
			ColouredLogger::CLogger.debug(__method__, 
				"Cannot send push notification as pass-pharse is not provided for the certificate.")
			return result
		end

		if !StringHelper.is_valid(device_token)
			ColouredLogger::CLogger.debug(__method__, 
				"Cannot send push notification as device_token is not provided.")
			return result
		end

		ColouredLogger::CLogger.debug(__method__, 
			"Sending push notification to device_token #{@device_token} - #{@should_send_message_to_apn_prod}")

		reset_apn_configurations

		begin
	      ApnConnection.open_for_delivery() do |conn, sock|
	        conn.write(ApnSendHelper.data_to_send(@device_token, @message))
	      end
	      result = true
	    rescue Exception => err
	      ColouredLogger::CLogger.debug(__method__, 
	      "Incurred while sending notifications [#{err.message}]")
	    end

		result
	end

	def reset_apn_configurations
		configatron.apn.cert = @apn_pem_file_path
		configatron.apn.passphrase = @apn_pass_phrase

		if @should_send_message_to_apn_prod
			configatron.apn.host = configatron.apn.prod.host
		else
			configatron.apn.host = configatron.apn.dev.host
		end
	end

	def self.data_to_send(device_token, msg)
	  json = self.to_apple_json(msg)
	  message = "\0\0 #{self.to_hexa(device_token)}\0#{json.length.chr}#{json}"
	  raise ApnErrorsHelper::ExceededMessageSizeError.new(message) if message.size.to_i > 256
	  message
	end

	def self.to_hexa(device_token)
	  [device_token.delete(' ')].pack('H*')
	end

	def self.apple_hash(msg)
	  result = {}
	  result['aps'] = {}
	  result['aps']['alert'] = msg
	  result['aps']['badge'] = 1
	  result['aps']['sound'] = "1.aiff"

	  ColouredLogger::CLogger.info(__method__, "Message: #{result}")

	  result
	end

	def self.to_apple_json(msg)
	  self.apple_hash(msg).to_json
	end
end