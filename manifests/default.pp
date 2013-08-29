class kernel {
  package { 'linux-image-extra-3.8.0-27-generic':
    ensure => 'present'
  }
}

class images {
  require kernel
  require docker
  
  docker::image { 'ubuntu':
    ensure => 'present'
  }
}

class env {
  require images
}

include env
