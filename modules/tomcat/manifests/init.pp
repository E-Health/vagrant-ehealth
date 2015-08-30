class tomcat {
    package { 'tomcat6':
        ensure => "installed",
    }
    file { "/usr/share/tomcat6/Oscar12_1.properties":
        ensure => present,
        source => "puppet:///modules/tomcat/Oscar12_1.properties",
        owner => "root",
        group => "root",
        mode => 777,
    }

}
