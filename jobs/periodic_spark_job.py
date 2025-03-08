import schedule
import time
from pyspark.sql import SparkSession

# Function to run a Spark job
def run_spark_job():
    # Initialize Spark session
    spark = SparkSession.builder.appName("PeriodicJob").getOrCreate()
    
    # Sample data for demonstration
    data = [(1, "Alice"), (2, "Bob"), (3, "Charlie")]
    df = spark.createDataFrame(data, ["id", "name"])
    
    # Display the dataframe contents
    df.show()
    
    # Stop the Spark session to release resources
    spark.stop()

# Schedule the job to run every 5 minutes
schedule.every(5).minutes.do(run_spark_job)

# Continuously check and execute scheduled tasks
while True:
    schedule.run_pending()
    time.sleep(1)


