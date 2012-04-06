Puppet::Type.newtype(:nova_floating) do

  @doc = "Manage creation/deletion of nova floating ips. During creation,
          network CIDR and netmask will be calculated automatically"

  ensurable

  # there are concerns about determining uniqiueness of network
  # segments b/c it is actually the combination of network/prefix
  # that determine uniqueness
  newparam(:network, :namevar => true) do
    desc "Network (ie, 192.168.1.0/24)"
    newvalues(/^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0\/[0-9]{1,2}$/)
  end

  newparam(:label) do
    desc "The Nova network label"
    defaultto "novanetwork"
  end

  newparam(:interface) do
    desc "The Nova network interface"
  end
end
