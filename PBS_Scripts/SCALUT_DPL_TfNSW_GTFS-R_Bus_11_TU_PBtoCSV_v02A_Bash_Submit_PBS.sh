#!/bin/bash
#
YEAR=2020
MONTH=10
DataDir="/scratch/RDS-FEI-SCALUT-RW/TfNSW_GTFS_Buses"
#
for DAY in {01..31}
do
	# Define Variables
	FileTP="${YEAR}m${MONTH}d${DAY}"
	NAME="${YEAR}m${MONTH}d${DAY}_TU_PB2CSV"
	
	echo "Submitting: ${NAME}"
	
	# Generate Portable Batch System (PBS) Script 
	PBS="#!/bin/bash\n\
	#PBS -P RDS-FEI-SCALUT-RW\n\
	#PBS -N ${NAME}\n\
	#PBS -l select=1:ncpus=1:mem=24GB\n\
	#PBS -l walltime=12:00:00\n\
	#PBS -q defaultQ\n\
	cd \$PBS_O_WORKDIR\n\
	module load python/3.8.2\n\
	python SCALUT_DPL_TfNSW_GTFS-R_Bus_11_TU_PBtoCSV_v02A.py ${DataDir} ${FileTP}"

	# Submit Job
	echo -e ${PBS} | qsub 

	# Include small delay to avoid overloading the job submission process
	sleep 0.5
done
