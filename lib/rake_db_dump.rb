require "rake_db_dump/version"

module RakeDbDump
  require "rake_db_dump/railtie" if defined?(Rails)
end
