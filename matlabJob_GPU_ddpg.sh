#!/bin/bash
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=7764
#SBATCH --gres=gpu:K80:1

#SBATCH --time=48:00:00

module purge

module load CUDA
module load MATLAB/2019a

srun matlab -nodisplay -nosplash < train_ddpg.m
