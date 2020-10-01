# ComputationOffloadingRL
Matlab project for fairspace


## This project was written and tested in Matlab2019a.

Requires: Reinforcement Learning toolbox

## Usage:

To train the network edit parameters given below in train_ddpg.m or train_dqn.m and run


max_episodes=2000;

sample_time=0.1;

stopTime=40;

interval=1;

continous_action=false;

Sample time is how fast the simulink model is run (except for the Sim Events parts). Interval is how quickly the reinforcement learning agent is running.
