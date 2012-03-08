#vlan.pp
class nova::network::vlan (
  $vlan_interface,
  $vlan_start,
  $enabled = "true"
) {
  class { 'nova::network':
    enabled => $enabled,
  }
}
