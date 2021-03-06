package :build_essential do
  description 'Build tools'
  apt 'build-essential' do
    pre :install, 'apt-get update'
    pre :install, 'apt-get install libyaml-dev -y'
    pre :install, 'apt-get install vim -y'
  end
  verify do
    has_executable 'vim'
  end
end
