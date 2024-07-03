% This script will locate in time the rain storms that occur
% over all given observation period for a single location
% according some defined criteria in the refernce paper below
% Written By Stephen Forczyk and Dr Joydeb Saha
% Created: May 11,2024
% Revised: May 24,2024 created logic to write tables to Excel
% Revised: May 29,2024 made key logic change in selecting
%          rain events to be included
% Classification: Unclassified/Public Domain

% Source:Rainfall erosivity in Italy: a national scale spatio-
% temporal assessment https://doi.org/10.1080/17538947.2016.1148203

global RainFallFile1 RainFallFile2 RainFallFile1C RainFallFile2C;
global ActualRainFall ActualRainFallTimes SortedRainFallAmt S;
global TotalValues TotalWet TotalDry GlobalValues;
global Allraintotmax5 Allrate5sample Allraintotmax15 Allrate15sample Allraintotmax30 Allrate30sample;
global StationStr StationNum RainFallFile RainFallCatalogedFile;
global RainFallTime RainFallFlag RainFallAmt RainFallName;
global DetectTime NoDetectTime ErosiveList ErosiveList2 ErosiveIndices;
global ErosiveTimes SecondPassTimes ErosiveMonthlyCounts;
global ProvinceNames RainFallTime30 I30max;
global PotentialStorms ConsolidatedStorm  DefinedStorms BreakPoints;
global PS2 PS3 PS4 PS5 PS6 PS7 PS8 PS9 PS10 PS11 PS12 PS13 PS14 PS15 PS16;
global SPS2 SPS3 SPS4 SPS5 SPS6 SPS7 SPS8 SPS9 SPS10 SPS11 SPS12 SPS13 SPS14 SPS15 SPS16 SPS17;
global SPDetectTime SPTimeIndices;
global numtimesstep SelectedYears SelStartIndex SelEndIndex numused numedused30;
global StormThreshTot StormThresh360 StormThresh15 StormBreakThresh;
global firstyearstr firstyear firstdaystr firstday firstmonthstr;
global firsthrstr firsthr firstminstr firstmin firstsecstr firstsec;
global lastyearstr lastyear lastdaystr lastday lastmonthstr;
global lasthrstr lasthr lastminstr lastmin lastsecstr lastsec;
global FoundData icataloged eventctr norainctr FileStub;
global I30 SumRain30 SUMKE30 ER30 VR30 KEnergy RainRate;
global RFactorTable RFactorTT DiagTable DiagTT;
global PotentialStormsTable PotentialStormsTT;
global PotentialStorms2Table PotentialStorms2TT;
global ErosiveEventTable ErosiveEventTT ErosiveEvent2Table ErosiveEvent2TT;
global ErosiveCountsTable EroisveCountsTT EventYears;
global StormBasicStats StormBasicStatsHdr;
global FirstPassItems SecondPassItems ErosiveItems;
global SPS12Counts SPS15Counts SPS16Counts EventCounts CriteriaCounts;


global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch

global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath;
global tablepath jpegpath govjpegpath dailyfilepath rainfalldatapath excelpath;
global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog ;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global vTemp TempMovieName iMovie iFastSave;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;
global iLogo LogoFileName1 iCheckConfig;
global iStorms;
global iExcel iRunExcelMacro;
global isumhourlyfiles sf1;% sf1 is the scale factor to go from kg/m^2 to inches of water
% for the given time period


%% Paths
datapath='D:\Joydeb\Data\';
matlabpath='D:\Joydeb\Matlab_Files\';
moviepath='D:\Joydeb\Movies\';
tiffpath='D:\Joydeb\Tiff_Files\';
logfilepath='D:\Joydeb\LogFiles\';
mappath='K:\Joydeb\Map_Files\';
maskpath='D:\Joydeb\Mask_Files\';
tablepath='D:\Joydeb\Tables\';
jpegpath='D:\Joydeb\Jpeg_Files\';
govjpegpath='D:\Joydeb\gov_jpeg\';
dailyfilepath='D:\Joydeb\Daily_Files\';
rainfalldatapath='K:\Joydeb\RainFall_Files\';
excelpath='K:\Joydeb\Excel_Files\';
%% Flags
iLogo=1; %Anotate Charts with a Logo if =1
iFastSave=1;% If set to 1 save chart as a screen grab otherwise as a jpeg
iCheckConfig=1;% Check the status of the computer and software making this run
isumhourlyfiles=1;% Sum up consolidated hourly file records
iStorms=1; % Calculate Storms (should ONLY be set to 1 for now) 
icataloged=1;% If flag set to one the input file has not been cataloged and must be done now
             % if flag is already catalog this will be set to 1 and that
             % code section will be skipped
iExcel=1;  % Create an Excel Outut for key tables (0=No.1=Yes)
iRunExcelMacro=0; % Run macros to format the Excel out difrevtly from Matlab
%% Set Up Cell Variables
StormBasicStats=cell(9,10);
StormBasicStatsHdr=cell(1,10);
StormBasicStatsHdr{1,1}='Variable';
StormBasicStatsHdr{1,2}='Measurements';
StormBasicStatsHdr{1,3}='Mean';
StormBasicStatsHdr{1,4}='Median';
StormBasicStatsHdr{1,5}='Mode';
StormBasicStatsHdr{1,6}='StdDev';
StormBasicStatsHdr{1,7}='MinVal';
StormBasicStatsHdr{1,8}='MaxVal';
StormBasicStatsHdr{1,9}='Skewness';
StormBasicStatsHdr{1,10}='Kurtosis';
StormBasicStatsHdr{1,11}='Sum';
%% Default Values & Storm Criteria
deg2rad=pi/180;
StormThresh360=1.27; % Max RainFalll in 6 hours to declear a BREAK in a storm
StormThreshTot=12.7; % Min Total RainFalll in a 6 hour period to declare a storm
StormThresh15=6.35; % Min Gully Washer Threshold 15 min rainfall as and alternative way to declare a storm
StormBreakThresh=72;% In 5 minute samples-or 6 Hours
LogoFileName1='UPadua_Logo3.jpg';
framecounter=0;
iMovie=0;
sf1=.039370;
eventctr=0;
norainctr=0;
FoundData=zeros(60,3);

% Set up the cell array for the Province Names
ProvinceNames=cell(20,1);
ProvinceNames{1,1}='Abruzzo';
ProvinceNames{2,1}='Apulia';
ProvinceNames{3,1}='Basilicata';
ProvinceNames{4,1}='Calabria';
ProvinceNames{5,1}='Campania';
ProvinceNames{6,1}='Emilia';
ProvinceNames{7,1}='Friuli';
ProvinceNames{8,1}='Lazio';
ProvinceNames{9,1}='Liguria';
ProvinceNames{10,1}='Lombardia';
ProvinceNames{11,1}='Marche';
ProvinceNames{12,1}='Molise';
ProvinceNames{13,1}='Piemonte';
ProvinceNames{14,1}='Sardegna';
ProvinceNames{15,1}='Sicily';
ProvinceNames{16,1}='Toscana';
ProvinceNames{17,1}='Trentino';
ProvinceNames{18,1}='Umbria';
ProvinceNames{19,1}='Valla';
ProvinceNames{20,1}='Veneto';
%% Set Up Log File-text based file to store critical data about run for analysis purposes
% Start writing a log file and Also look at the current stored image paths
% file
startruntime=deblank(datestr(now));
startrunstr=strcat('Start CreateStormList at-',startruntime);
logfilename=startruntime;
logfiledbl=double(logfilename);
% find the blank space in the date and replace it with a '-' to make a
% legalfilename
[iblank]=find(logfiledbl==32);
numblank=length(iblank);
for n=1:numblank
    is=iblank(n);
    ie=is;
    logfilename(is:ie)='-';
end
[icolon]=strfind(logfilename,':');
numcolon=length(icolon);
for n=1:numcolon
    is=icolon(n);
    ie=is;
    logfilename(is:ie)='-';
end
toolbox='MATLAB Report Generator';
[RptGenPresent] = ToolboxChecker(toolbox);
toolbox='Image Processing Toolbox';
[ImageProcessPresent]=ToolboxChecker(toolbox);
eval(['cd ' logfilepath(1:length(logfilepath)-1)]);
logfilename=strcat('StormDetection-',logfilename,'.txt');
fid=fopen(logfilename,'w');
dispstr=strcat('Opened Log file-',logfilename,'-for writing');
disp(dispstr);
fprintf(fid,'%50s\n',startrunstr);
%% Call some routines that will create nice plot window sizes and locations
% Establish selected run parameters
imachine=2;
if(imachine==1)
    widd=720;
    lend=580;
    widd2=1000;
    lend2=700;
elseif(imachine==2)
    widd=1080;
    lend=812;
    widd2=1000;
    lend2=700;
elseif(imachine==3)
    widd=1296;
    lend=974;
    widd2=1200;
    lend2=840;
end
% Set a specific color order
set(0,'DefaultAxesColorOrder',[1 0 0;
    1 1 0;0 1 0;0 0 1;0.75 0.50 0.25;
    0.5 0.75 0.25; 0.25 1 0.25;0 .50 .75]);
% Set up some defaults for a PowerPoint presentationwhos
scaling='true';
stretching='false';
padding=[75 75 75 75];
igrid=1;
% Set up parameters for graphs that will center them on the screen
[hor1,vert1,Fz1,Fz2,machine]=SetScreenCoordinates(widd,lend);
[hor2,vert2,Fz1,Fz2,machine]=SetScreenCoordinates(widd2,lend2);
chart_time=5;
idirector=1;
initialtimestr=datestr(now);
igo=1;
% Set up some more colors
SetUpExtraColors()
almond=[LandColors(1,1) LandColors(1,2) LandColors(1,3)];
beige=[LandColors(3,1) LandColors(3,2) LandColors(3,3)];
wheat=[LandColors(5,1) LandColors(5,2) LandColors(5,3)];
butterscotch=[LandColors(8,1) LandColors(8,2) LandColors(8,3)];
%% Check The system configuration
if(iCheckConfig==1)
    SpecifyMatlabConfiguration('CreateStormList.m')
end
ab=1;
%% Read in 1 RainFallFile
eval(['cd ' rainfalldatapath(1:length(rainfalldatapath)-1)]);
[RainFallFile,nowpath] = uigetfile('*.mat','Select One File', ...
'MultiSelect', 'off');
[iunder]=strfind(RainFallFile,'_');
numunder=length(iunder);
is=iunder(1)+1;
ie=iunder(2)-1;
StationStr=string(RainFallFile(is:ie));
StationNum=str2double(StationStr);
is=1;
ie=iunder(2)-1;
FileStub=RainFallFile(is:ie);
% See if this file is a catalog file
a100=contains(RainFallFile,'cataloged','IgnoreCase',true);
if(a100==1)
    icataloged=1;
else
    icataloged=0;
    a98=strfind(RainFallFile,'newflag');
    a99=strfind(RainFallFile,'.');
    is=a98(1)-1;
    ie=a99(1)-1;
    stub=RainFallFile(1:is);
    RainFallCatalogedFile=strcat(stub,'cataloged.mat');
end
tic;
ab=1;
% Read in 1 of the RainFall Files
eval(['cd ' rainfalldatapath(1:length(rainfalldatapath)-1)]);
load(RainFallFile)
RainFallName=S.name;
RainFallTime=S.time;
RainFallAmt=S.vals;
RainFallFlag=S.flag;
numtimesstep=length(RainFallAmt)-1;
loadstr=strcat('Loaded file-',RainFallFile);
fprintf(fid,'%s\n','----------- Start Code Processing------');
fprintf(fid,'%40s\n',loadstr);
% Get the starting and ending date info of the dataset loaded
GetDatasetStartAndEndTimes()

% If the file is cataloged-skip the next step
% Now scan the data to find what years are available and the start and end
% indices for each year
if(icataloged~=1)
    CatalogFile()
end

% Show the years that data is available for
fprintf(fid,'%s\n','List Of Years that have available data');
fprintf(fid,'%s\n','Entry Number  Year'); 
[nrows,ncols]=size(FoundData);
for kk=1:nrows
    fprintf(fid,'%3d    %9d\n',kk,FoundData(kk,1));
end
fprintf(fid,'%s\n','End Of Years that have available data');
eval(['cd ' rainfalldatapath(1:length(rainfalldatapath)-1)]);
[nrows,ncols]=size(FoundData);
firstAvailYear=FoundData(1,1);
lastAvailYear=FoundData(nrows,1);
ListYears=cell(nrows,1);
for i=1:nrows
    ListYears{i,1}=num2str(FoundData(i,1));
end
%% Select Years to be used
[indx,tf] = listdlg('PromptString',{'Start and End Years For Storm Detection'},...
'SelectionMode','multiple','ListString',ListYears,'ListSize',[360,300]);
a1=isempty(indx);
if(a1==1)
    igo=0;
else
    igo=1;
    numYears=length(indx);
    SelectedYears=zeros(numYears,1);
    indx=indx';
    for ik=1:numYears
        nowInd=indx(ik,1);
        selstr=char(ListYears{nowInd});
        SelectedYears(ik,1)=str2double(selstr);
        if(ik==1)
            SelStartIndex=FoundData(nowInd,2);
        elseif(ik==numYears)
            SelEndIndex=FoundData(nowInd,3);
        end
        if(((numYears==1) && (ik==1)))
            SelEndIndex=FoundData(nowInd,3);
        end
    end
end
% Show the years that data is available for
fprintf(fid,'%s\n','User Selected to Process The Following Years');
fprintf(fid,'%s\n','Entry Number              Year'); 
for kk=1:numYears
    fprintf(fid,'%3d    %25d\n',kk,SelectedYears(kk,1));
end
fprintf(fid,'%s\n','End Of List Of Selected Years');
%% Now define time regions that can be called storms
% Limit the search to the selected years
if(iStorms>0)
    extent= SelEndIndex-SelStartIndex+1;
% Get the Cumilative Distribution for the 5 min rainfall measurements
% omit zero values
    [ibig2]=find(RainFallAmt>0);
    numbig2=length(ibig2);
    TotalValues=length(RainFallAmt);
    TotalWet=numbig2;
    TotalDry=TotalValues-TotalWet;

    ActualRainFall=zeros(numbig2,1);
    ActualRainFallTimes=RainFallTime(ibig2);
    for m=1:numbig2
        nowInd=ibig2(m,1);
        ActualRainFall(m,1)=RainFallAmt(nowInd,1);
    end
    SortedRainFallAmt=sort(ActualRainFall,'ascend');
    ab=1;
    nsteps=200;
    [outputXVals,outputValues,cumilOutput] = SortedDistribution(SortedRainFallAmt,nsteps);
%   Now look for the max global deposits in 5,15 and 30 minute segments
    GlobalValues=zeros(TotalValues,1);
    GlobalValues=1:1:TotalValues;
    GlobalValues=GlobalValues';
    [Allraintotmax5,Allrate5sample,Allraintotmax15,Allrate15sample,Allraintotmax30,Allrate30sample] = Get15MinAnd30MRatesInSegment(RainFallAmt,GlobalValues);
    [izero2]=find(RainFallAmt==0);
    numzero2=length(izero2);    
    ibig=zeros(extent,1);
    mctr=0;
    % Get the cutoff points for rain fall detections
    for mm=1:numbig2
        ibig2now=ibig2(mm);
        if((ibig2now>=SelStartIndex) && (ibig2now<=SelEndIndex))
            mctr=mctr+1;
        end
    end
    ibig=zeros(mctr,1);
    mctr=0;
    for mm=1:numbig2
        ibig2now=ibig2(mm);
        if((ibig2now>=SelStartIndex) && (ibig2now<=SelEndIndex))
            mctr=mctr+1;
            ibig(mctr,1)=ibig2now;
        end
    end
    numbig=length(ibig);
 %   DetectTime=RainFallTime(ibig);
 % Get the cutoff points for no rain fall detections
    jctr=0;
    for mm=1:numzero2
        izero2now=izero2(mm);
        if((izero2now>=SelStartIndex) && (izero2now<=SelEndIndex))
            jctr=jctr+1;
        end
    end
    izero=zeros(jctr,1);
    jctr=0;
    for mm=1:numzero2
        izero2now=izero2(mm);
        if((izero2now>=SelStartIndex) && (izero2now<=SelEndIndex))
            jctr=jctr+1;
            izero(jctr,1)=izero2now;
        end
    end
    numbig=length(ibig);
    numzero=length(izero);
    DetectTime=RainFallTime(ibig);
    NoDetectTime=RainFallTime(izero);
    PotentialStorms=cell(numbig,16);
    PotentialStorms{1,1}='DateTime';
    PotentialStorms{1,2}='Sample';
    PotentialStorms{1,3}='RainFallRate-mm/hr';
    PotentialStorms{1,4}='OccurInRow';
    PotentialStorms{1,5}='Sum5Min';
    PotentialStorms{1,6}='Sum10Min';
    PotentialStorms{1,7}='Sum15Min';
    PotentialStorms{1,8}='Sum30Min';
    PotentialStorms{1,9}='Sum60Min';
    PotentialStorms{1,10}='Sum360Min';
    PotentialStorms{1,11}='Max5Min';
    PotentialStorms{1,12}='Max10Min';
    PotentialStorms{1,13}='Max15Min';
    PotentialStorms{1,14}='Max30Min';
    PotentialStorms{1,15}='Max60Min';
    PotentialStorms{1,16}='Max360Min';
    ictr=0;
    waitstr='Making an initial pass through the Rain Data';
    hfs=waitbar(0,waitstr);
    DetectTime=RainFallTime(ibig);
    for i=1:numbig% Loop over all exceedences
        ibignow=ibig(i);
        waitbar(i/numbig);
        if(ibignow>=(numtimesstep-12))% skip the exceedence is this is near the end of the data
    
        else
            ictr=ictr+1;
            teststr=char(RainFallTime(ibignow));
            DetectTimeInd(ictr,1)=ibignow;
            PotentialStorms{1+ictr,1}=teststr;
            PotentialStorms{1+ictr,2}=ibignow;
            PotentialStorms{1+ictr,3}=RainFallAmt(ibignow);
            inRow=1;
            sumRain=RainFallAmt(ibignow);
            PotentialStorms{1+ictr,5}=sumRain;
            PotentialStorms{1+ictr,11}=sumRain;
            ictr2=1;
            if(ictr2==1)
                HoldArray=zeros(72,1);
                HoldArray(1,1)=sumRain;
            end
            for kk=ibignow+1:1:ibignow+71 % Get rain fall sum
                ictr2=ictr2+1;
                sumRain=sumRain+RainFallAmt(kk);
                HoldArray(ictr2,1)=RainFallAmt(kk);
                maxRain=max(HoldArray);
                if(ictr2==2)
                    PotentialStorms{1+ictr,6}=sumRain;
                    PotentialStorms{1+ictr,12}=maxRain;
                end
                if(ictr2==3)
                    PotentialStorms{1+ictr,7}=sumRain;
                    PotentialStorms{1+ictr,13}=maxRain;
                end
                if(ictr2==6)
                    PotentialStorms{1+ictr,8}=sumRain;
                    PotentialStorms{1+ictr,14}=maxRain;
                end
                if(ictr2==12)
                    PotentialStorms{1+ictr,9}=sumRain;
                    PotentialStorms{1+ictr,15}=maxRain;
                end
                if(ictr2==72)
                    PotentialStorms{1+ictr,10}=sumRain;
                    PotentialStorms{1+ictr,16}=maxRain;
                end
            end
            for kk=ibignow+1:1:ibignow+71
                if(RainFallAmt(kk)>0)
                    inRow=inRow+1;
                    if(inRow>20)
                        ab=3;
                    end
                else
                    break
                end
    
            end
            PotentialStorms{1+ictr,4}=inRow;
        end
        ab=1;
    end
    close(hfs);
    PS2=zeros(ictr,1);
    PS3=zeros(ictr,1);
    PS4=zeros(ictr,1);
    PS5=zeros(ictr,1);
    PS6=zeros(ictr,1);
    PS7=zeros(ictr,1);
    PS8=zeros(ictr,1);
    PS9=zeros(ictr,1);
    PS10=zeros(ictr,1);
    PS11=zeros(ictr,1);
    PS12=zeros(ictr,1);
    PS13=zeros(ictr,1);
    PS14=zeros(ictr,1);
    PS15=zeros(ictr,1);
    PS16=zeros(ictr,1);

    for ii=1:ictr
        PS2(ii,1)=PotentialStorms{1+ii,2};
        PS3(ii,1)=PotentialStorms{1+ii,3};
        PS4(ii,1)=PotentialStorms{1+ii,4};
        PS5(ii,1)=PotentialStorms{1+ii,5};
        PS6(ii,1)=PotentialStorms{1+ii,6};
        PS7(ii,1)=PotentialStorms{1+ii,7};
        PS8(ii,1)=PotentialStorms{1+ii,8};
        PS9(ii,1)=PotentialStorms{1+ii,9};
        PS10(ii,1)=PotentialStorms{1+ii,10};
        PS11(ii,1)=PotentialStorms{1+ii,11};
        PS12(ii,1)=PotentialStorms{1+ii,12};
        PS13(ii,1)=PotentialStorms{1+ii,13};
        PS14(ii,1)=PotentialStorms{1+ii,14};
        PS15(ii,1)=PotentialStorms{1+ii,15};
        PS16(ii,1)=PotentialStorms{1+ii,16};
    end
end
% Plot the cumilative Distribution of RainFall Rate Data
titlestr=strcat(FileStub,'-CumilRainFallDist');
titlestr=RemoveUnderScores(titlestr);
PlotRainFallRatesCumilDist(outputXVals,outputValues,cumilOutput,titlestr)
% Calculate the location of BreakPoints Changed locationb of function call
% FindRainFallBreakPoints(izero,ibig);
% ab=1;
ictrfp=ictr;% ictrfp is the exceedence counter for the first pass
jctrfp=jctr;% jctrfp is the counter for zeros;

% Create a Table of First Pass Data
PotentialStormsTable=table(PS2(:,1),PS3(:,1),PS4(:,1),PS5(:,1),PS6(:,1),...
    PS7(:,1),PS8(:,1),PS9(:,1),PS10(:,1),PS11(:,1),PS12(:,1),...
    PS13(:,1),PS14(:,1),PS15(:,1),PS16(:,1),DetectTime,...
    'VariableNames',{'Sample','RainFallRate','OccurInRow','Sum5Min','Sum10Min',...
    'Sum15Min','Sum30Min','Sum60Min','Sum360Min','Max_5Min', ...
    'Max_10Min','Max_15Min','MAX_30Min','MAX_60Min','MAX_360','DetectTime'});
PotentialStormsTT = table2timetable(PotentialStormsTable,'RowTimes','DetectTime');
FirstPassItems=height(PotentialStormsTT);
% Calculate the location of BreakPoints
FindRainFallBreakPointsRev2(izero,ibig);
ab=1;
%% Now start a second pass through the data
% Also declare erosive events
[numposevents,~]=size(BreakPoints);
SPS2=zeros(numposevents,1);
SPS3=zeros(numposevents,1);
SPS4=zeros(numposevents,1);
SPS5=zeros(numposevents,1);
SPS6=zeros(numposevents,1);
SPS7=zeros(numposevents,1);
SPS8=zeros(numposevents,1);
SPS9=zeros(numposevents,1);
SPS10=zeros(numposevents,1);
SPS11=zeros(numposevents,1);
SPS12=zeros(numposevents,1);
SPS13=zeros(numposevents,1);
SPS14=zeros(numposevents,1);
SPS15=zeros(numposevents,1);
SPS16=zeros(numposevents,1);
SPS17=zeros(numposevents,1);
SPTimeIndices=zeros(numposevents,1);

[numposevents,necols]=size(BreakPoints);
nerosiveevents=0;
eventflags=zeros(numposevents,1);
ErosiveList2=zeros(numposevents,9);
ErosiveIndices=zeros(numposevents,1);
waitstr='Making a Second  pass through the Rain Data for likely events';
hfs=waitbar(0,waitstr);
for m=1:numposevents
    waitbar(m/numposevents);
    mstart=BreakPoints(m,7);% Changed from 4
    mend=BreakPoints(m,8);
    rate=RainFallAmt(m);
    raintot=0;
    raintotmax15=0;
    maxrate=0;
    maxratesample=0;
    ierosive=0;
    lastrain=0;
    numrain=0;
    numdry=0;
    maxrateoverlimit=0;
    ik=0;
    ik30=0;
    rainhold=zeros(3,1);
    rainhold30=zeros(6,1);
    ipass=0;
    maxrate15samp=0;
    numseg=mend-mstart+1;
    LocalVals=zeros(numseg,1);
    LocalInd=zeros(numseg,1);
    ik=0;
    for mm=mstart:mend% Inner Loop
        ik=ik+1;
        rate=RainFallAmt(mm,1);
        index=mm;
        LocalVals(ik,1)=rate;
        LocalInd(ik,1)=index;
    end
% Get the start and rain indices
    [startrain,endrain,duration]=GetStartAndEndRainIndices(LocalVals,LocalInd);
    ab=1;
% now get the maxrain rate
   [maxrate,maxratesamp,maxrateoverlimit] = GetMaxRainRateInSegment(LocalVals,LocalInd);
% Get the raintotals
   [raintot,numrain,numdry] = GetMaxRainSegmentTotals(LocalVals,LocalInd);
    SPTimeIndices(m,1)=startrain;
    SPS2(m,1)=startrain;
    SPS3(m,1)=endrain;
    SPS4(m,1)=duration;
    SPS5(m,1)=maxrate;
    SPS6(m,1)=maxratesamp;
    SPS7(m,1)=raintot;
    SPS8(m,1)=numrain;
    SPS9(m,1)=numdry;
    SPS10(m,1)=maxrateoverlimit;
    ab=1;
    if(raintot>=StormThresh360)% This checks to see if a rain break ocured
        SPS11(m,1)=1;
    else
        SPS11(m,1)=0;
    end
    if(raintot>=StormThreshTot)% Did enough rainfall in 6 hours to declare an event
        SPS12(m,1)=1;
    else
        SPS12(m,1)=0;
    end
%    [raintotmax15,rate15sample,raintotmax30,rate30sample] = Get15MinAnd30MRatesInSegment(LocalVals,LocalInd);
    [raintotmax5,rate5sample,raintotmax15,rate15sample,raintotmax30,rate30sample] = Get15MinAnd30MRatesInSegment(LocalVals,LocalInd);
    SPS13(m,1)=rate15sample;% biggest 15 min rain fall sample
    SPS14(m,1)=raintotmax15;% biggest 15 min rainfall 
   % maxrainrate15=raintotmax15*15/60;% This is the highest rainrate per hr using 15 min data
    if(raintotmax15>StormThresh15) % This how much rain fell in 15 minutes-not a rate per hour
        SPS15(m,1)=1;
    else
        SPS15(m,1)=0;
    end
    % Sum the two flags (SPS12 + SPS15)
    SPS16(m,1)=SPS12(m,1)+SPS15(m,1);
    % Get I Max30
    SPS17(m,1)=raintotmax30;
    nowtime=char(RainFallTime(mstart));
    ab=1;
end
close(hfs)
% Calculate the Times at the Start of each Rain Event for the second Pass
SecondPassTimes=RainFallTime(SPTimeIndices);
% Create a Table of Second Pass Data
PotentialStorms2Table=table(SPS2(:,1),SPS3(:,1),SPS4(:,1),SPS5(:,1),SPS6(:,1),SPS7(:,1),...
    SecondPassTimes,'VariableNames',{'StartRain','EndRain','Duration-hrs','MaxRainRate-mm/hr','MaxRateSamp',...
    'RainTot-mm','SecondPassTimes'});
PotentialStorms2TT = table2timetable(PotentialStorms2Table,'RowTimes','SecondPassTimes');
SecondPassItems=height(PotentialStorms2TT);
% Set up a preliminary list of erosive events
[numsecevents,nncols]=size(SPS2);
nprelim=0;
numpassed2=0;
TimeIndices=zeros(numsecevents,1);
ErosiveList2=zeros(numsecevents,16);
for i=1:numsecevents
    nprelim=nprelim+1;
    ErosiveList2(nprelim,1)=SPS2(i,1);
    ErosiveList2(nprelim,2)=SPS3(i,1);
    ErosiveList2(nprelim,3)=SPS7(i,1);
    ErosiveList2(nprelim,4)=SPS8(i,1);
    ErosiveList2(nprelim,5)=SPS9(i,1);
    ErosiveList2(nprelim,6)=SPS5(i,1);
    ErosiveList2(nprelim,7)=SPS6(i,1);
    ErosiveList2(nprelim,8)=SPS10(i,1);
    ErosiveList2(nprelim,9)=SPS4(i,1);% duration in hours
    ErosiveList2(nprelim,10)=SPS11(i,1);% Passed 6 Hr Rain Threshold
    ErosiveList2(nprelim,11)=SPS12(i,1);% Passed 6 Hr Rain Higher Threshold
    ErosiveList2(nprelim,12)=SPS13(i,1);% Passed 6 Hr Rain Higher Threshold
    ErosiveList2(nprelim,13)=SPS14(i,1);% maxrain15 min
    ErosiveList2(nprelim,14)=SPS15(i,1);% Pass Fail on 15 minute Rain Rate flag-Threhsold 3
    ErosiveList2(nprelim,15)=SPS16(i,1);% Sum of Two Pass Fail Flags
    ErosiveList2(nprelim,16)=SPS17(i,1);% Max I30
    TimeIndices(nprelim,1)=SPS2(i,1);
    numpassed=sum(SPS11(:,1));
    if(SPS16(i,1)>0)
        numpassed2=numpassed2+1;
    end
end
%% Select final erosive events. Now events will be selected based on the value of SPS16. This variable
% is the sum of two pass fail flags which are stored in SPS12 and SPS15.
% The first is the sum of rain fall in a 6 hr period while the later will
% declare an event if a single 15 minute period of rainfall exceeds StormThresh15
% Set the final erosive array with events that pass at least one of SPS12
% and SPS15 removed
ErosiveList=zeros(numpassed2,11);
SPTimeIndices=zeros(numpassed2,1);
ix=0;
for ii=1:numsecevents
    if((SPS16(ii,1)>0))% This is the sum of flags an can be 0,1,or 2
        ix=ix+1;
        for jj=1:16
            ErosiveList(ix,jj)=ErosiveList2(ii,jj);
        end
        SPTimeIndices(ix,1)=ErosiveList2(ii,1);
    end
end
% Counts how many events passed eithetr or both criteria
[nrows12,ncols12]=size(SPS12);
SPS12Counts=0;
SPS15Counts=0;
SPS16Counts=0;
EventCounts=0;
CriteriaCounts=zeros(4,1);
for kk=1:nrows12
    if(SPS12(kk,1)>0)
        SPS12Counts=SPS12Counts+1;
    end
    if(SPS15(kk,1)>0)
        SPS15Counts=SPS12Counts+1;
    end
    if((SPS12(kk,1)>0) && (SPS15(kk,1)>0))
        SPS16Counts=SPS16Counts+1;
    end
    if(SPS16(kk,1)>0)
        EventCounts=EventCounts+1;
    end

end
CriteriaCounts(1,1)=SPS12Counts;
CriteriaCounts(2,1)=SPS15Counts;
CriteriaCounts(3,1)=SPS16Counts;
CriteriaCounts(4,1)=EventCounts;
ErosiveTimes=RainFallTime(SPTimeIndices);
% Create a Table of Erosive Event Data Pass either the 6 hr RainFall lower limit
% or the 15 min max rate limit
ErosiveEventTable=table(ErosiveList(:,1),ErosiveList(:,2),ErosiveList(:,3),ErosiveList(:,4),...
    ErosiveList(:,5),ErosiveList(:,6),ErosiveList(:,7),ErosiveList(:,8),...
    ErosiveList(:,9),ErosiveList(:,10),ErosiveList(:,11),ErosiveList(:,12),ErosiveList(:,13),...
    ErosiveList(:,14),ErosiveList(:,15),...
    ErosiveTimes,'VariableNames',{'StartRain','EndRain','Raintot','NumRain','NumDry',...
    'MaxRate','MaxRateSamp','MaxOverRateLimit','Duration','RainThresh1','RainThresh2',...
    'MaxRateExceeded','MaxRain15','Pass15','PassAll','ErosiveTimes'});
ErosiveEventTT = table2timetable(ErosiveEventTable,'RowTimes','ErosiveTimes');
ErosiveItems=height(ErosiveEventTT);
fprintf(fid,'\n');
fprintf(fid,'%s\n','------Detection Stats Follow------');
fprintf(fid,'%15s %15s %14s\n','First Pass','Second Pass','ErosivePass');
fprintf(fid,'%12i %12i %15i\n',FirstPassItems,SecondPassItems,ErosiveItems);
fprintf(fid,'%29s %7i\n','Events Meeting 6hr Raintotal-',SPS12Counts);
fprintf(fid,'%26s %8i\n','Events Meeting 15 Min Rain Rate-',SPS15Counts);
fprintf(fid,'%29s %7i\n','Events Meeting Both Criteria-',SPS16Counts);
fprintf(fid,'%s\n','------End Detection Stats ------');
fprintf(fid,'\n');
dispstr=strcat('First Pass Events=',num2str(FirstPassItems),'-Second Pass Events=',...
    num2str(SecondPassItems),'-Erosive Events=',num2str(ErosiveItems));
disp(dispstr)
ab=1;
%% Now calculate some basic stats and then plot them
CalculateDescriptiveStormStats()
% Now make plots of selected values from this table
ikind=1;
titlestr=strcat(FileStub,'-ErosiveEvents-TotalPrecip');
titlestr=RemoveUnderScores(titlestr);
PlotErosiveEventsTable(titlestr,ikind)
ikind=2;
titlestr=strcat(FileStub,'-ErosiveEvents-StormDuration');
titlestr=RemoveUnderScores(titlestr);
PlotErosiveEventsTable(titlestr,ikind)
ikind=3;
titlestr=strcat(FileStub,'-ErosiveEvents-OverRateLimit');
titlestr=RemoveUnderScores(titlestr);
PlotErosiveEventsTable(titlestr,ikind)
ikind=4;
titlestr=strcat(FileStub,'-ErosiveEvents-MaxRainRate5Min');
titlestr=RemoveUnderScores(titlestr);
PlotErosiveEventsTable(titlestr,ikind)
ikind=5;
titlestr=strcat(FileStub,'-ErosiveEvents-MaxRainRate15Min');
titlestr=RemoveUnderScores(titlestr);
PlotErosiveEventsTable(titlestr,ikind)
ikind=6;
titlestr=strcat(FileStub,'-ErosiveEvents-RainThresholds');
titlestr=RemoveUnderScores(titlestr);
PlotErosiveEventsTable(titlestr,ikind)
% Find out how many minimal erosive events were recorderd
[numMinErosiveEvents]=height(ErosiveEventTT);
StartYear=min(SelectedYears);
EndYear=max(SelectedYears);
dispstr=strcat('For the Years-',num2str(StartYear),'-to-',num2str(EndYear),'-Minor Erosive Events=',num2str(numMinErosiveEvents));
disp(dispstr)
DateStrings={'1984';'1985';'1986';'1987';'1988';'1989';...
    '1990';'1991';'1992';'1993';'1994';'1995';'1996';'1997';...
    '1998';'1999';'2000';'2001';'2002';'2003';'2004';'2005';'2006';'2007';'2008';...
     '2009';'2010';'2011';'2012';'2013';'2014';'2015';'2016';'2017';...
     '2018';'2019';'2020';'2021'};
EventYears = datetime(DateStrings,'InputFormat','yyyy','Format','preserveinput');
ErosiveMonthlyCounts=zeros(38,13);
for i=1:numMinErosiveEvents
    nowdatetime=char(ErosiveTimes(i));
    [idash]=strfind(nowdatetime,'-');
    numdash=length(idash);
    is=idash(2)+1;
    ie=is+3;
    nowYear=str2double(nowdatetime(is:ie));
    is=idash(1)+1;
    ie=is+2;
    MonthStr=nowdatetime(is:ie);
    [monthnum] = ConvertMonthStrToNumber(MonthStr);
    ab=1;
    rowindex=nowYear-1984+1;
    colindex=monthnum;
    ErosiveMonthlyCounts(rowindex,colindex)=ErosiveMonthlyCounts(rowindex,colindex)+1;
    ab=2;
end
% Sum up the Monthly counts to get the yearly counts
iFirstYear=0;
iLastYear=0;
for i=1:38
    YearlySum=0;
    for j=1:12
        YearlySum=YearlySum+ErosiveMonthlyCounts(i,j);
    end
    if((YearlySum>0) && (iFirstYear==0))
        iFirstYear=i;
        iLastYear=0;
    end
    if(YearlySum>0) 
        iLastYear=i;
    end
    ErosiveMonthlyCounts(i,13)=YearlySum;
end
is=iFirstYear;
ie=iLastYear;
ab=2;
%% Now Turn this into a Table
ErosiveEvent2Table=table(ErosiveMonthlyCounts(is:ie,1),ErosiveMonthlyCounts(is:ie,2),ErosiveMonthlyCounts(is:ie,3),...
    ErosiveMonthlyCounts(is:ie,4),ErosiveMonthlyCounts(is:ie,5),ErosiveMonthlyCounts(is:ie,6),...
    ErosiveMonthlyCounts(is:ie,7),ErosiveMonthlyCounts(is:ie,8),ErosiveMonthlyCounts(is:ie,9),...
    ErosiveMonthlyCounts(is:ie,10),ErosiveMonthlyCounts(is:ie,11),ErosiveMonthlyCounts(is:ie,12),...
    ErosiveMonthlyCounts(is:ie,13),EventYears(is:ie),'VariableNames',{'Jan','Feb','Mar','Apr','May',...
    'Jun','Jul','Aug','Sep','Oct','Nov','Dec',...
    'Year','EventYears'});
ErosiveEvent2TT = table2timetable(ErosiveEvent2Table,'RowTimes','EventYears');
ab=2;
%% Now save these table for future Reference
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='PotentialStormsTable PotentialStormsTT';
varstr2=' PotentialStorms2Table  PotentialStorms2TT';
varstr3=' ErosiveEventTable ErosiveEventTT ErosiveEvent2Table ErosiveEvent2TT';
varstr=strcat(varstr1,varstr2,varstr3);
MatFileName=strcat('Station-',num2str(StationNum),'-ErosionTables','.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Saved Output Tables to File-',MatFileName);
disp(dispstr);
%% Now create tables that can be copied to Excel
% Start with storm data from the first pass
if(iExcel==1)
    eval(['cd ' excelpath(1:length(excelpath)-1)]);
    ExcelFileName=strcat('Station-',num2str(StationNum),'-RevAPotentialStorms.xlsm');
    if exist(ExcelFileName, 'file')==2
        delete(ExcelFileName);
        dispstr=strcat('Deleted older copy of file-',ExcelFileName);
        disp(dispstr)
    end
    ab=1;
    writetimetable(PotentialStormsTT,ExcelFileName,'Sheet','FirstPass');
    dispstr=strcat('Wrote First Pass Table-',ExcelFileName,'-To Spreadsheet');
    disp(dispstr);
    fprintf(fid,'%\n');
    fprintf(fid,'%s\n','------ Wrote First Pass Storm Data----- To Excel');
    fprintf(fid,'%s\n',dispstr);
    fprintf(fid,'%\n');
    % Now add data for the second pass
    ExcelFileName=strcat('Station-',num2str(StationNum),'-RevAPotentialStorms.xlsm');
    writetimetable(PotentialStorms2TT,ExcelFileName,'Sheet','SecondPass');
    dispstr=strcat('Wrote Second Pass Table-',ExcelFileName,'-To Spreadsheet');
    disp(dispstr);
    fprintf(fid,'%\n');
    fprintf(fid,'%s\n','------ Wrote Second Pass Storm Data----- To Excel');
    fprintf(fid,'%s\n',dispstr);
    fprintf(fid,'%\n');
    % Now add data for the Erosive Events
    ExcelFileName=strcat('Station-',num2str(StationNum),'-RevAPotentialStorms.xlsm');
    writetimetable(ErosiveEventTT,ExcelFileName,'Sheet','ErosiveEvents');
    dispstr=strcat('Wrote Erosive Events Table-',ExcelFileName,'-To Spreadsheet');
    disp(dispstr);
    fprintf(fid,'%\n');
    fprintf(fid,'%s\n','------ Wrote Erosive Events Data----- To Excel');
    fprintf(fid,'%s\n',dispstr);
    fprintf(fid,'%\n');
    % Now add data for the Erosive Counts By Month
    ExcelFileName=strcat('Station-',num2str(StationNum),'-RevAPotentialStorms.xlsm');
    writetimetable(ErosiveEvent2TT,ExcelFileName,'Sheet','ErosiveEventsCounts');
    dispstr=strcat('Wrote Event Counts Table-',ExcelFileName,'-To Spreadsheet');
    disp(dispstr);
    fprintf(fid,'%\n');
    fprintf(fid,'%s\n','------ Wrote Erosive Event Counts Data----- To Excel');
    fprintf(fid,'%s\n',dispstr);
    fprintf(fid,'%\n');
end

%% close out activities
endruntime=deblank(datestr(now));
endrunstr=strcat('End CalculateRainFallErosion Factor at-',startruntime);
fprintf(fid,'%50s\n',endrunstr);
elapsed_time=toc;
dispstr=strcat('Run took-',num2str(elapsed_time),'-seconds');
disp(dispstr)
fprintf(fid,'%s\n',dispstr);
fclose(fid);
ab=3;