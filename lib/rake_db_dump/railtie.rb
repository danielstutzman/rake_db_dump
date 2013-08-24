require 'rails'

module RakeDbDump
  class Railtie < Rails::Railtie
    railtie_name :rake_db_dump

    rake_tasks do
      load 'tasks/db_dump.rake'
    end
  end
end
