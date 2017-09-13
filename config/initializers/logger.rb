# config logging to the appropriate receptical
class AppLogger < Logger
  def format_message(severity, timestamp, progname, msg)
    "#{Time.now} #{msg}\n"
  end
end

# General application logger
logfile = File.open("#{Rails.root}/log/#{Rails.env}.application.log", 'a')  #create log file
logfile.sync = true  #automatically flushes data to file
APP_LOGGER = AppLogger.new(logfile)  #constant accessible anywhere

# errors log
error_logfile = File.open("#{Rails.root}/log/#{Rails.env}.error.log", 'a')  #create log file
error_logfile.sync = true  #automatically flushes data to file
ERROR_LOGGER = AppLogger.new(error_logfile)  #constant accessible anywhere

scheduler_logfile = File.open("#{Rails.root}/log/#{Rails.env}.scheduler.log", 'a')  #create log file
scheduler_logfile.sync = true  #automatically flushes data to file
SCHED_LOGGER = AppLogger.new(scheduler_logfile)  #constant accessible anywhere

# # failed auth log
# bans log
auth_logfile = File.open("#{Rails.root}/log/#{Rails.env}.auth.log", 'a')  #create log file
auth_logfile.sync = true  #automatically flushes data to file
AUTH_LOGGER = AppLogger.new(auth_logfile)  #constant accessible anywhere
