class hadoop {
 $hadoop_home = "/opt/hadoop"
 $hadoop_version = "1.1.2"

exec { "download_hadoop":
command => "wget -O /tmp/hadoop.tar.gz http://apache.tradebit.com/pub/hadoop/core/stable/hadoop-${hadoop_version}.tar.gz",
path => $path,
require => Package["openjdk-6-jdk"],
timeout => 0
}

exec { "unpack_hadoop" :
  command => "tar -zxf /tmp/hadoop.tar.gz -C /opt",
  path => $path,
  creates => "${hadoop_home}-${hadoop_version}",
  require => Exec["download_hadoop"]
}

exec { "change_owner_of_hadoop_to_vagrant":
  command => "chown -R vagrant:vagrant ${hadoop_home}-${hadoop_version}",
  path => $path,
  require => Exec["unpack_hadoop"]
}

exec { "create_hadoop_tmp_dir":
  command => "mkdir -p ${hadoop_home}-${hadoop_version}/tmp",
  path => $path,
  require => Exec["unpack_hadoop"]
}

exec { "adding_permission_to_tmp_dir":
  command => "chmod 777 ${hadoop_home}-${hadoop_version}/tmp",
  path => $path,
  require => Exec["create_hadoop_tmp_dir"]
}

file { "${hadoop_home}-${hadoop_version}/conf/hadoop-env.sh":
    source => "puppet:///modules/hadoop/hadoop-env.sh",
    mode => 644,
    owner => vagrant,
    group => vagrant,
    require => Exec["unpack_hadoop"]

}

file { "${hadoop_home}-${hadoop_version}/conf/core-site.xml":
    source => "puppet:///modules/hadoop/core-site.xml",
    mode => 644,
    owner => vagrant,
    group => vagrant,
    require => Exec["unpack_hadoop"]

}

file { "${hadoop_home}-${hadoop_version}/conf/hdfs-site.xml":
    source => "puppet:///modules/hadoop/hdfs-site.xml",
    mode => 644,
    owner => vagrant,
    group => vagrant,
    require => File["${hadoop_home}-${hadoop_version}/conf/core-site.xml"]

}

file { "${hadoop_home}-${hadoop_version}/conf/mapred-site.xml":
    source => "puppet:///modules/hadoop/mapred-site.xml",
    mode => 644,
    owner => vagrant,
    group => vagrant,
    require => File["${hadoop_home}-${hadoop_version}/conf/hdfs-site.xml"]
  }

exec { "create_ssh_dir":
  command => "mkdir -p /home/vagrant/.ssh",
  path => $path,
}

file { "/home/vagrant/.ssh/id_rsa":
    source => "puppet:///modules/hadoop/.ssh/id_rsa",
    mode => 600,
    owner => vagrant,
    group => vagrant,
    require => Exec["create_ssh_dir"]
  }

file { "/home/vagrant/.ssh/id_rsa.pub":
    source => "puppet:///modules/hadoop/.ssh/id_rsa.pub",
    mode => 600,
    owner => vagrant,
    group => vagrant,
    require => File["/home/vagrant/.ssh/id_rsa"]
  }

file { "/home/vagrant/.ssh/authorized_keys":
    source => "puppet:///modules/hadoop/.ssh/authorized_keys",
    mode => 600,
    owner => vagrant,
    group => vagrant,
    require => File["/home/vagrant/.ssh/id_rsa.pub"]
  }

}
