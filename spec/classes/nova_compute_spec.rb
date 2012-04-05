require 'spec_helper'

describe 'nova::compute' do

  let :pre_condition do
    'include nova'
  end

  describe 'on debian platforms' do
    let :facts do
      { :osfamily => 'Debian' }
    end
    it { should contain_service('nova-compute').with(
      'name'    => 'nova-compute',
      'ensure'  => 'stopped',
      'enable'  => false
    )}
    it { should contain_package('nova-compute').with(
      'name'   => 'nova-compute',
      'ensure' => 'present',
      'notify' => 'Service[nova-compute]'
    ) }
    describe 'with enabled as true' do
      let :params do
        {:enabled => true}
      end
    it { should contain_service('nova-compute').with(
      'name'    => 'nova-compute',
      'ensure'  => 'running',
      'enable'  => true
    )}
    end
  end
  describe 'on rhel' do
    let :facts do
      { :osfamily => 'RedHat' }
    end
    it { should contain_service('nova-compute').with(
      'name'    => 'openstack-nova-compute',
      'ensure'  => 'stopped',
      'enable'  => false
    )}
    it { should_not contain_package('nova-compute') }
  end

  describe 'multi host networking' do
    let :facts do
      { :osfamily => 'Debian' }
    end
    let :pre_condition do
      'class {"nova":  multi_host_networking => true }'
    end
    it { should include_class("nova::api") }
    it { should include_class("nova::network") }
    it { should contain_nova_config('enabled_apis').with_value('metadata') }
  end

end
