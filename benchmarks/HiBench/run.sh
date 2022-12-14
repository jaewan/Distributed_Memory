source ./run-partial.sh

# cp (and remove existing) files for hadoop.conf.
cp configs/hadoop.conf ../../../HiBench/conf/hadoop.conf

# start hadoop, spark, and yarn instance.
/usr/local/spark/sbin/start-master.sh
/usr/local/spark/sbin/start-slave.sh spark://172.31.12.13:7077

# create directories if needed.
if [ ! -d "result" ]; then
    mkdir result
    cd result
    mkdir memory
    mkdir disk
    cd ..
fi

# run sparkbench with pure memory option.
cp configs/spark1.conf ../../../HiBench/conf/spark.conf
run-partial memory

# run sparkbench with pure disk option.
cp configs/spark2.conf ../../../HiBench/conf/spark.conf
#run-partial disk

# save results to separate destination --> /results/d
#pushd ../../.. > /dev/null 2>&1
#mv HiBench/report Distributed_Memory/results/d
#popd > /dev/null 2>&1


/usr/local/spark/sbin/stop-master.sh
/usr/local/spark/sbin/stop-slave.sh
