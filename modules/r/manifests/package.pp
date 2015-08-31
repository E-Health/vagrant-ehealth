class r::package {
    package { 'r-base':
        ensure => latest,
        require => Exec['apt-get update'],
    }
    package { 'r-base-dev':
        ensure => latest,
        require => Package['r-base'],
    }
}