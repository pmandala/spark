#!/bin/bash

echo "spark-submit: Spark Pi "
docker exec -it spark-master spark-submit --master spark://spark-master:7077 \
                                        --deploy-mode client \
                                        --driver-memory 1g \
                                        --executor-memory 1g \
                                        --executor-cores 1 \
                                        --class org.apache.spark.examples.SparkPi \
                                        /opt/spark/examples/jars/spark-examples_2.12-3.5.5.jar
echo "Spark Rest: Spark Pi "
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


