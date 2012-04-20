#vlan.pp
class nova::network::vlan (
  $enabled = true
) {
  class { 'nova::network':
    enabled => $enabled,
  }

  # ip forwarding must be enabled with VlanManager network mode
  sysctl::value { 'net.ipv4.ip_forward':
    value => '1'
  }
}
