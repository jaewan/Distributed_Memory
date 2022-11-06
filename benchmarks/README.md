# Running Benchmarks:
- [ ] [Ray object store capacity and performance changes](#instructions-for-ray-object-store-capacity-manipulation)
- [ ] [HiBench on Spark with and without disk usage](#instructions-for-running-spark-bench)
- [ ] [Peak memory usage prediction viabilities](#instructions-for-peak-memory-prediction-evaluation)

### Motive
We wanted to assess whether pursuing remote memory would actually be beneficial to existing memory intensive systems. While memory is a commonly known bottleneck, we wanted to confirm that memory and disk spillover incurs significant overheads on traditional systems like Spark and newer systems like Ray. 

## Instructions for Ray Object Store Capacity Manipulation

## Spark Bench
### Running spark bench with our configurations
For preliminary testing of the viability of remote memory, we ran SparkBench (HiBench) on a single node. We ran on an Amazon AWS EC2 instance. To replicate our setup, run `setup.sh`. Note that this will install Spark and Hadoop (with specific versions) in `/usr/local` as well as downloading the HiBench repo into the parent folder. After setting up using the setup script, run `run.sh` to get data within the `results` folder that will automatically be generated. To delete all external downloads after testing, run `clean.sh`.

## Instructions for Peak Memory Prediction Evaluation