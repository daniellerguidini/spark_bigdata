# download Spark
wget -c https://downloads.apache.org/spark/spark-3.0.1/spark-3.0.1-bin-hadoop3.2.tgz
tar -zxvf spark-3.0.1-bin-hadoop3.2.tgz
export SPARK_HOME=$HOME/spark-3.0.1-bin-hadoop3.2
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

# calculo Pi
# Execução local
$SPARK_HOME/bin/run-example --master local SparkPi 10

# download R
sudo apt-get install r-base r-base-core

