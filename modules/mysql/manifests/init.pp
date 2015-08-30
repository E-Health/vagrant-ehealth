class mysql {
  $password = ""
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

  exec { "Set MySQL server root password":
    subscribe => [ Package["mysql-server"], Package["mysql-client"], Package["libmysqlclient-dev"] ],
    refreshonly => true,
    unless => "mysqladmin -uroot -p$password status",
    path => "/bin:/usr/bin",
    command => "mysqladmin -uroot password $password",
    command => "mysqladmin -uroot -p$password create oscar_mcmaster",
    command => "mysql -uroot -p$password oscar_12_1 < /home/vagrant/OscarON12_1.sql",
  }
  exec { "Create OSCAR Database":
    subscribe => [ Package["mysql-server"], Package["mysql-client"], Package["libmysqlclient-dev"] ],
    refreshonly => true,
    unless => "mysqladmin -uroot -p$password status",
    path => "/bin:/usr/bin",
    command => "mysqladmin -uroot -p$password create oscar_mcmaster",
  }
  exec { "Write OSCAR Data":
    subscribe => [ Package["mysql-server"], Package["mysql-client"], Package["libmysqlclient-dev"] ],
    refreshonly => true,
    unless => "mysqladmin -uroot -p$password status",
    path => "/bin:/usr/bin",
    command => "mysql -uroot -p$password oscar_12_1 < /home/vagrant/OscarON12_1.sql",
  }

}
