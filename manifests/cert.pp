class nova::cert( $enabled=false ) {

  Exec['post-nova_config'] ~> Service['nova-cert']
  Exec['nova-db-sync'] ~> Service['nova-cert']

  if $enabled {
    $service_ensure = 'running'
  } else {
    $service_ensure = 'stopped'
  }

  service { "nova-cert":
    name       => $::nova::params::cert_service_name,
    ensure     => $service_ensure,
    enable     => $enabled,
    require    => Package[$::nova::params::common_package_name],
    #subscribe => File["/etc/nova/nova.conf"]
  }

  if ($::nova::params::cert_package_name != undef) {
    package { 'nova-cert':
      ensure => present,
      name   => $::nova::params::cert_package_name,
      notify => Service['nova-cert'],
    }
  }
}
