require 'singleton'
require 'logger'

class AuditSingleton
  include Singleton

  def initialize
    @stdout_logger = Logger.new(STDOUT)
    @file_logger = Logger.new('audit.log')
  end

  def log(str)
    @stdout_logger.info(str)
    @file_logger.info(str)
  end

end