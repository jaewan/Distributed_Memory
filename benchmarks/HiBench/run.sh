# cp (and remove existing) files for hadoop.conf.
cp configs/hadoop.conf ../../../HiBench/conf/hadoop.conf

# start hadoop, spark, and yarn instance.
/usr/local/hadoop/sbin/start-all.sh
/usr/local/spark/sbin/start-master.sh
/usr/local/spark/sbin/start-slave.sh spark://172.31.12.13:7077

# run sparkbench with pure memory option.
cp configs/spark1.conf ../../../HiBench/conf/spark.conf
pushd ../../../HiBench > /dev/null 2>&1
./bin/run_all.sh
popd > /dev/null 2>&1

# save results to separate destination --> /results/m
pushd ../../.. > /dev/null 2>&1
#mv HiBench/report Distributed_Memory/results/m
popd > /dev/null 2>&1

# run sparkbench with pure disk option.
#cp configs/spark2.conf ../../../HiBench/conf/spark.conf


# save results to separate destination --> /results/d
#current_dir=$PWD; cd ../../..
#mv HiBench/report Distributed_Memory/results/d
#cd $current_dir

/usr/local/spark/sbin/stop-master.sh
/usr/local/spark/sbin/stop-slave.sh
