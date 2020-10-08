function in= resetEnvironment(in)

% mdl='new';
mdl=convertStringsToChars(in.ModelName);
persistent episode;
persistent start_time;

if(isempty(episode))
    episode=0;
    start_time=sum(100*clock());
end
episode=episode+1;
disp(['Episode ',num2str(episode), ' starting']);
a = 0;
b = 7;
% lambda1 = (b-a).*rand(1,1) + a;
lambda2 = (b-a).*rand(1,1) + a;

lambda1=5;
randomSeed=episode+start_time;
rng(randomSeed);
% avg_users=randi(3);
lower_limit=1;
upper_limit=100;
risk=randi(5);
instSpecParams = get_param([mdl '/Model'],'InstanceParameters');
% instSpecParams(1).Value=num2str(lambda1);
% instSpecParams(2).Value=num2str(lambda2);
% instSpecParams(3).Value=num2str(randomSeed);
% instSpecParams(4).Value=num2str(avg_users);
instSpecParams=setParameter(instSpecParams,'lambda1Arg',num2str(lambda1));
instSpecParams=setParameter(instSpecParams,'lambda2Arg',num2str(lambda2));
instSpecParams=setParameter(instSpecParams,'random_seedArg',num2str(randomSeed));
instSpecParams=setParameter(instSpecParams,'lower_limitArg',num2str(lower_limit));
instSpecParams=setParameter(instSpecParams,'upper_limitArg',num2str(upper_limit));
instSpecParams=setParameter(instSpecParams,'conf_lambdaArg',num2str(risk));
instSpecParams=setParameter(instSpecParams,'int_lambdaArg',num2str(risk));
instSpecParams=setParameter(instSpecParams,'risk_delayArg',num2str(rand));
instSpecParams=setParameter(instSpecParams,'risk_delay_lengthArg',num2str(randi(3)));
set_param([mdl, '/Model'],'InstanceParameters',instSpecParams);

% set_param([mdl, '/System/Device/Simulink Function3/lambda1'],'Value',num2str(lambda1));
% set_param([mdl, '/System/Device/Simulink Function4/lambda2'],'Value',num2str(lambda2));
disp(['Job1 Arrival rate:',num2str(lambda1)]);
% disp(['Job2 Arrival rate:',num2str(lambda2)]);
% save_system(mdl);

% close_system(mdl);
% a=0.5;
% b=2;
% alpha= 2.4;
% set_param([mdl, '/System/Reward Calculation /Subsystem/alpha'],'Value',num2str(alpha));
% disp(['Alpha:',num2str(alpha)]);

% random_risk=risk_var*randn()+risk_mu;

% set_param([mdl, '/System/Reward Calculation /Subsystem/random_risk'],'Value',num2str(random_risk));