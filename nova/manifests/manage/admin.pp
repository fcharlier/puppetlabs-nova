define nova::manage::admin {
  nova_admin{ $name:
    ensure => present,
    notify => Exec["nova-db-sync"],
    require => Class["nova::db"],
  }
}
