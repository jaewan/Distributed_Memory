RESULT_FILE='data/shuffle_result'

# run shuffle
PARTITION=(5 5 5 5 5)
SIZES=(400e6 400e6 400e6 400e6 400e6)
MEMORY=(25e7 5e8 1e9 2e9 4e9)

for i in {0..4}
do
    RESULT_PATH=$RESULT_FILE$i.csv
    RAY_ENABLE_MAC_LARGE_OBJECT_STORE=1 python shuffle.py  --file $RESULT_PATH --num-partitions ${PARTITION[i]} --partition-size ${SIZES[i]} --object-store-memory ${MEMORY[i]} 
done


#for i in {0..4}
#do
#    RESULT_PATH=$RESULT_FILE$i.csv
#    echo 'object_store_memory,delta' >> $RESULT_PATH
#done

#for j in {0..9}
#do
#    for i in {0..4}
#    do
#        RESULT_PATH=$RESULT_FILE$i.csv
#        RAY_ENABLE_MAC_LARGE_OBJECT_STORE=1 python shuffle.py  --file $RESULT_PATH --num-partitions ${PARTITION[i]} --partition-size ${SIZES[i]} --object-store-memory ${MEMORY[i]} 
#    done
#done

declare -i a=0
RESULT_PATH0=$RESULT_FILE$a.csv
declare -i b=1
RESULT_PATH1=$RESULT_FILE$b.csv
declare -i c=2
RESULT_PATH2=$RESULT_FILE$c.csv
declare -i d=3
RESULT_PATH3=$RESULT_FILE$d.csv
declare -i e=4
RESULT_PATH4=$RESULT_FILE$e.csv
python plot.py --file0 $RESULT_PATH0 --file1 $RESULT_PATH1 --file2 $RESULT_PATH2 --file3 $RESULT_PATH3 --file4 $RESULT_PATH4
# plot graph
#X_VALUE = 
#./plot.py $RESULT_FILE # how to pass in SIZES as the x-value list and result of shuffle.py
		       # as the y-value list in plot.py? -> write result in $RESULT_FILE

