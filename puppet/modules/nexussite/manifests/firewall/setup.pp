class nexussite::firewall::setup {
  resources { "firewall":
    purge => true
  }
  Firewall {
    before  => Class['nexussite::firewall::post'],
    require => Class['nexussite::firewall::pre'],
  }
  class { ::nexussite::firewall::pre: }
  class { ::nexussite::firewall::post: }
  class { ::firewall: }
}
