% warning off;
clear all;
close all;



max_episodes=2;
sample_time=0.1;
stopTime=40;
interval=1;
continous_action=false;
options.algo='DQN';
USE_PRE_TRAINED_MODEL = false;
PRE_TRAINED_MODEL_FILE=['./sa/Agent' num2str(1) '.mat'];

disp('ready to train');
trainRL;
disp('all done');
save('all_ddpg.mat','agent','trainingStats','options');

% save('all_ddpg.mat');


