class nexussite::firewall::pre {
  Firewall {
    require => undef,
  }

  # Default firewall rules
  firewall { '000 accept all icmp':
    proto   => 'icmp',
    action  => 'accept',
  }->
  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '002 accept related established rules':
    proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
  }->
  firewall { '003 allow ssh access':
    port   => [22],
    proto  => tcp,
    action => accept,
  }->
  firewall { '200 allow http and https access':
    port   => [80, 8080],
    proto  => tcp,
    action => accept,
  }->
  firewall { '101 reroute requests from port 80 to 8080':
    chain => 'PREROUTING',
    jump => 'REDIRECT',
    proto => tcp,
    iniface => 'eth1',
    table => 'nat',
    dport => 80,
    toports => 8080,
  }
}
