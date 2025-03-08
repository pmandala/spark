from pyspark.sql import SparkSession

# Initialize a Spark session
spark = SparkSession.builder.appName("BatchJob").getOrCreate()

# Sample dataset
data = [(1, "Alice"), (2, "Bob"), (3, "Charlie")]

# Create a DataFrame from the sample data
df = spark.createDataFrame(data, ["id", "name"])

# Display the DataFrame contents
df.show()

# Stop the Spark session to release resources
spark.stop()

