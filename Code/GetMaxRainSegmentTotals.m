function [raintot,numrain,numdry] = GetMaxRainSegmentTotals(LocalVals,LocalInd)
% This function will sweep along the data segment to total rainfall in the
% segment and the number of samples with rain(wet) and dry (no rain)
% Written By: Stephen Forczyk
% Created: May 31,2024
% Revised: -----
numpts=length(LocalVals);
raintot=0;
numrain=0;
numdry=0;
maxrate = 0;% Set default rate=0
maxratesamp = LocalInd(1,1);% Rate at First rain point is a default

% Loop over the sample to sum the rain faill
% that this occurs on
for mm=1:numpts
    rate=LocalVals(mm,1);
    if(rate>0)
        raintot=raintot+rate*5/60;
        numrain=numrain+1;
        ab=1;
    else
        numdry=numdry+1;
    end
end

end