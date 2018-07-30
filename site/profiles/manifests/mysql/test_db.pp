class profiles::mysql::test_db {
  #require ::profiles::mysql

  #mysql::db { 'test_db':
  #  user     => 'test_user',
  #  password => 'test_password',
  #  host     => 'localhost',
  #  grant    => ['SELECT', 'UPDATE'],
  #}
}
