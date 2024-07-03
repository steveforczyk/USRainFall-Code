function [outputXVals,outputValues,cumilOutput] = SortedDistribution(inputValues,nsteps)
% This function will take a 1 D distribution and create the data needed
% to plot the distribution of values 
% Written By: Stephen Forczyk
% Created: June 1,2024
% Revised: -----
% Classification: Unclassified/Public Domain
minval=min(inputValues);
maxval=max(inputValues);
stepsize=(maxval-minval)/nsteps;
outputXVals=minval:stepsize:maxval;
outputXVals=outputXVals';
outputValues=zeros(nsteps+1,1);
numinputValues=length(inputValues);
stepinc=(1/nsteps);
cumilOutput=zeros(nsteps+1,1);
cumil=0;
for n=1:nsteps+1
    nfrac=(n-1)*stepinc;
    indnow=1+round(nfrac*numinputValues);
    if(indnow>numinputValues)
        indnow=numinputValues;
    end
    outputValues(n,1)=inputValues(indnow,1);
%    outputValues(n,1)=nfrac;
    cumilOutput(n,1)=nfrac;
    ab=1;
end
ab=2;
end