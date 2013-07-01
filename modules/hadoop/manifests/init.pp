class hadoop {
 $hadoop_home = "/opt/hadoop"

exec { "download_hadoop":
command => "wget -O /tmp/hadoop.tar.gz http://apache.tradebit.com/pub/hadoop/core/stable/hadoop-1.1.2.tar.gz",
path => $path,
require => Package["openjdk-6-jdk"]
}

exec { "unpack_hadoop" :
  command => "tar -zxf /tmp/hadoop.tar.gz -C /opt",
  path => $path,
  creates => "${hadoop_home}-1.1.2",
  require => Exec["download_hadoop"]
}
}
