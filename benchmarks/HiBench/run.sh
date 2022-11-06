# cp (and remove existing) files for hadoop.conf.
cp configs/hadoop.conf ../../../HiBench/conf/hadoop.conf

# start hadoop, spark, and yarn instance.

/usr/local/bin/spark/sbin/start-master.sh

# run sparkbench with pure memory option.
cp configs/spark1.conf ../../../HiBench/conf/spark.conf


# save results to separate destination --> /results/m
#current_dir=$PWD; cd ../../..
#mv HiBench/report Distributed_Memory/results/m
#cd $current_dir

# run sparkbench with pure disk option.
#cp configs/spark2.conf ../../../HiBench/conf/spark.conf


# save results to separate destination --> /results/d
#current_dir=$PWD; cd ../../..
#mv HiBench/report Distributed_Memory/results/d
#cd $current_dir

/usr/local/bin/spark/sbin/stop-master.sh
