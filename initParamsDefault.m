% Default paramaters

%% Device
device_cpu_cores=4;

%% Device power

Pexec=5; % Power while executing
Pidle=0.1; % Power while idle
Ptx=1;

Im=2.5e9; 


ndrop=10;
%% server

server_cpu_cores=6;
% average_computation_time_server=0.1;
Is=2.5e9; % 3.3 GHz
omega=0.1;

l1_cf=2.4;
l2_cf=3;
l1_ig=1.5;
l2_ig=3;


risk_delay_prob=0; % 10 % of the time we find the risk at the same instant.
risk_delay_length=2*options.interval;

is_done_limit=1200;

G=[0.3,4.5];
sigma_sq=-174;

W=2.5e9;
P_max=0.4;
G=[0.3,4.5];
sigma_sq=1.0007;
B=100e6;
R=B.*log2(1+(0.25/sigma_sq)*G);

R1=R(1);
R2=R(2);

%%
delta=1e-10; % very small number to avoid divide by zero
j1_data_size=0.2*1024*1024*8;
j2_data_size=0.3*1024*1024*8;
j1_computeLoadPerBit=2.5e9/j1_data_size;
j2_computeLoadPerBit=1.5e9/j2_data_size;


%% Reward weights
w_t=0.1; %Time
w_e=0.5; %Energy
w_r=1; %Security Risk
w_completion=0.01;
w_drop=1;
% alpha=1; % Risk is proportional to Data Size times alpha

% Currently not in use
risk_var=0.2;
risk_mu=0.1;
tau_threshold=5; % deadline
%% Communication
WIFI_speeds;
Packet_Size=50*8; % 50 bytes
%Permissible_Error_Bits=32; Not in use currently

%%
obsInfo = rlNumericSpec([8 1]);
% obsInfo.Description = {'x, y'};


job_types=1;
% Actions

if(options.continous_action)
    if(job_types==1)
        actInfo=rlNumericSpec([2 1],'LowerLimit',0,'UpperLimit',1);
    elseif(job_types==2)
        actInfo=rlNumericSpec([6 1],'LowerLimit',0,'UpperLimit',1);
    end
else
    % Actions
    % vectors = { [1, 2]', [0, 1]'};
     if(job_types==1)
%         vectors = {[0,0.32,0.53,0.56,0.85,1]';[0,0.44,0.63,0.69,0.75,1]'; [0, 0.2, 0.4,0.6,0.8,1]'; };
        vectors = { [0, 0.2, 0.4,0.6,0.8,1]';[0, 0.2, 0.4,0.6,0.8,1]'; };
%         vectors={ [0,0.32,0.53,0.56,0.85,1]'};
    elseif(job_types==2)
        vectors = { [0,0.32,0.53,0.56,0.85,1]';[0,0.44,0.63,0.69,0.75,1]';[0, 0.2, 0.4,0.6,0.8,1]';[0, 0.2, 0.4,0.6,0.8,1]';[0, 0.2, 0.4,0.6,0.8,1]';[0, 0.2, 0.4,0.6,0.8,1]';};
    end
    
    %input data: cell array of vectors
    n = numel(vectors); % number of vectors
    combs = cell(1,n); % pre-define to generate comma-separated list
    [combs{end:-1:1}] = ndgrid(vectors{end:-1:1}); % the reverse order in these two
    % comma-separated lists is needed to produce the rows of the result matrix
    combs = cat(n+1, combs{:}); %concat the n n-dim arrays along dimension n+1
    combs = reshape(combs,[],n);%reshape to obtain desired matrix
    combs=combs';
    actInfo = rlFiniteSetSpec(num2cell(combs,1));
end
% actInfo.Name='Wheel Speeds';
% actInfo.Description = {'Front Right Speed','Front Left Speed','Rear Right Speed',...
%  'Rear Left Speed'};

%%
% mdl='temp';
%  open_system('bare_system');
% set_param('bare_system/System/Reward Calculation /individual_rewards/Subsystem2/risk_delay_prob','Value','risk_delayArg')
% set_param('bare_system/System/Reward Calculation /individual_rewards/Subsystem2/risk_delay_length','Value','risk_delay_lengthArg')

% set_param('bare_system/System/Device/Simulink Function3/lambda1','Value','lambda1Arg')
% set_param('bare_system/System/Device/Simulink Function4/lambda2','Value','lambda2Arg')
% set_param('bare_system/System/Device/Simulink Function3/random_seed','Value','random_seedArg')
% set_param('bare_system/System/avg_users','Value','avg_usersArg')
% set_param('bare_system/System/lower_limit','Value','lower_limitArg');
% set_param('bare_system/System/upper_limit','Value','upper_limitArg');
% modelWorkspace = get_param('bare_system','ModelWorkspace');
% assignin(modelWorkspace,'risk_delayArg',Simulink.Parameter(1));
% assignin(modelWorkspace,'risk_delay_lengthArg',Simulink.Parameter(1));
% assignin(modelWorkspace,'lower_limitArg',Simulink.Parameter(1));
% assignin(modelWorkspace,'upper_limitArg',Simulink.Parameter(1));
% 
% assignin(modelWorkspace,'lambda1Arg',Simulink.Parameter(1));
% assignin(modelWorkspace,'lambda2Arg',Simulink.Parameter(1));
% assignin(modelWorkspace,'random_seedArg',Simulink.Parameter(1));
% assignin(modelWorkspace,'avg_usersArg',Simulink.Parameter(4));
% set_param('bare_system','ParameterArgumentNames','lambda1Arg,lambda2Arg,random_seedArg,avg_usersArg,risk_delayArg,risk_delay_lengthArg,lower_limitArg,upper_limitArg')
