package :ruby do
  description 'Ruby Virtual Machine'
  version '1.9.3'
  source "http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p0.tar.gz"
  requires :ruby_dependencies
  verify do
    has_file '/usr/local/bin/ruby'
  end
end

package :ruby_dependencies do
  description 'Ruby Virtual Machine Build Dependencies'
  apt %w( bison zlib1g-dev libssl-dev libreadline5-dev libncurses5-dev file )
end