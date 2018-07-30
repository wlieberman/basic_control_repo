class profiles::website::test {
  # This is a class that will deploy a test php website
  file { '/var/www/html/index.php':
    ensure => file,
    owner  => 'root',
    group  => 'apache',
    mode   => '0640',
    source => "puppet:///modules/${module_name}/php/index.php"
  }

}
