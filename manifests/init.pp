# codeception
#
# This class does several things.
# - installs the codeception as global command
# - installs google chrome
# - installs googledriver
# - adds some commands for an easier work with chromedriver and TYPO3
#
# @summary This class should give you an easy to use codeception environment on your instance
#
# @example
#   include codeception
class codeception {
  exec { 'chrome_install':
    command => 'sudo apt-get install google-chrome-stable',
  }

  exec { 'chromedriver_install':
    command => 'wget https://chromedriver.storage.googleapis.com/2.33/chromedriver_linux64.zip -P ~/ && unzip ~/chromedriver_linux64.zip -d ~/ && rm ~/chromedriver_linux64.zip && sudo mv -f ~/chromedriver /usr/local/bin/chromedriver',
  }
  -> file {
      '/usr/local/bin/chromedriver': ensure => present, owner => 'root', group => 'root', mode => '0755',
  }

  exec { 'codeception_install':
    command => 'wget http://codeception.com/codecept.phar && sudo mv ./codecept.phar /usr/local/bin/codecept',
    path    => '/usr/bin:/usr/sbin',
  }
  -> file {
    '/usr/local/bin/codecept': ensure => present, owner => 'root', group => 'root', mode => '0755',
  }

  file {
    '/usr/local/bin/start-chrome': ensure => file, content => template('codeception/start-chrome.sh.erb'), owner => 'root', group => 'root', mode => '0755'
  }

  file {
    '/usr/local/bin/start-typo3-listener': ensure => file, content => template('codeception/start-typo3-listener.sh.erb'), owner => 'root', group => 'root', mode => '0755'
  }

  file {
    '/usr/local/bin/stop-chrome': ensure => file, content => template('codeception/stop-chrome.sh.erb'), owner => 'root', group => 'root', mode => '0755'
  }

  file {
    '/usr/local/bin/stop-typo3-listener': ensure => file, content => template('codeception/stop-typo3-listener.sh.erb'), owner => 'root', group => 'root', mode => '0755'
  }
}
