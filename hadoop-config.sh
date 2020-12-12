# instalacao de pacotes basicos
sudo apt update
sudo apt -f -y install ssh rsync wget openjdk-8-jdk

# download Hadoop 3.2.1
wget -c https://downloads.apache.org/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz
tar -zxvf hadoop-3.2.1.tar.gz
mv hadoop-3.2.1 hadoop

# configuracao variaveis de ambiente
cat > hadoop_vars.sh << EOL
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))
export HADOOP_HOME=$HOME/hadoop
export PATH=$PATH:$HOME/hadoop/bin:$HOME/hadoop/sbin
EOL
source hadoop_vars.sh

# configuracao hadoop-env.sh
sed -i "\$aexport JAVA_HOME=$JAVA_HOME" $HADOOP_HOME/etc/hadoop/hadoop-env.sh

# configuracao diretorio de logs
if [ ! -d $HADOOP_HOME/logs ]; then
  mkdir $HADOOP_HOME/logs
fi

# configuracao do arquivo core-site.xml
CORE_SITE=$HADOOP_HOME/etc/hadoop/core-site.xml
mv $CORE_SITE $CORE_SITE.old

{
echo '<?xml version="1.0" encoding="UTF-8"?>'
echo '<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>'
echo '<configuration>'
echo '<property>'
echo '<name>fs.defaultFS</name>'
echo '<value>hdfs://localhost:9000</value>'
echo '</property>'
echo '<property>'
echo '<name>hadoop.tmp.dir</name>'
echo '<value>/home/${user.name}/hadooptmp</value>'
echo '</property>'
echo '</configuration>'
} >> $CORE_SITE

# configuracao arquivo hdfs-site.xml
HDFS_SITE=$HADOOP_HOME/etc/hadoop/hdfs-site.xml
mv $HDFS_SITE $HDFS_SITE.old

cat >$HDFS_SITE <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
<property>
<name>dfs.replication</name>
<value>1</value>
</property>
</configuration>
EOL

# configuracao yarn
YARN_SITE=$HADOOP_HOME/etc/hadoop/yarn-site.xml
mv $YARN_SITE $YARN_SITE.old

cat >$YARN_SITE <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
<property>
<name>yarn.nodemanager.aux-services</name>
<value>mapreduce_shuffle</value>
</property>
</configuration>
EOL

# configuracao mapred-site.xml
MAPRED_SITE=$HADOOP_HOME/etc/hadoop/mapred-site.xml
mv $MAPRED_SITE $MAPRED_SITE.old
cat >$MAPRED_SITE <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
<property>
<name>mapreduce.framework.name</name>
<value>yarn</value>
</property>
<property>
<name>mapreduce.application.classpath</name>
<value>$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/mapr
educe/lib/*</value>
</property>
</configuration>
EOL

# formatacao HDFS no Namenode
echo 'Y' | hdfs namenode -format

# execucao dos daemons do HDFS e YARN
hdfs --daemon start namenode
hdfs --daemon start datanode
yarn --daemon start resourcemanager
yarn --daemon start nodemanager
jps

# criacao dos diretorios no HDFS
hdfs --daemon start namenode
hdfs --daemon start datanode
yarn --daemon start resourcemanager
yarn --daemon start nodemanager
jps

# execucao aplicacao pi
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-
3.2.1.jar pi 16 1000
