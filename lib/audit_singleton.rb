require 'singleton'
require 'logger'

class AuditSingleton
  include Singleton

  # a simple singleton to keep track of transactions and log them in the console at the same time

  def initialize
    @stdout_logger = Logger.new(STDOUT)
    @file_logger = Logger.new('audit.log')
  end

  def log(str)
    @stdout_logger.info(str)
    @file_logger.info(str)
  end

end