function [evts,dt,e_i]= createEvents(lambda,total_time,interval)
% Simple function to generate events at mean interarrival times and also 
% count events at regular interval
time=0;
evts=[];
dt=[];
while(time<total_time)
%     generate next event
    del_time=- log ( rand ( 1, 1 ) ) / lambda;
    dt=[dt del_time];
    time=time+del_time;
    evts=[evts time];
%     y=[y 1];
    
end
evts=evts(evts<=total_time);
dt=dt(evts<=total_time);
time=0;
e_i=[];
while(time<total_time)
    count=sum(evts>time&evts<=time+interval);
    e_i=[e_i count];
    
    time=time+interval;
end
    

