class hadoop {
 $hadoop_home = "/opt/hadoop"

exec { "download_hadoop":
command => "wget -O /tmp/hadoop.tar.gz http://apache.tradebit.com/pub/hadoop/core/stable/hadoop-1.1.2.tar.gz",
path => $path,
require => Package["openjdk-6-jdk"],
timeout => 0
}

exec { "unpack_hadoop" :
  command => "tar -zxf /tmp/hadoop.tar.gz -C /opt",
  path => $path,
  creates => "${hadoop_home}-1.1.2",
  require => Exec["download_hadoop"]
}

exec { "create_hadoop_tmp_dir":
  command => "mkdir -p ${hadoop_home}/tmp",
  path => $path,
  require => Exec["unpack_hadoop"]
}

exec { "adding_permission_to_tmp_dir":
  command => "chmod 777 ${hadoop_home}/tmp",
  path => $path,
  require => Exec["adding_permission_to_tmp_dir"]
}

file { "${hadoop_home}-1.1.2/conf/core-site.xml"
   source => "puppet:///modules/hadoop/core-site.xml"
}
file { "${hadoop_home}-1.1.2/conf/hdfs-site.xml"
   source => "puppet:///modules/hadoop/hdfs-site.xml"
}file { "${hadoop_home}-1.1.2/conf/mapred-site.xml"
   source => "puppet:///modules/hadoop/mapred-site.xml"
}

}
