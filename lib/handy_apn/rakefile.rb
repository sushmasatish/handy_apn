require "handy_apn"

configatron.apn.port = 2195
configatron.apn.dev.host = 'gateway.sandbox.push.apple.com'
configatron.apn.prod.host = 'gateway.push.apple.com'

configatron.apn.feedback.port = 2196
configatron.apn.dev.feedback.host = 'feedback.sandbox.push.apple.com'
configatron.apn.prod.feedback.host = 'gateway.push.apple.com'

namespace :apn do

	desc "send_message - Params: apn_pem_file_path, apn_pass_phrase, device_token, should_send_message_to_apn_prod, message_text"
	task :send_message, [:apn_pem_file_path, :apn_pass_phrase, :device_token, :should_send_message_to_apn_prod, :message_text] do |task, args|
		ColouredLogger::CLogger.info(task, "STARTED - Running send_message Task.")

        device_token = args[:device_token]
        should_send_message_to_apn_prod = false # False means dev.
        apn_pem_file_path = args[:apn_pem_file_path]
		apn_pass_phrase = args[:apn_pass_phrase]
		message_text = args[:message_text]
		
		unless args[:should_send_message_to_apn_prod].nil?
			if args[:should_send_message_to_apn_prod].downcase == "true"
        		should_send_message_to_apn_prod = true
	        end
		end
        
		ApnSendHelper.new(apn_pem_file_path, 
			apn_pass_phrase,
			device_token, 
			should_send_message_to_apn_prod, 
			message_text).send_push_notification()

		ColouredLogger::CLogger.info(task, "FINISHED - Running send_message Task.")
	end
end
