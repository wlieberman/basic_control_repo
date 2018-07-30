class roles::db::test {
  # Include Base Profiles on everything!
  include ::profiles::base

  # Add our test database
  # include ::profiles::mysql::test_db
}
