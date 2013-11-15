class nexussite::fixes::nexusyum($enable_nexus_yum_fix = true, $nexus_root_dir = '/artifact') {
  if($enable_nexus_yum_fix) {
    notify{ 'Enabled Nexus Yum-plugin fix': }

    file{ 'nexus-yum-plugin-3.0.4.jar':
      ensure => present,
      source => 'puppet:///modules/nexussite/nexus/nexus-yum-plugin-3.0.4.jar',
      path => "$nexus_root_dir//nexus/nexus/WEB-INF/plugin-repository/nexus-yum-plugin-3.0.4/nexus-yum-plugin-3.0.4.jar",
      owner => 'nexus',
      group => 'nexus',
      notify => Service['nexus'],
    }
  }
}