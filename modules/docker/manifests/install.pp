# == Class: docker
#
# Module to install an up-to-date version of Docker from the
# official PPA. The use of the PPA means this only works
# on Ubuntu.
#
# === Parameters
# [*version*]
#   The package version to install, passed to ensure.
#   Defaults to present.
#
class docker::install {
  include apt
  validate_string($version)
  validate_re($::operatingsystem, '^Ubuntu$', 'This module only works with Ubuntu based distros')
  validate_string($::kernelrelease)

  apt::key { 'lxc-docker':
    key        => 'A88D21E9',
    key_source => 'https://get.docker.io/gpg',
  }

  apt::source { 'lxc-docker':
    location    => 'https://get.docker.io/ubuntu',
    release     => 'docker',
    repos       => 'main',
    include_src => 'false',
    require     => Apt::Key['lxc-docker'],
  }

  $kernelpackage = "linux-image-extra-${::kernelrelease}"

  package { $kernelpackage:
    ensure => present,
  }
    
  package { 'lxc-docker':
    ensure  => $docker::version,
    require => Apt::Source['lxc-docker'],
  }
}
