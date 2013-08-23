namespace :db do
  desc "Show tables' schema and data in db specified by config/database.yml"
  task :dump => :environment do
    # By default 'rails new' creates apps with the database set to sqlite3.
    # Stop running this task if the developer hasn't changed it to postgresql.
    if ActiveRecord::Base.connection.adapter_name == 'SQLite'
      fail 'rake db:dump only works when your config/database.yml has ' +
        'adapter set to postgresql.  Currently it\'s set to sqlite3.'
    end

    ActiveRecord::Base.logger = nil # turn off SQL logging

    sql = "select tablename from pg_tables where schemaname = 'public'"
    rows = ActiveRecord::Base.connection.execute(sql)
    rows.each do |row|
      table_name = row['tablename']
      puts "#{'_' * 25} #{table_name} table #{'_' * (42 - table_name.size)}"

      sql = "select column_name,
          case when udt_name = 'varchar'
            then concat('varchar(', character_maximum_length, ')')
            else data_type end as data_type,
          is_nullable
        from information_schema.columns
        where table_name = '#{table_name}'
        and table_schema = 'public'
        order by ordinal_position"
      rows2 = ActiveRecord::Base.connection.execute(sql)
      longest_name_length =
        rows2.collect { |row2| row2['column_name'].size }.max + 1
      rows2.each_with_index do |row2, i|
        puts sprintf("| Type of %-#{longest_name_length}s %s %s",
          row2['column_name'] + ':',
          row2['data_type'],
          row2['is_nullable'] ? '' : 'not null')
      end
      puts '' # to separate schema from data

      sql = "select * from #{table_name};"
      rows2 = ActiveRecord::Base.connection.execute(sql)
      if rows2.first
        keys = rows2.first.keys
        longest_key_length = keys.collect { |key| key.size }.max
        rows2.each_with_index do |row2, i|
          puts '' unless i == 0 # separation between rows
          keys.each do |key|
            value = row2[key]
            value = 'NULL' if value.nil?
            puts sprintf("%#{longest_key_length}s: %s", key, value)
          end
        end
      end
    end
    puts '_' * 75
  end
end
