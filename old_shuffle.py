import argparse
import csv
import ray
import numpy as np
from ray import ObjectRef
from ray.clusters_utils import Cluster
import json
from time import perf_counter

# ******System Config******
SPILL_DIR = '~/RAY_SPILL_DIR'

parser = argparse.ArgumentParser()
parser.add_argument('--obj_size', type=int, required=True)
parser.add_argument('--file', type=argparse.FileType('w'))
args = parser.parse_args()
OBJECT_STORE_SIZE = args.obj_size
f_path = args.file

def simple_shuffle(
    *,
    input_reader: Callable[[PartitionID], Iterable[InType]],
    input_num_partitions: int,
    output_num_partitions: int,
    output_writer: Callable[[PartitionID, List[Union[ObjectRef, Any]]], OutType],
    partitioner: Callable[
        [Iterable[InType], int], Iterable[PartitionID]
    ] = round_robin_partitioner,
    object_store_writer: ObjectStoreWriter = ObjectStoreWriter,
    tracker: _StatusTracker = None,
    streaming: bool = True,
) -> List[OutType]:
    """Simple distributed shuffle in Ray.
    Args:
        input_reader: Function that generates the input items for a
            partition (e.g., data records).
        input_num_partitions: The number of input partitions.
        output_num_partitions: The desired number of output partitions.
        output_writer: Function that consumes a iterator of items for a
            given output partition. It returns a single value that will be
            collected across all output partitions.
        partitioner: Partitioning function to use. Defaults to round-robin
            partitioning of input items.
        object_store_writer: Class used to write input items to the
            object store in an efficient way. Defaults to a naive
            implementation that writes each input record as one object.
        tracker: Tracker actor that is used to display the progress bar.
        streaming: Whether or not if the shuffle will be streaming.
    Returns:
        List of outputs from the output writers.
    """

    @ray.remote(num_returns=output_num_partitions)
    def shuffle_map(i: PartitionID) -> List[List[Union[Any, ObjectRef]]]:
        writers = [object_store_writer() for _ in range(output_num_partitions)]
        for out_i, item in partitioner(input_reader(i), output_num_partitions):
            writers[out_i].add(item)
        return [c.finish() for c in writers]

    @ray.remote
    def shuffle_reduce(
        i: PartitionID, *mapper_outputs: List[List[Union[Any, ObjectRef]]]
    ) -> OutType:
        input_objects = []
        assert len(mapper_outputs) == input_num_partitions
        for obj_refs in mapper_outputs:
            for obj_ref in obj_refs:
                input_objects.append(obj_ref)
        return output_writer(i, input_objects)

    shuffle_map_out = [shuffle_map.remote(i) for i in range(input_num_partitions)]

    shuffle_reduce_out = [
        shuffle_reduce.remote(
            j, *[shuffle_map_out[i][j] for i in range(input_num_partitions)]
        )
        for j in range(output_num_partitions)
    ]

    if tracker:
        tracker.register_objectrefs.remote(
            [map_out[0] for map_out in shuffle_map_out], shuffle_reduce_out
        )
        render_progress_bar(tracker, input_num_partitions, output_num_partitions)

    return ray.get(shuffle_reduce_out)

def shuffle(ray_address=None,
    object_store_memory,
    num_partitions=5,
    partition_size=200e6,
    num_nodes=None,
    num_cpus=8,
    no_streaming=False,
    use_wait=False,
    tracker=None,):
        
        partition_size = int(partition_size)
        num_partitions = num_partitions
        rows_per_partition = partition_size // (8 * 2)
        if tracker is None:
            tracker = _StatusTracker.remote()
        use_wait = use_wait


        start_time = perf_counter()
        end_time = perf_counter()
        return end_time - start_time

if __main__:
	ray.init(_system_config={"object_spilling_config": json.dumps({"type": "filesystem", "params": {"directory_path": SPILL_DIR}},)}, object_store_memory=OBJECT_STORE_SIZE, RAY_ENABLE_MAC_LARGE_OBJECT_STORE=1)

	f = open('f_path', 'w')

	writer = csv.writer(f)
	row = [OBJECT_STORE_SIZE, throughput]
	writer.writerow(row)

	f.close()

