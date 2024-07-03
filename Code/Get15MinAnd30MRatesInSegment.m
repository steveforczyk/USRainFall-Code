function [raintotmax5,rate5sample,raintotmax15,rate15sample,raintotmax30,rate30sample] = Get15MinAnd30MRatesInSegment(LocalVals,LocalInd)
% This function will sweep along the data segment to find maximum 15 and 30
% min rain rates
% Written By: Stephen Forczyk
% Created: May 31,2024
% Revised: June 1,2024 added 5 min rate rate calculation to check for
% errors
global StormThresh15;

numpts=length(LocalVals);
raintotmax5=0;
raintotmax15=0;
raintotmax30=0;
rate5sample=1;
rate15sample=1;
rate30sample=1;
maxrate5=0;% set default 5 minuterate=0;
maxrate15 = 0;% Set default 15 minuterate=0
maxrate30 = 0;% Set default 30 minuterate=0
maxratesamp = LocalInd(1,1);% Rate at First rain point is a default
maxrateoverlimit=0;
% Loop over the sample to find the maximum rain deposition in a 15 minute peroid and the sample
% that this occurs on
for mm=1:numpts
    rate5=LocalVals(mm,1);
    nowrain=rate5*5/60; 
    if(nowrain>raintotmax5)
        raintotmax5=nowrain;
        rate5sample=LocalInd(mm,1);        
        ab=1;
    end
end
% Loop over the sample to find the maximum rain deposition in a 15 minute peroid and the sample
% that this occurs on
rate15=zeros(3,1);
for mm=3:numpts-3
    rate15(1,1)=LocalVals(mm-2,1);
    rate15(2,1)=LocalVals(mm-1,1);
    rate15(3,1)=LocalVals(mm,1);
    nowrain=(rate15(1,1) + rate15(2,1) + rate15(3,1))*5/60; 
    if(nowrain>raintotmax15)
        raintotmax15=nowrain;
        rate15sample=LocalInd(mm,1);        
        ab=1;
    end
end
% Loop over the sample to find the maximum rain deposition in a 30 minute peroid and the sample
% that this occurs on
rate30=zeros(6,1);
for mm=6:numpts-6
    rate30(1,1)=LocalVals(mm-5,1);
    rate30(2,1)=LocalVals(mm-4,1);
    rate30(3,1)=LocalVals(mm-3,1);
    rate30(4,1)=LocalVals(mm-2,1);
    rate30(5,1)=LocalVals(mm-1,1);
    rate30(6,1)=LocalVals(mm,1);
    nowrain=(rate30(1,1) + rate30(2,1) + rate30(3,1) + rate30(4,1) + rate30(5,1) + rate30(6,1))*5/60; 
    if(nowrain>raintotmax30)
        raintotmax30=nowrain;
        rate30sample=LocalInd(mm,1);        
        ab=1;
    end
end
if(raintotmax5>raintotmax15)
    ab=1;
end
if(raintotmax15>raintotmax30)
    ab=2;
end
end