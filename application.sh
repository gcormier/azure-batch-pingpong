#!/usr/bin/env bash
#Command script to run pingpong performance testing on multiple machines as MPI task on Azure Batch.
#Usage: application-cmd [nodes]

#For more details of MPI/RDMA, visit: https://docs.microsoft.com/en-us/azure/virtual-machines/linux/classic/rdma-cluster

#Use the intel mpi exists in CentOS-HPC 7.4 image
source /opt/intel/impi/5.1.3.223/bin64/mpivars.sh
#prepare environment variables for intel mpi to use RDMA

#export I_MPI_FABRICS=tcp		# Wonder if this will work?

export I_MPI_FABRICS=shm:dapl
export I_MPI_DAPL_PROVIDER=ofa-v2-ib0
export I_MPI_DYNAMIC_CONNECTION=0

# Run mpi application with appropriate parameters
mpirun -n $1 -ppn 1 -hosts $AZ_BATCH_HOST_LIST IMB-MPI1 pingpong