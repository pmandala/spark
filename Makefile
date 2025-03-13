clean:
	docker rm -vf $$(docker ps -aq) 2> /dev/null || true
	docker rmi -f $$(docker images -aq) 2> /dev/null || true

build:
	docker-compose build

build-nc:
	docker-compose build --no-cache

build-progress:
	docker-compose build --no-cache --progress=plain

down:
	docker-compose down

run-scaled:
	docker-compose up --scale spark-worker=3

up:
	echo "Cleaning up logs..."
	rm -rf logs/*
	docker-compose up -d

stop:
	docker-compose stop

submit:
	docker exec spark-master spark-submit --master spark://spark-master:7077 --deploy-mode client /jobs/$(app)
        #docker exec -it spark-master spark-submit   --master spark://spark-master:7077   --deploy-mode client /jobs/word_non_null.py


