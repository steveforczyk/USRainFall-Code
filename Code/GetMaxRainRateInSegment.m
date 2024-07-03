function [maxrate,maxratesamp,maxrateoverlimit] = GetMaxRainRateInSegment(LocalVals,LocalInd)
% This function will sweep along the data segment to find maximum rain rate
% in the datasegment under consideration
% Written By: Stephen Forczyk
% Created: May 31,2024
% Revised: -----
global StormThresh15;

numpts=length(LocalVals);
maxrate = 0;% Set default rate=0
maxratesamp = LocalInd(1,1);% Rate at First rain point is a default
maxrateoverlimit=0;
% Loop over the sample to find the maximum rate rate and the sample
% that this occurs on
for mm=1:numpts
    rate=LocalVals(mm,1);
    if(maxrate<rate)
        maxrate=max(rate,maxrate);
        maxratesample=LocalInd(mm,1);        
        ab=1;
    end
end
% Loop a second time to see how many 5 min samples are over the 15 min limit
for mm=1:numpts
    rate=LocalVals(mm,1);
    if(rate>maxrate)
        maxrateoverlimit=maxrateoverlimit+1;     
        ab=1;
    end
end
end