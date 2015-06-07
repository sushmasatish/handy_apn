require "configatron"
require "json"
require "./lib/handy_apn/colored_logger.rb"
require "./lib/handy_apn/apn_send_helper.rb"

configatron.apn.port = 2195
configatron.apn.dev.host = 'gateway.sandbox.push.apple.com'
configatron.apn.prod.host = 'gateway.push.apple.com'

configatron.apn.feedback.port = 2196
configatron.apn.dev.feedback.host = 'feedback.sandbox.push.apple.com'
configatron.apn.prod.feedback.host = 'gateway.push.apple.com'

namespace :apn do

	desc "send_push_notification - Params: apn_cer_file_full_path, apn_pass_phrase, device_token, is_dev_or_prod"
	task :send_push_notification, [:apn_cer_file_full_path, :apn_pass_phrase, :device_token, :is_dev_or_prod] do |task, args|
		ColoredLogger.info(task, "STARTED - Running send_push_notification Task.")

        device_token = args[:device_token]
        is_dev_or_prod = false # False means dev.
        apn_cer_file_full_path = args[:apn_cer_file_full_path]
		apn_pass_phrase = args[:apn_pass_phrase]
		
		unless args[:is_dev_or_prod].nil?
			if args[:is_dev_or_prod].downcase == "true"
        		is_dev_or_prod = true
	        end
		end
        
		ApnSendHelper.new(apn_cer_file_full_path, 
			apn_pass_phrase,
			device_token, 
			is_dev_or_prod).send_push_notification()

		ColoredLogger.info(task, "FINISHED - Running send_push_notification Task.")
	end
end
