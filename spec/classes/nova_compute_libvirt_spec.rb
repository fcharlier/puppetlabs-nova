require 'spec_helper'

describe 'nova::compute::libvirt' do
  let :pre_condition do
    'include nova'
  end

  describe 'on debian platforms' do
    let :facts do
      { :osfamily => 'Debian' }
    end
    it { should contain_service('libvirt').with(
      'name'     => 'libvirt-bin',
      'ensure'   => 'running',
      'provider' => 'upstart'
    )}
    it { should contain_package('libvirt').with(
      'name'   => 'libvirt-bin',
      'ensure' => 'present'
    )}
  end
  describe 'on Debian' do
    let :facts do
      { :osfamily => 'Debian', :operatingsystem => 'Debian' }
    end
    it { should contain_service('libvirt').with(
      'name'     => 'libvirt-bin',
      'ensure'   => 'running',
      'provider' => 'debian'
    )}
  end
  describe 'on rhel' do
    let :facts do
      { :osfamily => 'RedHat' }
    end
    it { should contain_service('libvirt').with(
      'name'     => 'libvirtd',
      'ensure'   => 'running',
      'provider' => 'init'
    )}
    it { should contain_package('libvirt').with(
      'name'   => 'libvirt',
      'ensure' => 'present'
    )}
  end
end
