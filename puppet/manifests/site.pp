stage{'firewall':
  before => Stage['main'],
}

class { nexussite::firewall::setup:
  stage => firewall
}

class { 'nexussite': }