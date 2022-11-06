# Running Benchmarks:
- [ ] [Ray object store capacity and performance changes](#instructions-for-ray-object-store-capacity-manipulation)
- [ ] [HiBench on Spark with and without disk usage](#instructions-for-running-spark-bench)
- [ ] [Peak memory usage prediction viabilities](#instructions-for-peak-memory-prediction-evaluation)

### Motive
We wanted to assess whether pursuing remote memory would actually be beneficial to existing memory intensive systems. While memory is a commonly known bottleneck, we wanted to confirm that memory and disk spillover incurs significant overheads on traditional systems like Spark and newer systems like Ray. 

## Instructions for Ray Object Store Capacity Manipulation

## Instructions for Running Spark Bench

### Our Configurations
For preliminary testing of the viability of remote memory, we ran SparkBench (HiBench) on a single node. 

## Instructions for Peak Memory Prediction Evaluation