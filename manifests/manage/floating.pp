define nova::manage::floating ( $network, $interface, $label ) {

  File['/etc/nova/nova.conf'] -> Nova_floating[$name]
  Exec<| title == 'initial-db-sync' |> -> Nova_floating[$name]

  nova_floating { $name:
    ensure    => present,
    network   => $network,
    interface => $interface,
    label     => $label,
    provider  => 'nova_manage',
    notify    => Exec["nova-db-sync"],
  }

}
