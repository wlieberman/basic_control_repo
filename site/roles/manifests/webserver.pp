class roles::webserver {
  # Include base...happens on everything!
  include ::profiles::base

  # Include apache profile to setup apache with mod_php
  include ::profiles::apache

  # Include our new test website written in php
  include ::profiles::website::test

  # Let's make sure that the apache installation happens before we manage
  # the website
  Class['::profiles::apache'] -> Class['::profiles::website::test']
}
