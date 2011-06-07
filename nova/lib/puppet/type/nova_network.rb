Puppet::Type.newtype(:nova_network) do

  @doc = "Manage creation/deletion of nova networks.  During creation, network 
          CIDR and subnet will be calculated automatically"

  ensurable

  newparam(:name) do
    desc "network name."
  end

  newparam(:network) do
    desc "Network (ie, 192.168.1.0)"
  end

  newparam(:available_ips) do
    desc "# of available IPs. Must be greater than 4."
  end

  validate do
    if !self[:network].match(/^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0$/) 
      raise Puppet::Error, "ERROR - nova_network: Malformed network address #{self[:network]}. Parameter network must be passed as a valid network address (ie, 192.168.25.0)"
    end
    if self[:available_ips].to_i < 4
      raise Puppet::Error, "ERROR - nova_network: Parameter available_ips must be an integer greater than 4."
    end
  end
end
