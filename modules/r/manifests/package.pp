class r::package {
    package { 'r-base':
        ensure => latest,
        require => Exec['apt-get update'],
    }
}