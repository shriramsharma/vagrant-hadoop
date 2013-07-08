Vagrant Hadoop
==================

The objective of this  project was to have a fully functional single node hadoop cluster up and running with a single vagrant up command.

After cloning the project all you have to do is run vagrant up and you will have a single node hadoop cluster installed with all the dependencies and configured.

### Prerequisites: ###
1. Download and install vagrant from http://downloads.vagrantup.com/
2. Download and install virtualbox from https://www.virtualbox.org/wiki/Downloads

### Steps to follow: ###
1. Clone the project.
2. From the root of the project run command - "vagrant up". It will take some time to load up the VM and configure hadoop. Once the VM loads your hadoop cluster is almost ready to be used.
3. Run - "vagrant ssh". This will enable you to ssh into the VM.
3.1 Windows users only: Download putty http://www.putty.org/ to ssh into the VM. Use the IP address of your machine and port 2222 to ssh. Username: vagrant, Password: vagrant.
4. On VM's shell run the below command to format HDFS.
   /opt/hadoop/hadoop-1.1.2/bin/hadoop namenode -format
5. Once HDFS is formatted you may start hadoop.
   /opt/hadoop/hadoop-1.1.2/bin/start-all.sh
6. Run "jps" and you should see an output somewhat like below.
   2287 TaskTracker
   2149 JobTracker
   1938 DataNode
   2085 SecondaryNameNode
   2349 Jps
   1788 NameNode
7. You may also do "netstat" to check if both 54310 and 54311 are active ports and listening.

Thats it!!. You have a single node hadoop cluster up and running.

Hadoop comes with a hello world - word count MapReduce example which you can run the see how hadoop really works.

