package :sphinx do
  source 'http://sphinxsearch.com/files/sphinx-2.0.3-release.tar.gz' do
    prefix '/usr/local'
    custom_install "./configure --with-pgsql && make && make install"
  end
  
  verify do
    has_file '/usr/local/bin/searchd'
  end
end