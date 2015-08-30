class littler::package {
    package { 'littler':
        ensure => latest,
        require => Exec['apt-get update'],
    }
    package { 'r-cran-plyr':
        ensure => latest,
        require => Exec['apt-get update'],
    }
    package { 'r-cran-ggplot2':
        ensure => latest,
        require => Exec['apt-get update'],
    }
}

class littler {
    include littler::package
}
