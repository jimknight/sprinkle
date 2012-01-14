package :postgres, :provides => :database do
  description 'PostgreSQL database'
  apt %w( postgresql postgresql-client libpq-dev )
  transfer 'config/stack/apache/pg_hba.conf', '/etc/postgresql/8.4/main/pg_hba.conf', :sudo => true
  # verify do
  #   has_executable 'psql'
  # end

  optional :postgresql_driver
end
 
package :postgresql_driver, :provides => :ruby_database_driver do
  description 'Ruby PostgreSQL database driver'
  gem 'pg'
  
  verify do
    has_gem 'pg'
  end
  
  requires :ruby
end
