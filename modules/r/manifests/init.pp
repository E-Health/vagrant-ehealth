# == Class: r
#
class r {
    file { "/home/vagrant/install.r":
        ensure => present,
        source => "puppet:///modules/r/install.r",
        owner => "root",
        group => "root",
        mode => 755,
    }
	
	include r::package

}
