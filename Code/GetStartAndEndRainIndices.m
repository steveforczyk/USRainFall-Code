function [startrain,endrain,duration] = GetStartAndEndRainIndices(LocalVals,LocalInd)
% This function will sweep along the data segment to find the start and end
% rain indices along with the duration in hours
% Written By: Stephen Forczyk
% Created: May 30,2024
% Revised: May 31,2024 fixed error in Loop 1
numpts=length(LocalVals);
startrain = LocalInd(1,1);% First point that has rain-default value
endrain = LocalInd(numpts,1);% Last Point that Has Rain-default value
duration=0; % Time between-default value
ifirstrain=0;
ilastrain=0;
ifound=0;
% Loop #1 Find first rainfall
for mm=1:numpts
    rate=LocalVals(mm,1);
    if((rate>0) && (ifound==0))
        startrain=LocalInd(mm,1);
        mmhold=mm;
        ifound=ifound+1;
    end
end


% Loop #2 find last rainfall
mmhold=max(mmhold,1);
for mm=mmhold+1:numpts
    rate=LocalVals(mm,1);
    if(rate>0)
        endrain=LocalInd(mm,1);
    end
end
duration=(endrain-startrain+1)*5/60;
end