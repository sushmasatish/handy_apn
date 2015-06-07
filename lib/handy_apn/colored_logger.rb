require 'singleton'
require "./lib/handy_apn/logger.rb"

class ColoredLogger
	include Singleton

	attr_reader :logger

	SEVERITY_TO_COLOR_MAP = {'DEBUG'=>'36', 'INFO'=>'32', 'WARN'=>'33', 'ERROR'=>'31', 'FATAL'=>'31', 'UNKNOWN'=>'37', 'PERF'=>'35'}

  	def initialize
		@logger = Logger.new(STDOUT)
# 		Logger.LEVEL = DEBUG - logs all levels, INFO - would not log debug level.
		@logger.level = Logger::DEBUG
		@logger.formatter = proc do |severity, time, progname, msg|
      		formatted_severity = sprintf("%-5s",severity.to_s)
      		formatted_time = sprintf("[%s]", time.strftime("%Y-%m-%d %H:%M:%S"))
      		date_color ='1;34'
      		severity_color = SEVERITY_TO_COLOR_MAP[severity]
      		"\033[#{date_color}m#{formatted_time} \033[#{severity_color}m #{formatted_severity} \033[0m-- #{msg.to_s.strip}\n"
    	end
	end

# 	low-level information for developers
	def self.debug(method, message)
		formatted_method = sprintf("%-20s", method)
		ColoredLogger.instance.logger.debug("#{formatted_method}: #{message}");
	end

# 	generic (useful) information about system operation
	def self.info(method, message)
		formatted_method = sprintf("%-20s", method)
		ColoredLogger.instance.logger.info("#{formatted_method}: #{message}");
	end

# 	Logs time taken to execute a task
	def self.log_time(method, start_time, task_name)
		end_time = Time.now
		formatted_method = sprintf("%-20s", method)
		time_taken = end_time - start_time
		formatted_time_taken = sprintf("[%.4f sec]", time_taken)
		ColoredLogger.instance.logger.perf("#{formatted_method}: Time taken to #{task_name} - \033[35m#{formatted_time_taken}\033[0m");
	end
end