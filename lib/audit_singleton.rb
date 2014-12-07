require 'singleton'
require 'logger'

class AuditSingleton
  include Singleton

  attr_accessor :enable_stdout

  # a simple singleton to keep track of transactions and log them in the console at the same time
  # - stdout_logger -> logs to std_out
  # - file_logger -> logs to audit.log
  # - enable_stdout -> to enable/disable stdout_logger. Used for unit tests to avoid polluting console output

  def initialize
    @stdout_logger = Logger.new(STDOUT)
    @file_logger = Logger.new('audit.log')
    @enable_stdout=true
  end

  def log(str)
    if enable_stdout
      @stdout_logger.info(str)
    end
    @file_logger.info(str)
  end

end