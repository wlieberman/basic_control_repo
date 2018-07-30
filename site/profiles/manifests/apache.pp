class profiles::apache {

  # Let's make sure that we have apache installed with the appropriate
  # php modules
  include ::apache
  include ::apache::mod::php

  # Open a port of the firewall to allow http(s)
  firewall { '100 allow http and https access':
    port   => ['80', '443'],
    proto  => 'tcp',
    action => 'accept',
  }
}
