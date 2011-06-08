Puppet::Type.newtype(:nova_network) do

  @doc = "Manage creation/deletion of nova networks.  During creation, network 
          CIDR and subnet will be calculated automatically"

  ensurable

  newparam(:name) do
    desc "network name."
  end

  newparam(:network) do
    desc "Network (ie, 192.168.1.0)"
    newvalues(/^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0$/)
  end

  newparam(:available_ips) do
    desc "# of available IPs. Must be greater than 4."
    validate do |value|
      if value.to_i < 4
        raise Puppet::Error, "ERROR - nova_network: Parameter available_ips must be an integer greater than 4."
      end
    end
  end

end
