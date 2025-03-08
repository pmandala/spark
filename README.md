### Build the spark images

```
docker-compose build
```

### Start the spark cluster with single worker node

```
docker-compose up

docker-compose up --scale spark-worker=3
```

### Stop the spark cluster

```
docker-compose down
```

### Spark job submit

```
docker exec -it spark-master spark-submit  --master spark://spark-master:7077 --deploy-mode client --executor-memory 4G --total-executor-cores 2 /jobs/spark_job.py
```

### Spark UI

```
http://localhost:8080
```

### Spark job logs

```
docker logs -f spark-master
docker logs -f spark-worker
```

