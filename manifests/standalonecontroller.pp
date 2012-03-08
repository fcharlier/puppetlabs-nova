# == Class: nova::standalonecontroller
#
# Full nova controller node with all services enabled
#   - mysql
#   - rabbitmq
#   - nova-api
#   - nova-scheduler
#   - nova-objectstore
#   - nova-network (if not int multi_host networking mode)
#
# === Parameters
#
#  [db_*]
#    mysql database parameters, should be self-explanatory
#
#  [rabbit_*]
#    rabbitmq parameters, should be self-explanatory
#
#  [libvirt_type]
#    the type of libvirt driver used
#
#  [multi_host_networking]
#    true or false, sets the `multi_host` parameter. Enables `nova-network` on
#   all nodes with `nova-compute` when true.
#
#  [network_manager]
#    selects the network model to use
#
#  [flat_network_*]
#    parameters for flat (dhcp or not) network model
#
#  [vlan_*]
#    parameters for vlan network model
#
#  [nova_network][available_ips]
#    parameters for network creation
#
#  [image_service]
#    selects the service used to deliver images
#
#  [glance_*]
#    parameters for glance image delivery service
#
#  [admin_user]
#    the name of the default admin user
#
#  [project_name]
#    the name of the default admin project
#
#  [verbose]
#    enables verbose output for nova
#
# === Authors
#
# François Charlier <fcharlier@ploup.net>
#
# === Copyright
#
# Copyright © 2012
#
class nova::standalonecontroller (
  $db_rootpassword,
  $db_password,
  $db_name = 'nova',
  $db_user = 'nova',
  $db_host = 'localhost',
  $db_allowed_hosts = undef,

  $rabbit_port = undef,
  $rabbit_userid = undef,
  $rabbit_password = undef,
  $rabbit_virtual_host = undef,
  $rabbit_host = undef,

  $libvirt_type = 'qemu',

  $multi_host_networking = false,
  $network_manager = 'nova.network.manager.FlatManager',

  $flat_network_bridge  = 'br100',
  $flat_network_bridge_ip  = '11.0.0.1',
  $flat_network_bridge_netmask  = '255.255.255.0',

  $vlan_interface = 'eth0',
  $vlan_start = 1000,

  $nova_network = '11.0.0.0/24',
  $available_ips = '256',

  $image_service = 'nova.image.glance.GlanceImageService',
  $glance_api_servers = 'localhost:9292',
  $glance_host   = undef,
  $glance_port   = undef,

  $admin_user = 'novaadmin',
  $project_name = 'nova',

  $verbose = undef
) {

  class { 'nova::rabbitmq':
    port         => $rabbit_port,
    userid       => $rabbit_userid,
    password     => $rabbit_password,
    virtual_host => $rabbit_virtual_host,
  }

  class { 'mysql::server':
    config_hash => { root_password => $db_rootpassword }
  }

  class { 'nova::db':
    # pass in db config as params
    password      => $db_password,
    dbname        => $db_name,
    user          => $db_user,
    host          => $db_host,
    allowed_hosts => $db_allowed_hosts,
  }

  class { 'nova::controller':
    db_password => $db_password,
    db_name     => $db_name,
    db_user     => $db_user,

    rabbit_port         => $rabbit_port,
    rabbit_userid       => $rabbit_userid,
    rabbit_password     => $rabbit_password,
    rabbit_virtual_host => $rabbit_virtual_host,
    rabbit_host         => $rabbit_host,

    libvirt_type => $libvirt_type,

    multi_host_networking => $multi_host_networking,
    network_manager       => $network_manager,

    flat_network_bridge         => $flat_network_bridge,
    flat_network_bridge_ip      => $flat_network_bridge_ip,
    flat_network_bridge_netmask => $flat_network_bridge_netmask,

    vlan_interface => $vlan_interface,
    vlan_start     => $vlan_start,

    nova_network  => $nova_network,
    available_ips => $available_ips,

    image_service      => $image_service,
    glance_api_servers => $glance_api_servers,
    glance_host        => $glance_host,
    glance_port        => $glance_port,

    admin_user   => $admin_user,
    project_name => $project_name,

    verbose => $verbose
  }

}
