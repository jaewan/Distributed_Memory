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
pushd ../../.. > /dev/null 2>&1
echo -e "checking for spark and hadoop..."

if [ ! -d "hadoop" ]
then
    wget https://dlcdn.apache.org/hadoop/common/hadoop-3.2.4/hadoop-3.2.4.tar.gz
    tar -xzvf hadoop-3.2.4.tar.gz
    mv hadoop-3.2.4 hadoop

    # add java path
    current_dir=$PWD; cd ../../../hadoop
    echo export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::") \
    | tee -a etc/hadoop/hadoop-env.sh > /dev/null 2>&1
    cd $current_dir
fi

if [ ! -d "spark" ]
then
    wget https://archive.apache.org/dist/spark/spark-3.0.0/spark-3.0.0-bin-hadoop3.2.tgz
    tar -xvzf spark-3.0.0-bin-hadoop3.2.tgz
    mv spark-3.0.0-bin-hadoop3.2 spark
fi
popd > /dev/null 2>&1

# build SparkBench.
echo -e "building SparkBench..."
pushd ../../../HiBench > /dev/null 2>&1
mvn -Psparkbench -Dspark=3.0 -Dscala=2.12 clean package
popd > /dev/null 2>&1
