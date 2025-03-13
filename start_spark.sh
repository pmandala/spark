#!/bin/bash

source "/opt/spark/bin/load-spark-env.sh"

env

cd $SPARK_HOME/sbin

# When the spark work_load is master run class org.apache.spark.deploy.master.Master
if [ "$SPARK_WORKLOAD" == "master" ]; then
	#/opt/livy/bin/livy-server start &
	#cd /opt/spark/bin && ./spark-class org.apache.spark.deploy.master.Master --ip $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT >> $SPARK_MASTER_LOG
	./start-master.sh -p $SPARK_MASTER_PORT
elif [ "$SPARK_WORKLOAD" == "worker" ]; then
	# When the spark work_load is worker run class org.apache.spark.deploy.master.Worker
	#cd /opt/spark/bin && ./spark-class org.apache.spark.deploy.worker.Worker --webui-port $SPARK_WORKER_WEBUI_PORT $SPARK_MASTER >> $SPARK_WORKER_LOG
	./start-worker.sh "$SPARK_MASTER"
elif [ "$SPARK_WORKLOAD" == "history" ]; then
  	./start-history-server.sh
elif [ "$SPARK_WORKLOAD" == "submit" ]; then
    	echo "SPARK SUBMIT"
else
    	echo "Undefined Workload Type $SPARK_WORKLOAD, must specify: master, worker, history, submit"
fi

tail -f /dev/null


