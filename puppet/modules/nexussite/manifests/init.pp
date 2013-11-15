class nexussite {
  package { 'java-1.7.0-openjdk.x86_64': }->
  package { 'createrepo': }->
  package { 'sendmail': }->
  group{ 'nexus':
    ensure => present,
    system => true
  }->
  user{ 'nexus':
    ensure => present,
    comment => 'Nexus user',
    gid     => 'nexus',
    home    => '/artifact/nexus',
    shell   => '/bin/bash', # unfortunately required to start application via script.
    system  => true,
    require => Group['nexus']
  }->
  file { '/artifact':
    ensure => directory,
  }->
  class { '::nexus':
    version        => '2.6.3',
    nexus_user     => 'nexus',
    nexus_group    => 'nexus',
    nexus_root     => '/artifact'
  }
  class { 'fixes::nexusyum':
    require => Class['::nexus::package'],
  }
}