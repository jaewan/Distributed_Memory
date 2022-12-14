#!/bin/bash

# check for java and maven.
if type -p java > /dev/null 2>&1
then
    echo -e "please check if java version is java 8..."
else
    echo -e "java not found. installing java 8..."
    sudo apt update
    sudo apt install openjdk-8-jdk
fi

if type -p mvn > /dev/null 2>&1
then
    echo -e "maven already installed..."
else
    echo -e "installing maven..."
    sudo apt install maven
fi

# check for HiBench folder in Distributed_Memory folder.
pushd ../../..  > /dev/null 2>&1
if [ -d "HiBench" ]
then
    echo -e "located HiBench repository..."
else
    echo -e "downloading HiBench repository from github..."
    git clone https://github.com/Intel-bigdata/HiBench.git
fi
popd > /dev/null 2>&1

##### REDO TO REMOVE UNNECESSARY FILES FOR FINAL REPACKAGE

# download hadoop and spark.
echo -e "checking for spark and hadoop..."

pushd /usr/local > /dev/null 2>&1
if [ ! -d "hadoop" ]
then
    popd > /dev/null 2>&1
    if [ ! -f "hadoop-3.2.4.tar.gz" ]; then
        wget https://dlcdn.apache.org/hadoop/common/hadoop-3.2.4/hadoop-3.2.4.tar.gz
    fi
    tar -xzvf hadoop-3.2.4.tar.gz
    sudo mv hadoop-3.2.4 /usr/local/hadoop

    # add java path
    pushd /usr/local > /dev/null 2>&1
    echo export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::") \
    | tee -a hadoop/etc/hadoop/hadoop-env.sh > /dev/null 2>&1

    # add environment paths
    echo export HADOOP_PREFIX=/usr/local/hadoop | tee -a ~/.bashrc > /dev/null 2>&1
    echo export HADOOP_HOME=$HADOOP_PREFIX | tee -a ~/.bashrc > /dev/null 2>&1
    echo export HADOOP_COMMON_HOME=$HADOOP_PREFIX | tee -a ~/.bashrc > /dev/null 2>&1
    echo export HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop | tee -a ~/.bashrc > /dev/null 2>&1
    echo export HADOOP_HDFS_HOME=$HADOOP_PREFIX | tee -a ~/.bashrc > /dev/null 2>&1
    echo export HADOOP_MAPRED_HOME=$HADOOP_PREFIX | tee -a ~/.bashrc > /dev/null 2>&1
    echo export HADOOP_YARN_HOME=$HADOOP_PREFIX | tee -a ~/.bashrc > /dev/null 2>&1
    echo export PATH=$PATH:$HADOOP_PREFIX/bin | tee -a ~/.bashrc > /dev/null 2>&1
fi

if [ ! -d "spark" ]
then
    popd > /dev/null 2>&1
    if [ ! -f "spark-3.0.0-bin-hadoop3.2.tgz" ]; then  
        wget https://archive.apache.org/dist/spark/spark-3.0.0/spark-3.0.0-bin-hadoop3.2.tgz
    fi
    tar -xvzf spark-3.0.0-bin-hadoop3.2.tgz
    sudo mv spark-3.0.0-bin-hadoop3.2 /usr/local/spark
    echo export SPARK_HOME=/usr/local/spark | tee -a ~/.bashrc > /dev/null 2>&1
else
    popd > /dev/null 2>&1
fi

# build SparkBench.
echo -e "building SparkBench..."
pushd ../../../HiBench > /dev/null 2>&1
mvn -Psparkbench -Dspark=3.0 -Dscala=2.12 clean package
popd > /dev/null 2>&1
source ~/.bashrc
