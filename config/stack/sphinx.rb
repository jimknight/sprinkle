package :sphinx do
  source 'http://sphinxsearch.com/files/sphinx-2.0.3-release.tar.gz' do
    prefix '/usr/local'
  end
  
  verify do
    has_file '/usr/local/bin/searchd'
  end
end