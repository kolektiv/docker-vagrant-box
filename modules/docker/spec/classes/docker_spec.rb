require 'spec_helper'

describe 'docker', :type => :class do
  let(:facts) { 
    {
      :operatingsystem => 'Ubuntu',
      :lsbdistcodename => 'raring',
      :kernelrelease   => 'linux-image-extra-3.8.0-29-generic'
    } 
  }

  it { should include_class('docker::install') }
  it { should include_class('docker::service') }
  it { should include_class('docker::config') }
  it { should contain_service('docker').with_provider('upstart') }

  context 'with no parameters' do
    it { should include_class('apt') }
    it { should contain_package('lxc-docker').with_ensure('present') }
    it { should contain_package('lxc-docker').with_require('Apt::Source[lxc-docker]') }
    it { should contain_apt__source('lxc-docker') }
  end

  context 'with a custom version' do
    let(:params) { {'version' => 'absent' } }
    it { should contain_package('lxc-docker').with_ensure('absent') }
  end

  context 'with an invalid distro name' do
    let(:facts) { {:osfamily => 'RedHat'} }
    it do
      expect {
        should contain_package('lxc-docker')
      }.to raise_error(Puppet::Error, /This module uses PPA repos/)
    end
  end

end
