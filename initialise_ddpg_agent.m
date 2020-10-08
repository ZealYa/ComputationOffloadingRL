% This is from the flying robot example below:
% https://uk.mathworks.com/help/reinforcement-learning/ug/train-agent-to-control-flying-robot.html

% specify the number of outputs for the hidden layers.
% initialise_ml_common;
% hiddenLayerSize = 24;
% 
% observationPath = [
%     imageInputLayer([numObservations 1 1],'Normalization','none','Name','observation')
%     fullyConnectedLayer(hiddenLayerSize,'Name','fc1')
%     reluLayer('Name','relu1')
%     fullyConnectedLayer(hiddenLayerSize,'Name','fc2')
%     additionLayer(2,'Name','add')
%     reluLayer('Name','relu2')
%     fullyConnectedLayer(hiddenLayerSize/2,'Name','fc3')
%     reluLayer('Name','relu3')
%     fullyConnectedLayer(1,'Name','fc4')];
% actionPath = [
%     imageInputLayer([numActions 1 1],'Normalization','none','Name','action')
%     fullyConnectedLayer(hiddenLayerSize,'Name','fc5')];
% 
% % create the layerGraph
% criticNetwork = layerGraph(observationPath);
% criticNetwork = addLayers(criticNetwork,actionPath);
% 
% % connect actionPath to obervationPath
% criticNetwork = connectLayers(criticNetwork,'fc5','add/in2');
% 
% criticOptions = rlRepresentationOptions('LearnRate',1e-02,'GradientThreshold',1);
% 
% critic = rlRepresentation(criticNetwork,obsInfo,actInfo,...
%     'Observation',{'observation'},'Action',{'action'},criticOptions);
% 
% actorNetwork = [
%     imageInputLayer([numObservations 1 1],'Normalization','none','Name','observation')
%     fullyConnectedLayer(hiddenLayerSize,'Name','fc1')
%     reluLayer('Name','relu1')
%     fullyConnectedLayer(hiddenLayerSize,'Name','fc2')
%     reluLayer('Name','relu2')
%     fullyConnectedLayer(hiddenLayerSize/2,'Name','fc3')
%     reluLayer('Name','relu3')
%     fullyConnectedLayer(numActions,'Name','fc4')
%     tanhLayer('Name','tanh1')];
% 
% actorOptions = rlRepresentationOptions('LearnRate',1e-03,'GradientThreshold',1);
% 
% actor = rlRepresentation(actorNetwork,obsInfo,actInfo,...
%     'Observation',{'observation'},'Action',{'tanh1'},actorOptions);

[criticNetwork, actorNetwork]=createNetworks(numObservations,numActions);
criticOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-3, ... 
                                        'GradientThreshold',1,'L2RegularizationFactor',1e-5);
actorOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-4, ...
                                       'GradientThreshold',1,'L2RegularizationFactor',1e-5);
critic = rlRepresentation(criticNetwork,obsInfo,actInfo,'Observation',{'observation'},'Action',{'action'},criticOptions);
actor  = rlRepresentation(actorNetwork,obsInfo,actInfo,'Observation',{'observation'},'Action',{'ActorTanh1'},actorOptions);
agentOptions = rlDDPGAgentOptions(...
    'SampleTime',options.interval,...
    'TargetSmoothFactor',1e-3,...
    'ExperienceBufferLength',1e6 ,...
    'SaveExperienceBufferWithAgent', true, ...
    'DiscountFactor',0.99,...
    'MiniBatchSize',256);
agentOptions.NoiseOptions.Variance = 1e-1;
agentOptions.NoiseOptions.VarianceDecayRate = 1e-6;

agent = rlDDPGAgent(actor,critic,agentOptions);


