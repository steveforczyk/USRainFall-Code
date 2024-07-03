% Read NCIE CSV Files
% Contains 15 Min Precip Data for a single COOP Station

% Written By: Stephen Forczyk/Joydeb Saha
% Created:June 14,2024
% Revised:Jun 16-18,2024 added code to sum daily
%         raintotals to get Monthly totals
%         created breakpoint file to see where the monthly
%         breakpoints were
% Revised: Jun 22,2024 added plot showing data quality for each day 
% Revised: June 23,2024 moved location of file save to occur after plots
% Revised: Jun 27,2024 added data to HPSStationStatsTable
% Classification: Unclassified/Public Domain


global COOPFileName COOPOutputFile COOPNum Division State County;
global COOPStationName BeginDate EndDate ChosenState ChosenStateFipsCode ChosenStateAbrv;
global LatDeg LatMin LatSec LonDeg LonMin LonSec Elevation NumDelim;
global LatS LonS COOPStationTable COOPActiveStationTable CurrentStation MatFileName;
global StateFIPSCodes NationalCountiesShp AllStateBoundaries StateShapeFile StateBoundaryDataFile;
global USAStatesShapeFileList USAStatesFileName CountyBoundaryFile S0 SR selectedState;
global StateFIPSFile USCountiesShapeFile StateBoundaries SC nactiveStations imatchFIPS;
global iDTEDMap DTEDFileName Alabama AlabamaRB;
global StationName StationLat StationLon StationElev Element StationDlySum;
global StationDlySumMF StationDlySumQF StationDlySumS1 StationDlySumS2;
global YearN MonthN DayN HoursN MinutesN SecN YearRec MonthRec DayRec RecordTimes;
global RainFallTable RainFallTT RainFallTimes RainVals SourceFlag1 SourceFlag2;
global RecordTable RecordTT;
global HPDStationFile numCOOPStations StationMetaData;
global StnID LatStn LonStn ElvStn StateStn NameStn WMO_ID Sample_Interval UTC_Offset;
global POR_Date_Range PCT_POR_Good Last_Half_POR PCT_Last_Half_Good;
global Last_QTR_POR PCT_Last_Qtr_Good ;
global firstYear firstMonth firstDay lastYear lastMonth lastDay BreakPoints;
global MonthlyRainFallTotals YearBox MonthBox DayBox MonthlyTimes MonthlySum;
global MonthlyRainTable MonthlyRainTT YearlySum YearDates YearlyRainTable;
global ChosenStateLat ChosenStateLon ChosenStatePoP ChosenStateName maxNCEICities;
global InStateStationLat InStateStationLon InStateStationElv InStateStationName instatect;
global polyorder pRain SRain deltaRain yRainPred yRainPred1 YearDatesf YearlySumf;
global NoRainDays TraceRainDays MediumRainDays HeavyRainDays tracelimit heavyrainlimit;
global numallused numpartialused fracperfect imatchstation;
global numPredYears startRain endRain RainChangeRate;
global ActualDays TotalDays STRain ERain HeavyRainD MedRainD TraceRainD NoRainD ;
global HPDStationStatsTable HPDStationTable;

global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch

global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath matlabdata cooppath;
global tablepath jpegpath govjpegpath dailyfilepath rainfalldatapath csvfilepath excelpath;
global textpath USshapefilepath countyshapepath stateboundarypath statedtedpath specialcountiespath;
global uscitiespath naturalearthpath;
global fid fid2;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog ;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global iMethod iCalif;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;
global iLogo LogoFileName1 iCheckConfig iExcel iRunExcelMacro;
global iCreateMap;



%% Paths
datapath='K:\Joydeb\Alabama_Precip\';
matlabpath='K:\Joydeb\NCEI_Data\Mat_Files\';
moviepath='D:\Joydeb\Movies\';
tiffpath='D:\Joydeb\Tiff_Files\';
logfilepath='K:\Joydeb\NCEI_Data\Log_Files\';
mappath='K:\Joydeb\Map_Files\';
maskpath='D:\Joydeb\Mask_Files\';
matlabdata='K:\Joydeb\Matlab_Data\';
tablepath='K:\Joydeb\NCEI_Data\Tables\';
jpegpath='K:\Joydeb\NCEI_Data\Jpeg_Files\';
govjpegpath='D:\Joydeb\gov_jpeg\';
dailyfilepath='D:\Joydeb\Daily_Files\';
rainfalldatapath='K:\Joydeb\RainFall_Files\';
csvfilepath='K:\Joydeb\CSV_Files\';
excelpath='K:\Joydeb\Excel_Files\';
countyshapepath='D:\Forczyk\Map_Data\MAT_Files_Geographic\';
USshapefilepath='D:\Forczyk\Map_Data\USStateShapeFiles\';
CountyBoundaryFile='CountyBoundingBoxes';
stateboundarypath='D:\Forczyk\Map_Data\USStateBoundaryFinalFiles\';
statedtedpath='D:\Forczyk\Map_Data\State_DTED_Files\';
specialcountiespath='D:\Forczyk\Map_Data\Special_County_ShapeFiles\';
cooppath='K:\Joydeb\NCEI_Data\COOP_Data\';
uscitiespath=' D:\Forczyk\Map_Data\US_Cities\';
naturalearthpath='D:\Forczyk\Map_Data\Natural_Earth\';
%% Default Values
COOPFileName='Alabama_COOP_Stations.txt';
HPDStationFile='HPD_StationInventory.mat';
StateBoundaryDataFile='StateBoundingBoxesRev1.mat';
LogoFileName1='NECILogo.jpg';
% Flag values
idecode=0;
iMovie=1;
iCreateMap=1;
iExcel=1;
iCalif=0;
iRunExcelMacro=0;
iFastSave=1;
iLogo=1;
maxNCEICities=5;
iMethod=2;
iDTEDMap=0;
DTEDFileName='UnifiedAlabamaDTED.mat';
isumhourlyfiles=1;
iCheckConfig=1;
nsortlim=25;
sf1=.039370;
min5peryear=365*24*12;
polyorder=1;
FoundData=zeros(60,3);
tracelimit=0.5;
heavyrainlimit=1.0;
USAStatesFileName='USAStatesShapeFileMapListRev4.mat';
CountyBoundaryFile='CountyBoundingBoxes';
AllStateBoundaries='All_USCounties_BoundaryData.mat';
StateFIPSFile='StateFIPCodeDataRev2.mat';
USCountiesShapeFile='tl_2023_us_county.shp';
%% Set Up Log File-text based file to store critical data about run for analysis purposes
% Start writing a log file and Also look at the current stored image paths
% file
startruntime=deblank(datestr(now));
startrunstr=strcat('Start Reading NCEI Rain File at-',startruntime);
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
logfilename=strcat('COOPCSVFileInport-',logfilename,'.txt');
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
SetUpExtraColors();
almond=[LandColors(1,1) LandColors(1,2) LandColors(1,3)];
beige=[LandColors(3,1) LandColors(3,2) LandColors(3,3)];
wheat=[LandColors(5,1) LandColors(5,2) LandColors(5,3)];
butterscotch=[LandColors(8,1) LandColors(8,2) LandColors(8,3)];
%% Check The system configuration
if(iCheckConfig==1)
    SpecifyMatlabConfiguration('ReadNCEIRainData.m')
end
%% Load in a variety of mapping data files
eval(['cd ' countyshapepath(1:length(countyshapepath)-1)]);
load('CountyBoundingBoxes.mat');
% Load the StateFipsCodes
load(StateFIPSFile);
% Load in the list of USAStateShapeFiles
load(USAStatesFileName);
% Load in the state bounding boxes
load(StateBoundaryDataFile);
% Load a list of state boundary files and contained counties
eval(['cd ' stateboundarypath(1:length(stateboundarypath)-1)]);
load(AllStateBoundaries);
numstateentries=50;

% Load up the US County Data
eval(['cd ' specialcountiespath(1:length(specialcountiespath)-1)]);
SC=shaperead(USCountiesShapeFile,'UseGeoCoords',true);
% Load US Cities data
eval(['cd ' uscitiespath(1:length(uscitiespath)-1)]);
SC3=shaperead('bx729wr3020.shp','UseGeoCoords',true);
% Load the HPS Stations Inventory
eval(['cd ' tablepath(1:length(tablepath)-1)]);
load('HPD_StationInventory.mat');
ab=1;
%% Select a single file csv text file
eval(['cd ' cooppath(1:length(cooppath)-1)]);
[COOPOutputFile,nowpath] = uigetfile('*.csv','Select One Station List File', ...
'MultiSelect', 'off');
tic;
readfilestr=strcat('Selected File-',COOPOutputFile,'-For Reading');
fprintf(fid,'%s\n',readfilestr);
[islash]=strfind(nowpath,'\');
numslash=length(islash);
is=1+islash(numslash-1);
ie=islash(numslash)-1;
ChosenState=nowpath(is:ie);
imatchFIPS=0;
for kk=1:50
    nowState=char(StateFIPSCodes(kk,5));
    a1=strcmpi(ChosenState,nowState);
    if(a1==1)
        imatchFIPS=(StateFIPSCodes{kk,3});
        ChosenStateAbrv=char(StateFIPSCodes(kk,2));
    end
end

% Now search the HPD Station Table to find which stations are in the Chosen
% State
numtotstations=height(HPDStationTable);
ik=0;
for i=1:numtotstations
    nowAbrv=char(StateStn{i});
    a1=strncmpi(ChosenStateAbrv,nowAbrv,3);
    if(a1==1)
        ik=ik+1;
    end
end
instatect=ik;
InStateStationLat=zeros(ik,1);
InStateStationLon=zeros(instatect,1);
InStateStationElv=zeros(instatect,1);
InStateStationName=cell(instatect,1);
ik=0;
for i=1:numtotstations
    nowAbrv=char(StateStn{i});
    a1=strncmpi(ChosenStateAbrv,nowAbrv,3);
    if(a1==1)
        ik=ik+1;
        InStateStationLat(ik,1)=LatStn(i,1);
        InStateStationLon(ik,1)=LonStn(i,1);
        InStateStationElv(ik,1)=ElvStn(i,1);
        stastr2=char(NameStn{i,1});
        statestrlen=length(stastr2);
        if(statestrlen>12)
            statestr=stastr2(1:12);
        else
            statestr=stastr2;
        end
        InStateStationName{ik,1}=statestr;
    end
end
%% Now import it
eval(['cd ' nowpath(1:length(nowpath)-1)]);
delimiter = ',';
opts = delimitedTextImportOptions('Delimiter',delimiter);
data = readmatrix(COOPOutputFile,opts);
[nrows,ncols]=size(data);
datastr=strcat('File Had-',num2str(nrows-1),'-Records on it');
fprintf(fid,'%s\n',datastr);
nowHour=0;
nowMin=0;
ihrs=0;
imins=0;
nvals=96*(nrows-1);
HoursN=zeros(nvals,1);
MinutesN=zeros(nvals,1);
SecN=zeros(nvals,1);
RainVals=zeros(nvals,1);
SourceFlag1=zeros(nvals,1);
SourceFlag2=zeros(nvals,1);
YearRec=zeros(nrows-1,1);
MonthRec=zeros(nrows-1,1);
DayRec=zeros(nrows-1,1);
StationDlySum=zeros(nrows-1,1);
StationDlySumQF=zeros(nrows-1,1);
for kk=1:nvals
    HoursN(kk,1)=nowHour;
    imins=mod(kk,4);
    if(imins==1)
        imin=0;
    elseif(imins==2)
        imin=15;
    elseif(imins==3)
        imin=30;
    elseif(imins==0)
        imin=45;
        nowHour=nowHour+1;
    end
    MinutesN(kk,1)=imin;
end
ik=0;
importfile=RemoveUnderScores(COOPOutputFile);
waitstr=strcat('Importing CSV File-',importfile);
hfs=waitbar(0,waitstr);
numallused=0;
numpartialused=0;
fracperfect=0;
for n=2:nrows
   
    if(n==2)
        StationName=data{n,1};
        StationLat=data{n,2};
        StationLon=data{n,3};
        StationElev=data{n,4};
    end
    RowDate=data{n,5};
    Element=data{n,6};
    dlysum=str2double(data{n,487});
    if(dlysum<0)
        dlysum=0;
    end
    StationDlySum(n-1,1)=dlysum/100;% Report in inches
    qfsumstr=char(data{n,489});
    a1=isempty(qfsumstr);
    if(a1==1)% All data was used
       StationDlySumQF(n-1,1)=1;
       numallused=numallused+1;
    else% less than 96 values used
       StationDlySumQF(n-1,1)=2;
       numpartialused=numpartialused+1;
    end
    if(ik<5)% Get the times for each data point
        YearN(1,1)=str2double(RowDate(1:4));
        MonthN(1,1)=str2double(RowDate(6:7));
        DayN(1,1)=str2double(RowDate(9:10));
    end
    % Get the start time of each record
    YearRec(n-1,1)=str2double(RowDate(1:4));
    MonthRec(n-1,1)=str2double(RowDate(6:7));
    DayRec(n-1,1)=str2double(RowDate(9:10));
    for k=7:5:482
        ik=ik+1;
        val=str2double(data{n,k});
        if(val<-9998)
            val=NaN;
        end
        RainVals(ik,1)=val;
        str1=char(data{n,k+3});
        str2=char(data{n,k+4});
        a11=strcmpi(str1,'4');
        a12=strcmpi(str1,'6');
        a13=strcmpi(str1,'H');
        if(a11==1)
            SourceFlag1(ik,1)=4;
        elseif(a12==1)
            SourceFlag1(ik,1)=6;
        elseif(a13==1)
            SourceFlag1(ik,1)=2;
        else
            SourceFlag1(ik,1)=0;
        end
        a21=strcmpi(str2,'4');
        a22=strcmpi(str2,'6');
        a23=strcmpi(str2,'H');
        if(a21==1)
            SourceFlag2(ik,1)=4;
        elseif(a22==1)
            SourceFlag2(ik,1)=6;
        elseif(a23==1)
            SourceFlag2(ik,1)=2;
        else
            SourceFlag2(ik,1)=0;
        end
        if(ik>=2)
            YearN(ik,1)=YearN(1,1);
            MonthN(ik,1)=MonthN(1,1);
            DayN(ik,1)=DayN(1,1);
        end
    end

end
close(hfs);
fracperfect=numallused/nrows;
RainFallTimes = datetime(YearN,MonthN,DayN,HoursN,MinutesN,SecN);
RecordTimes=datetime(YearRec,MonthRec,DayRec);
numrec2=height(RecordTimes);
STRain=zeros(numrec2,1);
FirstRecordTime=RecordTimes(1,1);
LastRecordTime=RecordTimes(numrec2,1);
dt=between(FirstRecordTime,LastRecordTime,'Days');
dt1=char(dt);
numchar=length(dt1);
is=1;
ie=numchar-1;
dt1s=dt1(is:ie);
daytot=str2double(dt1s);

dispstr='Now Creating RainFallTable';
disp(dispstr);
ab=1;
% Now find out what the index number of this station is in the HPD Station
% Inventory List
numstations=height(StnID);
imatchstation=1;
for ik=1:numstations
    a1=StnID(ik);
    nowCOOP=char(a1);
    a2=strcmp(nowCOOP,StationName);
    if(a2==1)
        imatchstation=ik;
    end
end
fprintf(fid,'\n');
fprintf(fid,'%s\n','Matching Station and index number from HPD Stations List');
fprintf(fid, '%12s  %12i\n',StationName,imatchstation);
fprintf(fid,'\n');
dispstr=strcat(StationName,'-Matched HPD Station Index-',num2str(imatchstation'));
disp(dispstr)
% Create a Table of This data which has 96 measurements per record
RainFallTable=table(RainVals(:,1),SourceFlag1(:,1),SourceFlag2(:,1),RainFallTimes,...
    'VariableNames',{'RainTot','SourceFlag1','SourceFlag2','RainFallTimes'});
RainFallTT = table2timetable(RainFallTable,'RowTimes','RainFallTimes');
dispstr='Finished Creating RainFallTable';
disp(dispstr);
fprintf(fid,'%s\n','Finished Creating RainFallTable');
%% Now pull the station metadata from the HPDStationFile
eval(['cd ' tablepath(1:length(tablepath)-1)]);
load('HPD_StationInventory.mat');
numCOOPStations=length(StnID);
fprintf(fid,'\n');
dispstr=strcat('Successfully read HPD Station Inventory File-HPD_StationInventory.mat','-which has-',...
    num2str(numCOOPStations),'-Stations');
disp(dispstr)
fprintf(fid,'%s\n',dispstr);
imatch=0;
for j=1:numCOOPStations
    nowStation=StnID{j,1};
    tf=contains(StationName,nowStation);
    if(tf==1)
        imatch=j;
    end
end
if(imatch>0)
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','-------Station MetaData Follows------');
    StationMetaData.ID=StationName;
    StationMetaData.Lat=LatStn(imatch,1);
    StationMetaData.Lon=LonStn(imatch,1);
    StationMetaData.Elev=StationElev;
    StationMetaData.NameStn=NameStn{imatch,1};
    StationMetaData.StateStn=StateStn{imatch,1};
    StationMetaData.SampleRate=Sample_Interval{imatch,1};
    StationMetaData.PORDateRange=POR_Date_Range{imatch,1};
    StationMetaData.PCTPORGOOD=PCT_POR_Good(imatch,1);
    StationMetaData.LastHalfPOR=Last_Half_POR{imatch,1};
    StationMetaData.PCTLastHalf_Good=PCT_Last_Half_Good(imatch,1);
    StationMetaData.LastQTRPOR=Last_QTR_POR{imatch,1};
    StationMetaData.PCT_Last_Qtr_Good=PCT_Last_Qtr_Good(imatch,1);
    metstr1=strcat('StationID=',StationName);
    fprintf(fid,'%20s\n',metstr1);
    metstr2=strcat('StationLat=',num2str(StationMetaData.Lat));
    fprintf(fid,'%17s\n',metstr2);
    metstr3=strcat('StationLon=',num2str(StationMetaData.Lon));
    fprintf(fid,'%19s\n',metstr3);
    metstr4=strcat('StationElev=',num2str(StationElev));
    fprintf(fid,'%17s\n',metstr4);
    metstr5=strcat('StationName=',StationMetaData.NameStn);
    fprintf(fid,'%18s\n',metstr5);
    metstr6=strcat('StationState=',StationMetaData.StateStn);
    fprintf(fid,'%15s\n',metstr6);
    metstr7=strcat('SampleTimeMin=',StationMetaData.SampleRate);
    fprintf(fid,'%18s\n',metstr7);
    metstr8=strcat('PORDateRange=',StationMetaData.PORDateRange);
    fprintf(fid,'%20s\n',metstr8);
    metstr9=strcat('PCT_POR_Good=',num2str(StationMetaData.PCTPORGOOD));
    fprintf(fid,'%17s\n',metstr9);
    metstr10=strcat('LastHalfPOR=',StationMetaData.LastHalfPOR);
    fprintf(fid,'%17s\n',metstr10);
    metstr11=strcat('PCTLastHalfGood=',num2str(StationMetaData.PCTLastHalf_Good));
    fprintf(fid,'%17s\n',metstr11);
    metstr12=strcat('LastQTRPOR=',StationMetaData.LastQTRPOR);
    fprintf(fid,'%17s\n',metstr12);
    metstr13=strcat('PCTLastQTRGood=',num2str(StationMetaData.PCT_Last_Qtr_Good));
    fprintf(fid,'%17s\n',metstr13);
    fprintf(fid,'%s\n','-------Station MetaData Ends------');
    fprintf(fid,'\n');
else

end
%% Start loading in some new values for this run to the HPDStationStats Table
TotalDays(imatchstation,1)=daytot;
HPDStationStatsTable{imatchstation,9}=daytot;
%% Create a separate Table that has the record level values
RecordTable=table(StationDlySum(:,1),StationDlySumQF(:,1),RecordTimes,...
    'VariableNames',{'DlySum','DlySumQF','RecordTimes'});
RecordTT = table2timetable(RecordTable,'RowTimes','RecordTimes');
dispstr='Finished Creating RecordTable';
disp(dispstr);
fprintf(fid,'%s\n','Created RecordTable');
ab=2;
numrecords=height(RecordTT);
actdays=numrecords;

fDate=char(RecordTimes(1));
lDate=char(RecordTimes(numrecords));
firstYear=str2double(fDate(8:11));
firstMonthstr=fDate(4:6);
[firstMonth] = ConvertMonthStrToNumber(firstMonthstr);
firstDay=str2double(fDate(1:2));
lastYear=str2double(lDate(8:11));
lastMonthstr=lDate(4:6);
[lastMonth] = ConvertMonthStrToNumber(lastMonthstr);
lastDay=str2double(lDate(1:2));
ActualDays(imatchstation,1)=actdays;
HPDStationStatsTable{imatchstation,10}=actdays;
ab=1;
%% Now set up an array to hold the correct start and indices for each month
% in the time period
numboxes=12*(lastYear-firstYear);
BreakPoints=zeros(numboxes,4);
yearNow=firstYear;
monthNow=1;
maxval=1;
jstart=1;
jend=100;
MonthlyRainFallTotals=zeros(numboxes,4);
YearBox=zeros(numboxes,1);
MonthBox=zeros(numboxes,1);
DayBox=15*ones(numboxes,1);
waitstr='Calculating the Monthly BreakPoints in the Dataset';
hfs=waitbar(0,waitstr);
for i=1:numboxes % Loop over all monthds in dataset time period
    imatch=0;
    rowVals=NaN(40,1);
    irow=0;
    waitbar(i/numboxes);
    if(i==1)
        BreakPoints(i,1)=yearNow;
        BreakPoints(i,2)=monthNow;
    else
        monthNow=monthNow+1;
        if(monthNow>12)
            monthNow=1;
            yearNow=yearNow+1;
            BreakPoints(i,1)=yearNow;
            BreakPoints(i,2)=monthNow;
        end
        BreakPoints(i,1)=yearNow;
        BreakPoints(i,2)=monthNow;
        numrec=numrecords-3;
        if((maxval>jstart) && (maxval<numrec))
            jstart=maxval+1;
            jend=jstart+100;
            if(jend>numrecords)
                jend=numrecords;
            end
        end
    end
    for j=jstart:jend % loop over records on data file
        nowDate=char(RecordTimes(j));
        recYear=str2double(nowDate(8:11));
        NowMonthstr=nowDate(4:6);
        [recMonth] = ConvertMonthStrToNumber(NowMonthstr);
        if((recYear==yearNow) && (recMonth==monthNow))
            irow=irow+1;
            rowVals(irow,1)=j;
        elseif((recYear>yearNow) || (recMonth>monthNow))
            if(irow>0)
                minval=min(rowVals);
                maxval=max(rowVals);
                BreakPoints(i,3)=minval;
                BreakPoints(i,4)=maxval; 
            end
            irow=0;
        end
    end
    % dispstr=strcat('Finished with search box-',num2str(i),'-of-',num2str(numboxes));
    % disp(dispstr)
end
close(hfs);
ab=2;
%% Now calculate the monthly rainfall totals from the daily summary total
YearBox(:,1)=BreakPoints(:,1);
MonthBox(:,1)=BreakPoints(:,2);
MonthlyRainFallTotals(:,1)=YearBox;
MonthlyRainFallTotals(:,2)=MonthBox;
MonthlyRainFallTotals(:,3)=DayBox;
% Calculate the nuber of days with no rain,small rain and high rain totals
NoRainDays=0;
TraceRainDays=0;
MediumRainDays=0;
HeavyRainDays=0;
numalldays=length(StationDlySum);
for n=1:numalldays
    if(StationDlySum(n,1)==0)
        NoRainDays=NoRainDays+1;
    elseif((StationDlySum(n,1)>0) && (StationDlySum(n,1)<=tracelimit))
        TraceRainDays=TraceRainDays+1;
    elseif((StationDlySum(n,1)>tracelimit) && (StationDlySum(n,1)<=heavyrainlimit))
        MediumRainDays=MediumRainDays+1;
    elseif(StationDlySum(n,1)>=heavyrainlimit)
        HeavyRainDays=HeavyRainDays+1;
    end
end
%% Add the last 4 items into the arrays for storage in the HPSStationStatsTable
NoRainD(imatchstation,1)=NoRainDays;
TraceRainD(imatchstation,1)=TraceRainDays;
MedRainD(imatchstation,1)=MediumRainDays;
HeavyRainD(imatchstation,1)=HeavyRainDays;
HPDStationStatsTable{imatchstation,11}=NoRainDays;
HPDStationStatsTable{imatchstation,12}=TraceRainDays;
HPDStationStatsTable{imatchstation,13}=MediumRainDays;
HPDStationStatsTable{imatchstation,14}=HeavyRainDays;
for n=1:numboxes
    startIndex=BreakPoints(n,3);
    endIndex=BreakPoints(n,4);
    if((startIndex==0) || (endIndex==0))
        rainsum=0.0;
    else
        rainsum=sum(StationDlySum(startIndex:endIndex,1));
    end
    MonthlyRainFallTotals(n,4)=rainsum;
end
MonthlyTimes=datetime(YearBox,MonthBox,DayBox);
fprintf(fid,'\n');
fprintf(fid,'%20s %8i\n','No Rain Days',NoRainDays);
fprintf(fid,'%20s %8i\n','Trace Rain Days',TraceRainDays);
fprintf(fid,'%20s %8i\n','Medium Rain Days',MediumRainDays);
fprintf(fid,'%20s %8i\n','Heavy Rain Days',HeavyRainDays);
fprintf(fid,'\n');
fprintf(fid,'%s\n','---------------- Monthly RainFall Totals-------------------');
fprintf(fid,'%12s    %s\n','Date','RainFall-inches');
for i=1:numboxes
    nowDate=char(MonthlyTimes(i,1));
    nowRain=MonthlyRainFallTotals(i,4);
    fprintf(fid,'%12s     %8.2f\n',nowDate,nowRain);
end
fprintf(fid,'%s\n','-------------- End Monthly RainFall Totals-------------------');
fprintf(fid,'\n');
%% Create a MonthlyRainFallTable
eval(['cd ' tablepath(1:length(tablepath)-1)]);
MonthlySum(:,1)=MonthlyRainFallTotals(:,4);
MonthlyRainTable=table(MonthlySum(:,1),MonthlyTimes,...
    'VariableNames',{'MonthlySum','MonthlyTimes'});
MonthlyRainTT = table2timetable(MonthlyRainTable,'RowTimes','MonthlyTimes');
dispstr='Creating Monthly RailFall Table';
disp(dispstr);
fprintf(fid,'%s\n',dispstr);
% Calculate a yearly sum from the monthly sums
numYears=lastYear-firstYear+1;
YearlySum=zeros(numYears,1);
YearDates=zeros(numYears,1);
ik=0;
for k=firstYear:lastYear
    ik=ik+1;
    YearDates(ik,1)=k;
end
numMonths=length(MonthlySum);
for i=1:numMonths
    nowDate=char(MonthlyTimes(i,1));
    nowYear=str2double(nowDate(8:11));
    nowRain=MonthlySum(i,1);
    imatch=0;
    for j=1:numYears
        if(nowYear==YearDates(j,1))
            imatch=j;
        end
    end
    YearlySum(imatch,1)=YearlySum(imatch,1)+nowRain;
end
%% Create a Yearly RainFall Table
MonthlySum(:,1)=MonthlyRainFallTotals(:,4);
YearlyRainTable=table(YearDates(:,1),YearlySum(:,1),...
    'VariableNames',{'Years','YearlySum'});
dispstr='Creating Yearly RailFall Table';
disp(dispstr);
fprintf(fid,'%s\n',dispstr);
fprintf(fid,'\n');
fprintf(fid,'%5s    %s\n','Year','RainFall-inches');
for i=1:numYears
    fprintf(fid,'%5i     %8.2f\n',YearDates(i,1),YearlySum(i,1));
end
fprintf(fid,'\n');
%% Perform a curve fit on the yearly data
% The user can do a linear or quad fit polyniomial (polyorder)
% some data may be missing so omit years with no data fro the fit process
numpts=length(YearlySum);
ifound=0;
imissing=0;
for n=1:numpts
    nowRain=YearlySum(n,1);
    if(nowRain>0)
        ifound=ifound+1;
    else
        imissing=imissing+1;
    end
end
YearDatesf=zeros(ifound,1);
YearlySumf=zeros(ifound,1);
ik=0;
for n=1:numpts
    nowRain=YearlySum(n,1);
    if(nowRain>0)
        ik=ik+1;
        YearDatesf(ik,1)=YearDates(n,1);
        YearlySumf(ik,1)=YearlySum(n,1);
    else
        imissing=imissing+1;
    end
end
% With the missing data removed now proceed to curfit using the
% Matlab built in polyfit function
[pRain,SRain] = polyfit(YearDatesf,YearlySumf,polyorder);
yRainPred = polyval(pRain,YearDatesf);
numYearsf=length(YearDatesf);
fprintf(fid,'\n');
fprintf(fid,'%s\n','------------ Curvefit Yearly Rain Data --------');
str1='Number of Years Fitted';
fprintf(fid,'%18s   %8i\n  ',str1,numpts);
str2='CurveFit Order';
fprintf(fid,'%12s   %4i\n  ',str2,polyorder);
str3='Fit Coefficients';
fprintf(fid,'%12s\n  ',str3);
if(polyorder==1)
    fitstr1=strcat('p0-',num2str(pRain(1,1)),'-p1-',num2str(pRain(1,2)));
    fprintf(fid,'%30s\n',fitstr1);
elseif(polyorder==2)
    fitstr1=strcat('p0-',num2str(pRain(1,1)),'-p1-',num2str(pRain(1,2)),...
        '-p2-',num2str(pRain(13)));
    fprintf(fid,'%12s\n',fitstr1);
else

end
str4='Goodness of Fit';
fprintf(fid,'%14s\n  ',str4);
fitstr2=strcat('Degrees Of Freedom-',num2str(SRain.df));
fprintf(fid,'%14s\n  ',fitstr2);
fitstr3=strcat('NormR-',num2str(SRain.normr));
fprintf(fid,'%14s\n  ',fitstr3);
fitstr4=strcat('RSquared-',num2str(SRain.rsquared));
fprintf(fid,'%14s\n  ',fitstr4);
fprintf(fid,'\n');
fprintf(fid,'%5s    %s  %s\n','Year','RainFall-inches','Fitted Rain Fall');
for i=1:numYearsf
    fprintf(fid,'%5i     %8.2f        %8.2f\n',YearDates(i,1),YearlySum(i,1),yRainPred(i,1));
end
fprintf(fid,'%s\n','------------  Finished Curvefit To Yearly Rain Data --------');
fprintf(fid,'\n');

%% Now create some plots
% Plot the Total RainFall of the data collection period
ikind=1;
titlestr=strcat(StationName,'-RainFallHistory');
PlotNCEIRainFallTable(titlestr,ikind)
% PLot the Daily Rain Fall Totals
ikind=2;
titlestr=strcat(StationName,'-DailyRainFallSums');
PlotNCEIRainFallTable(titlestr,ikind)
% Plot the Monthly RainFall Totals
ikind=3;
titlestr=strcat(StationName,'-MonthlyRainFallSums');
PlotNCEIRainFallTable(titlestr,ikind)
% Plot the Yearly RainFall Totals
ikind=4;
titlestr=strcat(StationName,'-YearlyRainFallSums');
PlotNCEIRainFallTable(titlestr,ikind)
% Plot the Daily Quality Flags
ikind=5;
titlestr=strcat(StationName,'-DailyQualityFlags');
PlotNCEIRainFallTable(titlestr,ikind)
% Get a list of cities in the selected state
numrecords=length(SC3);
ik=0;
% Find out how many cities are in the given state to preallocate memory
for i=1:numrecords
    nowFIPs=str2double(SC3(i).state_fips);
    if(imatchFIPS==nowFIPs)
        ik=ik+1;
        numcities=ik;
        ab=1;
    end
end
XChosenStateLat=zeros(numcities,1);
XChosenStateLon=zeros(numcities,1);
XChosenStatePoP=zeros(numcities,1);
XChosenStateName=cell(numcities,1);
% Now make a second pass to pull out the selected data
ik=0;
for i=1:numrecords
    nowFIPs=str2double(SC3(i).state_fips);
    nowLat=SC3(i).Lat;
    nowLon=SC3(i).Lon;
    nowPoP=SC3(i).pop_2010;
    nowName=SC3(i).name;
    if(imatchFIPS==nowFIPs)
        ik=ik+1;
        numcities=ik;
        XChosenStateLat(ik,1)=nowLat;
        XChosenStateLon(ik,1)=nowLon;
        XChosenStatePoP(ik,1)=nowPoP;
        XChosenStateName{ik,1}=nowName;
    end
end
% Now sort the cities in descending order of Population
[ChosenStatePoP,ind]=sort(XChosenStatePoP,'descend');
% Populate the other items in the sorted array
for ik=1:numcities
    indnow=ind(ik);
    ChosenStateLat(ik,1)=XChosenStateLat(indnow,1);
    ChosenStateLon(ik,1)=XChosenStateLon(indnow,1);
    ChosenStateName{ik,1}=XChosenStateName{indnow,1};
end
% Now save this file for future use
eval(['cd ' uscitiespath(1:length(uscitiespath)-1)]);
MatFileName=strcat(ChosenState,'NCEICities.mat');
actionstr='save';
varstr='ChosenStateLat ChosenStateLon ChosenStatePoP ChosenStateName' ;
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Saved City Data to File-',MatFileName);
disp(dispstr);
% Load River Shape File
eval(['cd ' naturalearthpath(1:length(naturalearthpath)-1)]);
%SR=shaperead('rs16my07.shp','UseGeoCoords',true);
%SR=shaperead('NHD_Major_Rivers.shp','UseGeoCoords',true);
% Plot a map of the selected state
titlestr=RemoveUnderScores(strcat(ChosenState,'RainFallGages'));
ikind=1;
PlotLowResStateMap(titlestr,ikind)
%% Save All The Tables
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='RainFallTable RainFallTT RainFallTimes RainVals';
varstr2=' SourceFlag1 SourceFlag2 COOPOutputFile nowpath';
varstr3=' RecordTable RecordTT StationDlySum StationDlySumQF RecordTimes';
varstr4=' MonthlyRainTable MonthlyRainTT MonthlyRainFallTotals MonthlyTimes BreakPoints';
varstr5=' YearDates YearlySum YearlyRainTable';
varstr6=' NoRainDays TraceRainDays MediumRainDays HeavyRainDays tracelimit heavyrainlimit';
varstr7=' YearDatesf YearlySumf polyorder pRain SRain yRainPred StationMetaData';
varstr8=' numallused numpartialused fracperfect';
varstr9=' numPredYears startRain endRain RainChangeRate';
varstr=strcat(varstr1,varstr2,varstr3,varstr4,varstr5,varstr6,varstr7,varstr8,varstr9);
MatFileName=strcat('Station-',StationName,'-AllTables','.mat');
dispstr=strcat('Now Saving Table-',MatFileName,'-which contains four tables and other variables');
disp(dispstr);
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Saved all Output Tables to File-',MatFileName);
fprintf(fid,'%s\n',dispstr);
disp(dispstr);
%% Save HPD Station Tables
actionstr='save';
varstr1='ActualDays ERain ElvStn HPDStationFile HPDStationStatsTable HPDStationTable HeavyRainD';
varstr2=' Last_Half_POR Last_QTR_POR LatStn LonStn MedRainD  NameStn NoRainD PCT_Last_Half_Good';
varstr3=' PCT_Last_Qtr_Good PCT_POR_Good POR_Date_Range PredYears RainChngRate SRain';
varstr4=' Sample_Interval StateStn StnID TotalDays TraceRainD  UTC_Offset WMO_ID';
varstr=strcat(varstr1,varstr2,varstr3,varstr4);
MatFileName='HPD_StationInventory.mat';
dispstr='Now  Saving HPD Station Tables';
disp(dispstr);
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Saved HPD Station Data to File-',MatFileName);
fprintf(fid,'%s\n',dispstr);
disp(dispstr);
% End Of Run Closelout
elapsed_time=toc;
estr=strcat('Run Took-',num2str(elapsed_time),'-sec to complete');
disp(estr)
fprintf(fid,'%s\n',estr);
fclose(fid);
clear all