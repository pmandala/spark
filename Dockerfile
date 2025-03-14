#
FROM oraclelinux:7-slim

# SPARK
ENV SPARK_VERSION=3.5.5
ENV PIP_ROOT_USER_ACTION=ignore
ENV SPARK_HOME="/opt/spark"
ENV HADOOP_HOME="/opt/hadoop"
ENV SPARK_MASTER_HOST=spark-master
ENV SPARK_MASTER_PORT=7077
ENV SPARK_MASTER="spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}"
ENV SPARK_MASTER_WEBUI_PORT=8080
ENV SPARK_WORKER_WEBUI_PORT=8081

# JDK 17 & Python 3.8
COPY jdk-17.0.14_linux-x64_bin.rpm /tmp
RUN yum update -y && \
    yum install -y oracle-softwarecollection-release-el7 && \
    yum install -y scl-utils rh-python38 && \
    scl enable rh-python38 bash && \
    yum install -y python3-pip python3-numpy python3-matplotlib python3-scipy python3-pandas python3-simpy \
	rsync vi curl wget unzip procps ca-certificates tar && \
    yum -y localinstall /tmp/jdk-17.0.14_linux-x64_bin.rpm && \
    yum -y clean all && \
    rm  -rf /var/cache/yum && \
    mkdir -p ${HADOOP_HOME}  ${SPARK_HOME} 

WORKDIR ${SPARK_HOME}

# SPARK with HADOOP
COPY spark-${SPARK_VERSION}-bin-hadoop3.tgz .
# RUN curl https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz -o spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
RUN tar xvzf ./spark-${SPARK_VERSION}-bin-hadoop3.tgz --directory /opt/spark --strip-components 1 && \
    rm -rf ./spark-${SPARK_VERSION}-bin-hadoop3.tgz
COPY spark-defaults.conf "$SPARK_HOME/conf"
ENV PATH="$SPARK_HOME/sbin:$SPARK_HOME/bin:${PATH}"
RUN chmod u+x $SPARK_HOME/sbin/* && \
    chmod u+x $SPARK_HOME/bin/*

# Install python deps
COPY requirements.txt .
RUN pip3 install -r requirements.txt

ENV PYSPARK_PYTHON python3
ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH

#
RUN mkdir -p /data/inputs /data/outputs /logs/spark /log/worker /tmp/spark-events /tmp/spark-history 

# entrypoint script
COPY start_spark.sh .
RUN chmod u+x ./start_spark.sh
ENTRYPOINT ["./start_spark.sh"]
CMD [ "bash" ]

# 
EXPOSE ${SPARK_MASTER_WEBUI_PORT} ${SPARK_MASTER_PORT}


