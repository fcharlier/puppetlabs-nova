class nova::debian::compute (
  $api_server,
  $rabbit_host,
  $db_host,

  # default to local image service.
  $image_service = undef,
  $glance_api_servers = undef,
  $network_manager = 'nova.network.manager.FlatManager',
  $flat_network_bridge,
  $flat_network_bridge_ip,
  $flat_network_bridge_netmask,
  $rabbit_port = undef,
  $rabbit_userid = undef,
  $rabbit_virtual_host = undef,
  $db_user = 'nova',
  $db_password = 'nova',
  $db_name = 'nova',
  $enabled = 'false',
  $verbose = undef,
) {

  class { "nova":
    logdir => $logdir,
    verbose => $verbose,
    image_service => $image_service,
    glance_api_servers => $glance_api_servers,
    network_manager => $network_manager,
    flat_network_bridge => $flat_network_bridge,
    flat_network_bridge_ip => $flat_network_bridge_ip,
    flat_network_bridge_netmask => $flat_network_bridge_netmask,
    rabbit_host => $rabbit_host,
    rabbit_port => $rabbit_port,
    rabbit_userid => $rabbit_userid,
    rabbit_virtual_host => $rabbit_virtual_host,
    sql_connection => "mysql://${db_user}:${db_password}@${db_host}/${db_name}",
  }

  class { "nova::compute": enabled => $enabled }
}
