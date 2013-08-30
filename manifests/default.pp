class images {
  require docker
  
  docker::image { 'ubuntu':
    ensure => 'present'
  }
}

class env {
  require images
}

include env
