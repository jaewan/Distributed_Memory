function run-partial {
    pushd ../../../HiBench/bin/workloads > /dev/null 2>&1

    # benchmarks to run
    MICRO="sleep sort terasort wordcount repartition dfsioe"
    GRAPH="nweight pagerank"
    STREAMING="fixwindow identity"
    ML="als bayes correlation gbt gmm kmeans linear lr pca rf summarizer svd svm"
    SQL="aggregation join scan"

    # run micros
    #for val in $MICRO; do
    #    micro/$val/prepare/prepare.sh
    #    micro/$val/spark/run.sh
    #done

    # run graph
    #for val in $GRAPH; do
    #    graph/$val/prepare/prepare.sh
    #    graph/$val/spark/run.sh
    #done

    # run streaming
    #for val in $STREAMING; do
    #    streaming/$val/prepare/prepare.sh
    #    streaming/$val/spark/run.sh
    #done

    # run machine learning
    #for val in $ML; do
    #    ml/$val/prepare/prepare.sh
    #    ml/$val/spark/run.sh
    #done

    # run SQL
    for val in $SQL; do
        sql/$val/prepare/prepare.sh
        sql/$val/spark/run.sh
    done

    popd > /dev/null 2>&1
}

