class mysql {
  $password = "oscar"
  $oscar_db = "oscar_12_1"
  package { "mysql-client": ensure => installed }
  package { "mysql-server": ensure => installed }
  package { "libmysqlclient-dev": ensure => installed }

  file { "/home/vagrant/OscarON12.1.sql":
        ensure => present,
        source => "puppet:///modules/mysql/OscarON12.1.sql",
        owner => "root",
        group => "root",
        mode => 777,
  }

  exec { "mysql_root_password":
    subscribe => [ Package["mysql-server"], Package["mysql-client"], Package["libmysqlclient-dev"] ],
    refreshonly => true,
    unless => "mysqladmin -uroot -p$password status",
    path => "/bin:/usr/bin",
    command => "mysqladmin -uroot password $password",
  }

  exec { "mysql_create_db":
    subscribe => Exec['mysql_root_password'],
    refreshonly => true,
    path => "/bin:/usr/bin",
    command => "mysqladmin -uroot -p$password create $oscar_db",
  }
  exec { "mysql_write_db":
    subscribe => Exec['mysql_create_db'],
    refreshonly => true,
    path => "/bin:/usr/bin",
    command => "mysql -uroot -p$password $oscar_db < /home/vagrant/OscarON12_1.sql",
  }
}
