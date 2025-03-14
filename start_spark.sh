#!/bin/bash

source "/opt/spark/bin/load-spark-env.sh"

cd $SPARK_HOME/sbin

# When the spark work_load is master run class org.apache.spark.deploy.master.Master
if [ "$SPARK_WORKLOAD" == "master" ]; then
	./start-master.sh -p $SPARK_MASTER_PORT
elif [ "$SPARK_WORKLOAD" == "worker" ]; then
	# When the spark work_load is worker run class org.apache.spark.deploy.master.Worker
	./start-worker.sh "$SPARK_MASTER"
elif [ "$SPARK_WORKLOAD" == "history" ]; then
  	./start-history-server.sh
elif [ "$SPARK_WORKLOAD" == "submit" ]; then
    	echo "SPARK SUBMIT"
else
    	echo "Undefined Workload Type $SPARK_WORKLOAD, must specify: master, worker, history, submit"
fi

tail -f /dev/null


