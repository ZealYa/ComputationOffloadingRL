env = rlSimulinkEnv(mdl,[mdl '/RL Agent'],obsInfo,actInfo);

env.ResetFcn=@(in) resetEnvironment(in);

%% Extract Data from Environment
obsInfo = getObservationInfo(env);
numObservations = obsInfo.Dimension(1);
actInfo = getActionInfo(env);
numActions = actInfo.Dimension(1);
% numActions=size(combs,2);