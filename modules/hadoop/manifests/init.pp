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
    owner => root,
    group => root,
    require => Exec["unpack_hadoop"]

}

file { "${hadoop_home}-${hadoop_version}/conf/core-site.xml":
    source => "puppet:///modules/hadoop/core-site.xml",
    mode => 644,
    owner => root,
    group => root,
    require => Exec["unpack_hadoop"]

}

file { "${hadoop_home}-${hadoop_version}/conf/hdfs-site.xml":
    source => "puppet:///modules/hadoop/hdfs-site.xml",
    mode => 644,
    owner => root,
    group => root,
    require => File["${hadoop_home}-${hadoop_version}/conf/core-site.xml"]

}

file { "${hadoop_home}-${hadoop_version}/conf/mapred-site.xml":
    source => "puppet:///modules/hadoop/mapred-site.xml",
    mode => 644,
    owner => root,
    group => root,
    require => File["${hadoop_home}-${hadoop_version}/conf/hdfs-site.xml"]
  }

}
