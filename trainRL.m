mdl='new';
load('bus.mat','Job');
options.max_episodes=max_episodes;
options.sample_time=sample_time;
options.stopTime=stopTime;
options.interval=interval;
options.continous_action=continous_action;
options.PRE_TRAINED_MODEL_FILE=PRE_TRAINED_MODEL_FILE;
options.USE_PRE_TRAINED_MODEL = USE_PRE_TRAINED_MODEL; 

% Load parameter values to defaults
initParamsDefault;

if(strcmpi(options.algo,'ddpg'))
    initialise_ddpg_agent;
elseif (strcmpi(options.algo,'dqn'))
    initialise_rl_agent;
else
    disp('Select either ddpg or dqn');
end

if options.USE_PRE_TRAINED_MODEL
    % Load experiences from pre-trained agent
    sprintf('- Continue training pre-trained model: %s', options.PRE_TRAINED_MODEL_FILE);
    load(options.PRE_TRAINED_MODEL_FILE,'saved_agent');
    agent = saved_agent;
    agent.AgentOptions.ResetExperienceBufferBeforeTraining = false;
end
trainingOptions = rlTrainingOptions(...
    'MaxEpisodes',options.max_episodes,...
    'MaxStepsPerEpisode',floor(options.stopTime/options.interval),...
    'ScoreAveragingWindowLength',5,...
    'Verbose',true,...
    ...%     'Plots','none',...
    'StopTrainingCriteria','AverageReward',...
    'StopTrainingValue',0,...
    'SaveAgentCriteria','EpisodeReward',...
    'SaveAgentDirectory','sa_ddpg',...
    'SaveAgentValue',-20);
trainOpts.UseParallel = true;
trainOpts.ParallelizationOptions.Mode = "async";
trainOpts.ParallelizationOptions.DataToSendFromWorkers = "experiences";
trainOpts.ParallelizationOptions.StepsUntilDataIsSent = 30;
trainOpts.ParallelizationOptions.WorkerRandomSeeds = -1;
trainingStats = train(agent,env,trainingOptions);

