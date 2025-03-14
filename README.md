# Apache Spark Setup


## Prerequisites


```
* Dowmload JDK 17
* Download [Spark 3.5.5] (https://archive.apache.org/dist/spark/spark-3.5.5/spark-3.5.5-bin-hadoop3.tgz) 

```



### Build the spark images

```
make build
```

### Start the spark cluster with single worker node

```
make up

```

### Stop the spark cluster

```
make down
```

### Spark UI

```
http://localhost:8080
```

### Spark job logs

```
ls -l logs

```

### Spark Jobs Examples

```
docker exec -it spark-master spark-submit --master spark://spark-master:7077 --deploy-mode client --class org.apache.spark.examples.SparkPi /opt/spark/examples/jars/spark-examples_2.12-3.5.5.jar

docker exec -it spark-master spark-submit --master spark://spark-master:7077 --deploy-mode client --driver-memory 1g --executor-memory 1g --executor-cores 1 --class org.apache.spark.examples.SparkPi /opt/spark/examples/jars/spark-examples_2.12-3.5.5.jar


curl -XPOST http://localhost:6066/v1/submissions/create \
--header "Content-Type:application/json;charset=UTF-8" \
--data '{
  "appResource": "",
  "sparkProperties": {
    "spark.master": "spark://spark-master:7077",
    "spark.app.name": "Spark Pi",
    "spark.submit.deployMode": "client",
    "spark.eventLog.enabled": "false",
    "spark.dynamicAllocation.enabled": "false",
    "spark.driver.memory": "1g",
    "spark.driver.cores": "1",
    "spark.jars": "/opt/spark/examples/jars/spark-examples_2.12-3.5.5.jar",
    "spark.driver.extraJavaOptions": "--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.invoke=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.base/java.net=ALL-UNNAMED --add-opens=java.base/java.nio=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.util.concurrent=ALL-UNNAMED --add-opens=java.base/java.util.concurrent.atomic=ALL-UNNAMED --add-opens=java.base/jdk.internal.ref=ALL-UNNAMED --add-opens=java.base/sun.nio.ch=ALL-UNNAMED --add-opens=java.base/sun.nio.cs=ALL-UNNAMED --add-opens=java.base/sun.security.action=ALL-UNNAMED --add-opens=java.base/sun.util.calendar=ALL-UNNAMED --add-opens=java.security.jgss/sun.security.krb5=ALL-UNNAMED",
    "spark.executor.extraJavaOptions": "--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.invoke=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.base/java.net=ALL-UNNAMED --add-opens=java.base/java.nio=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.util.concurrent=ALL-UNNAMED --add-opens=java.base/java.util.concurrent.atomic=ALL-UNNAMED --add-opens=java.base/jdk.internal.ref=ALL-UNNAMED --add-opens=java.base/sun.nio.ch=ALL-UNNAMED --add-opens=java.base/sun.nio.cs=ALL-UNNAMED --add-opens=java.base/sun.security.action=ALL-UNNAMED --add-opens=java.base/sun.util.calendar=ALL-UNNAMED --add-opens=java.security.jgss/sun.security.krb5=ALL-UNNAMED"
  },
  "clientSparkVersion": "",
  "mainClass": "org.apache.spark.examples.SparkPi",
  "environmentVariables": { 
    "SPARK_ENV_LOADED": "1"
  },
  "action": "CreateSubmissionRequest",
  "appArgs": [ "100" ]
}'

```


```
curl -iv -X POST --data '{"file": "/jobs/spark_job.py"}' -H "Content-Type: application/json" http://localhost:8998/batches

curl -XPOST http://localhost:6066/v1/submissions/create  \
--header "Content-Type:application/json;charset=UTF-8" \
--data '{
  "appResource": "",
  "sparkProperties": {
    "spark.master": "spark://master:7077",
    "spark.app.name": "Spark Py Job",
    "spark.driver.memory": "1g",
    "spark.driver.cores": "1",
    "spark.jars": "",
    "spark.driver.extraJavaOptions": "--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.invoke=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.base/java.net=ALL-UNNAMED --add-opens=java.base/java.nio=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.util.concurrent=ALL-UNNAMED --add-opens=java.base/java.util.concurrent.atomic=ALL-UNNAMED --add-opens=java.base/jdk.internal.ref=ALL-UNNAMED --add-opens=java.base/sun.nio.ch=ALL-UNNAMED --add-opens=java.base/sun.nio.cs=ALL-UNNAMED --add-opens=java.base/sun.security.action=ALL-UNNAMED --add-opens=java.base/sun.util.calendar=ALL-UNNAMED --add-opens=java.security.jgss/sun.security.krb5=ALL-UNNAMED",
    "spark.executor.extraJavaOptions": "--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.invoke=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.base/java.net=ALL-UNNAMED --add-opens=java.base/java.nio=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.util.concurrent=ALL-UNNAMED --add-opens=java.base/java.util.concurrent.atomic=ALL-UNNAMED --add-opens=java.base/jdk.internal.ref=ALL-UNNAMED --add-opens=java.base/sun.nio.ch=ALL-UNNAMED --add-opens=java.base/sun.nio.cs=ALL-UNNAMED --add-opens=java.base/sun.security.action=ALL-UNNAMED --add-opens=java.base/sun.util.calendar=ALL-UNNAMED --add-opens=java.security.jgss/sun.security.krb5=ALL-UNNAMED"
  },
  "clientSparkVersion": "",
  "mainClass": "org.apache.spark.deploy.SparkSubmit",
  "environmentVariables": { },
  "action": "CreateSubmissionRequest",
  "appArgs": [ "/jobs/spark_job.py" ]
}'

```
