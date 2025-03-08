
# Use the bitnami Spark image as it comes pre-configured with necessary Spark components
FROM bitnami/spark:3.5

USER root
RUN install_packages curl

RUN pip install schedule


