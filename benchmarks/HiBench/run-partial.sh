function run-partial {
    mode="$1"

    pushd ../../../HiBench/bin/workloads > /dev/null 2>&1

    # benchmarks to run
    MICRO="sleep sort terasort wordcount repartition dfsioe"
    GRAPH="nweight pagerank"
    STREAMING="fixwindow"
    ML="als bayes correlation gbt gmm kmeans linear lr pca rf summarizer svd svm"
    SQL="aggregation join scan"

    for iter in "1 2 3 4 5"; do
        # remove existing report file. 
        rm -rf ../../report

        # run micros
        for val in $MICRO; do
            micro/$val/prepare/prepare.sh
            micro/$val/spark/run.sh
        done

        # run graph
        for val in $GRAPH; do
            graph/$val/prepare/prepare.sh
            graph/$val/spark/run.sh
        done

        # run streaming
        for val in $STREAMING; do
            streaming/$val/prepare/prepare.sh
            streaming/$val/spark/run.sh
        done

        # run machine learning
        for val in $ML; do
            ml/$val/prepare/prepare.sh
            ml/$val/spark/run.sh
        done

        # run SQL
        for val in $SQL; do
            sql/$val/prepare/prepare.sh
            sql/$val/spark/run.sh
        done

        pushd ../../.. > /dev/null 2>&1
        NAME="Distributed_Memory/benchmarks/HiBench/report/${mode}/hibench_${iter}.report"
        cp HiBench/report/hibench.report $NAME
        popd > /dev/null 2>&1
    done

    popd > /dev/null 2>&1
}

