% initialise_ml_common;

no_hidden=24;
statePath = [
    imageInputLayer([numObservations 1 1], 'Normalization', 'none', 'Name', 'state')
    fullyConnectedLayer(no_hidden, 'Name', 'CriticStateFC1')
    reluLayer('Name', 'CriticRelu1')
    fullyConnectedLayer(no_hidden, 'Name', 'CriticStateFC2')];
actionPath = [
    imageInputLayer([numActions 1 1], 'Normalization', 'none', 'Name', 'action')
    fullyConnectedLayer(no_hidden, 'Name', 'CriticActionFC1')];
commonPath = [
    additionLayer(2,'Name', 'add')
    reluLayer('Name','CriticCommonRelu')
    fullyConnectedLayer(1, 'Name', 'output')];
criticNetwork = layerGraph(statePath);
criticNetwork = addLayers(criticNetwork, actionPath);
criticNetwork = addLayers(criticNetwork, commonPath);    
criticNetwork = connectLayers(criticNetwork,'CriticStateFC2','add/in1');
criticNetwork = connectLayers(criticNetwork,'CriticActionFC1','add/in2');
criticOpts = rlRepresentationOptions('LearnRate',0.01,'GradientThreshold',10,'Optimizer','rmsprop','UseDevice','cpu');
critic = rlRepresentation(criticNetwork,obsInfo,actInfo,...
    'Observation',{'state'},'Action',{'action'},criticOpts);
agentOpts = rlDQNAgentOptions(...
    'UseDoubleDQN',true, ...    
    'TargetUpdateMethod',"periodic", ...
    'TargetUpdateFrequency',4, ...   
    'ExperienceBufferLength',10000, ...
    'DiscountFactor',0.99, ...
    'SampleTime',interval, ...
    'MiniBatchSize',256, ...
    'SaveExperienceBufferWithAgent', true ...
);
agent = rlDQNAgent(critic,agentOpts);





