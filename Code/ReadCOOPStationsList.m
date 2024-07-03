% This script will read a list of COOP stations from the Nation Weather
% Service and Turn them Into A Matlab Table and an Excel File for later use
%
% Written By: Stephen Forczyk/Joydeb Saha
% Created:June 04,2024
% Revised: June05,2024 developed a new method to parse file
%          based on fixed spaing of columns not on detecting blank spaces
%          seems to work very well. Set iMethod=2 to use
% Revised: Jun 12,2024 created an offshoot table that only contains the
%          stations active as of 2014
%
% Classification: Unclassified/Public Domain

global COOPFileName COOPNum Division State County;
global COOPStationName BeginDate EndDate;
global LatDeg LatMin LatSec LonDeg LonMin LonSec Elevation NumDelim;
global LatS LonS COOPStationTable COOPActiveStationTable CurrentStation MatFileName;
global StateFIPSCodes NationalCountiesShp AllStateBoundaries StateShapeFile StateBoundaryData;
global USAStatesShapeFileList USAStatesFileName CountyBoundaryFile S0 selectedState;
global StateFIPSFile USCountiesShapeFile SC nactiveStations;
global iDTEDMap DTEDFileName Alabama AlabamaRB;


global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch

global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath ristpath;
global tablepath jpegpath govjpegpath dailyfilepath rainfalldatapath csvfilepath excelpath;
global textpath USshapefilepath countyshapepath stateboundarypath statedtedpath specialcountiespath;
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
matlabpath='K:\Joydeb\Matlab_Files\';
moviepath='D:\Joydeb\Movies\';
tiffpath='D:\Joydeb\Tiff_Files\';
logfilepath='D:\Joydeb\LogFiles\';
mappath='K:\Joydeb\Map_Files\';
maskpath='D:\Joydeb\Mask_Files\';
tablepath='K:\Joydeb\Tables\';
jpegpath='K:\Joydeb\Jpeg_Files\';
jpegpath='D:\Joydeb\Jpeg_COOP\';
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
%% Default Values
COOPFileName='Alabama_COOP_Stations.txt';

% Flag values
idecode=0;
iMovie=1;
iCreateMap=1;
iExcel=1;
iCalif=0;
iRunExcelMacro=0;
iFastSave=1;
iLogo=1;
iMethod=2;
iDTEDMap=0;
DTEDFileName='UnifiedAlabamaDTED.mat';
LogoFileName1='UPadua_Logo3.jpg';
isumhourlyfiles=1;
iCheckConfig=0;
nsortlim=25;
sf1=.039370;
min5peryear=365*24*12;
FoundData=zeros(60,3);
USAStatesFileName='USAStatesShapeFileMapListRev4.mat';
CountyBoundaryFile='CountyBoundingBoxes';
AllStateBoundaries='All_USCounties_BoundaryData.mat';
StateFIPSFile='StateFIPCodeDataRev1.mat';
USCountiesShapeFile='tl_2023_us_county.shp';
%% Initialize some arrays to Pre Allocate Memory-this is for section 1



tic;
%% Set Up Log File-text based file to store critical data about run for analysis purposes
% Start writing a log file and Also look at the current stored image paths
% file
startruntime=deblank(datestr(now));
startrunstr=strcat('Start Reading COOP Stations List at-',startruntime);
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
logfilename=strcat('COOPFileOutput-',logfilename,'.txt');
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
    SpecifyMatlabConfiguration('ReadCOOPStationsList.m')
end
%% Load in the CountyBoundaryFiles
eval(['cd ' countyshapepath(1:length(countyshapepath)-1)]);
load('CountyBoundingBoxes.mat');
% Load in the list of USAStateShapeFiles
load(USAStatesFileName);
% Load a list of state boundary files and contained counties
eval(['cd ' stateboundarypath(1:length(stateboundarypath)-1)]);
load(AllStateBoundaries);
numstateentries=50;
% Load the StateFipsCodes
load(StateFIPSFile);
% Load up the US County Data
eval(['cd ' specialcountiespath(1:length(specialcountiespath)-1)]);
SC=shaperead(USCountiesShapeFile,'UseGeoCoords',true);
ab=1;
%% Select a single State COOP Sation File 
% Load up the Imported Station List
eval(['cd ' datapath(1:length(datapath)-1)]);
[COOPOutputFile,nowpath] = uigetfile('*.txt','Select One Station List File', ...
'MultiSelect', 'off');
[iper]=strfind(COOPOutputFile,'.');
numper=length(iper);
is=1;
ie=iper(1);
base=COOPOutputFile(is:ie);
startfilestr=strcat('COOP Station Data taken from File-',COOPOutputFile);
fprintf(fid,'\n');
fprintf(fid,'%s\n',startfilestr);
MatFileName=strcat(base,'mat');
outstr=strcat('Run data will be saved to File-',MatFileName);
fprintf(fid,'%s\n',outstr);
fprintf(fid,'\n');
[ filelines ] = file2cell(COOPOutputFile,false);% Read the whole file into a cell array
numlines=length(filelines);
hdrline4=filelines{4,1};
hdrline5=filelines{5,1};
inewsection=0;
isection=0;
ictr5=0;
irepeat=0;
readstr=strcat('Started Import of File-',COOPOutputFile,'-which has-',num2str(numlines),'-Records');
fprintf(fid,'%s\n',readstr);
fprintf(fid,'\n');
%% Loop through the cell array
% skip the first 5 lines as are not needed
% All lines have the same format and are space delimited and have 14
% entries
nvals=numlines-5;
COOPNum=zeros(nvals,1);
Division=zeros(nvals,1);
State=cell(nvals,1);
County=cell(nvals,1);
COOPStationName=cell(nvals,1);
BeginDate=zeros(nvals,1);
EndDate=zeros(nvals,1);
LatDeg=zeros(nvals,1);
LatMin=zeros(nvals,1);
LatSec=zeros(nvals,1);
LonDeg=zeros(nvals,1);
LonMin=zeros(nvals,1);
LonSec=zeros(nvals,1);
Elevation=zeros(nvals,1);
NumDelim=zeros(nvals,1);
CurrentStation=zeros(nvals,1);
ik=0;
if(iMethod==1)
    for n=6:numlines
        teststr=filelines{n,1};
        dispstr=strcat('index=',num2str(n),'--',teststr);
        disp(dispstr);
        teststrlen=length(teststr);
        testdbl=double(teststr);
        [ispace]=find(testdbl==32);
        ispace=ispace';
        numspace=length(ispace);
        ik=ik+1;
        NumDelim(ik,1)=numspace;
        if(numspace==44)
            ab=1;
        end
        [iminus]=strfind(teststr,'-');
        tf=isempty(iminus);
        ifirst=ispace(1);
        is=1;
        ie=ifirst-1;
        COOPNum(ik,1)=str2double(teststr(is:ie));
        is=ispace(1)+1;
        ie=ispace(2)-1;
        try
            Division(ik,1)=str2double(teststr(is:ie));
        catch
            Division(ik,1)=0;
        end
        is=ispace(2)+1;
        ie=ispace(3)-1;
        State{ik,1}=teststr(is:ie);
        is=ispace(3)+1;
        ie=ispace(4)-1;
        County{ik,1}=teststr(is:ie);
        COOPStationName{ik,1}=teststr(34:42);
        if(numspace==53)
            is=ispace(18)+1;
            ie=ispace(19)-1;
    %        COOPStationName{ik,1}=teststr(is:ie);
            is=ispace(40)+1;
            ie=ispace(41)-1;
            BeginDate(ik,1)=str2double(teststr(is:ie));
            is=ispace(41)+1;
            ie=ispace(42)-1;
            EndDate(ik,1)=str2double(teststr(is:ie));
            is=ispace(43)+1;
            ie=ispace(44)-1;
            LatDeg(ik,1)=str2double(teststr(is:ie));
            is=ispace(44)+1;
            ie=ispace(45)-1;
            LatMin(ik,1)=str2double(teststr(is:ie));
            is=ispace(45)+1;
            ie=ispace(46)-1;
            LatSec(ik,1)=str2double(teststr(is:ie));
            if(tf==0)
                is=iminus(1);
                ie=ispace(47)-1;
            end
            LonDeg(ik,1)=str2double(teststr(is:ie));
            is=ispace(47)+1;
            ie=ispace(48)-1;
            LonMin(ik,1)=str2double(teststr(is:ie));
            is=ispace(48)+1;
            ie=ispace(49)-1;
            LonSec(ik,1)=str2double(teststr(is:ie));
            is=ispace(51)+1;
            ie=ispace(52)-1;
            Elevation(ik,1)=str2double(teststr(is:ie));
            ab=1;
            teststrold=teststr;
            ispace2=ispace;
        elseif(numspace==49)
            is=ispace(18)+1;
            ie=ispace(36)-1;
            is=ispace(36)+1;
            ie=ispace(37)-1;
            str1=teststr(is:ie);
            BeginDate(ik,1)=str2double(teststr(is:ie));
            is=ispace(37)+1;
            ie=ispace(38)-1;
            str2=teststr(is:ie);
            EndDate(ik,1)=str2double(teststr(is:ie));
            is=ispace(39)+1;
            ie=ispace(40)-1;
            str3=teststr(is:ie);
            LatDeg(ik,1)=str2double(teststr(is:ie));       
            is=ispace(40)+1;
            ie=ispace(41)-1;
            LatMin(ik,1)=str2double(teststr(is:ie));
            is=ispace(41)+1;
            ie=ispace(42)-1;
            LatSec(ik,1)=str2double(teststr(is:ie));
            if(tf==0)
                is=iminus(1);
                ie=ispace(43)-1;
            end
            LonDeg(ik,1)=str2double(teststr(is:ie));
            is=ispace(43)+1;
            ie=ispace(44)-1;
            LonMin(ik,1)=str2double(teststr(is:ie));
            is=ispace(44)+1;
            ie=ispace(45)-1;
            LonSec(ik,1)=str2double(teststr(is:ie));
            is=ispace(47)+1;
            ie=ispace(48)-1;
            Elevation(ik,1)=str2double(teststr(is:ie));
            teststrold=teststr;
            ispace2=ispace;
        else
            is=84;
            ie=85;
            LatDeg(ik,1)=str2double(teststr(is:ie));
            is=87;
            ie=88;
            LatMin(ik,1)=str2double(teststr(is:ie));
            is=90;
            ie=91;
            LatSec(ik,1)=str2double(teststr(is:ie));
            is=93;
            ie=96;
            LonDeg(ik,1)=str2double(teststr(is:ie));
            is=98;
            ie=99;
            LonMin(ik,1)=str2double(teststr(is:ie));
            is=101;
            ie=102;
            LonSec(ik,1)=str2double(teststr(is:ie));
        end
        DMS=[LatDeg(ik,1) LatMin(ik,1) LatSec(ik,1)];
        try
            angleInDegrees = dms2degrees(DMS);
        catch
            teststr
            dispstr=strcat('numspaces=',str2num(numspace));
            disp(dispstr)
            ab=1;
        end
        ab=1;
        LatS(ik,1)=angleInDegrees;
    end
elseif(iMethod==2)
    fprintf(fid,'%s\n','---------------------------Decoded File Data------------------------');
    fprintf(fid,'%10s %5s %4s %10s %19s','COOP Num','DIV','ST','County','Station Name');
    fprintf(fid,'                %10s %8s','Begin Date','End Date');
    fprintf(fid,' %10s      %8s  %8s\n','Latitude','Longitude','Elev');
    fprintf(fid,' %89s %3s %4s %4s %4s %3s\n','D','M','S','D','M','S');
%    fprintf(fid,' %99s %3s %4s\n','D','M','S');
    waitstr='Starting To Read The COOP Data';
    hfs=waitbar(0,waitstr);
    for n=6:numlines
        waitbar((n-5)/numlines);
        teststr=filelines{n,1};
        dispstr=strcat('index=',num2str(n),'--',teststr);
        disp(dispstr);
        teststrlen=length(teststr);
        testdbl=double(teststr);
        [ispace]=find(testdbl==32);
        ispace=ispace';
        numspace=length(ispace);
        ik=ik+1;
        NumDelim(ik,1)=numspace;
        if(numspace==44)
            ab=1;
        end
        [iminus]=strfind(teststr,'-');
        tf=isempty(iminus);
        ifirst=ispace(1);
        is=1;
        ie=6;
        str2A=teststr(is:ie);
        COOPNum(ik,1)=str2double(teststr(is:ie));
        is=8;
        ie=9;
        try
            Division(ik,1)=str2double(teststr(is:ie));
        catch
            Division(ik,1)=0;
        end
        a1=isnan(Division(ik,1));
        if(a1==1)
            Division(ik,1)=0;
        end
        is=11;
        ie=12;
        State{ik,1}=teststr(is:ie);
        is=14;
        ie=25;
        County{ik,1}=teststr(is:ie);
        is=34;
        ie=62;
        COOPStationName{ik,1}=teststr(is:ie);
        is=65;
        ie=72;
        BeginDate(ik,1)=str2double(teststr(is:ie));
        is=74;
        ie=81;
        str2=teststr(is:ie);
        tf2=contains(str2,'9999');
        CurrentStation(ik,1)=tf2;
        EndDate(ik,1)=str2double(teststr(is:ie));
        is=84;
        ie=85;
        LatDeg(ik,1)=str2double(teststr(is:ie)); 
        is=87;
        ie=88;
        LatMin(ik,1)=str2double(teststr(is:ie)); 
        is=90;
        ie=91;
        LatSec(ik,1)=str2double(teststr(is:ie)); 
        is=93;
        ie=96;
        LonDeg(ik,1)=str2double(teststr(is:ie)); 
        is=98;
        ie=99;
        LonMin(ik,1)=str2double(teststr(is:ie)); 
        is=101;
        ie=102;
        LonSec(ik,1)=str2double(teststr(is:ie));  
        is=103;
        ie=teststrlen;
        Elevation(ik,1)=str2double(teststr(is:ie));  
        DMS=[LatDeg(ik,1) LatMin(ik,1) LatSec(ik,1)];
        angleInDegrees = dms2degrees(DMS);
        LatS(ik,1)=angleInDegrees;
        DMS=[LonDeg(ik,1) LonMin(ik,1) LonSec(ik,1)];
        angleInDegrees = dms2degrees(DMS);
        LonS(ik,1)=angleInDegrees;
 % Add the decoded data to the output file
        str1=num2str(ik);
        if(ik>1)
            fprintf(fid,'%6i ',ik);
        else
            fprintf(fid,'%8i ',ik);
        end
        fprintf(fid,'%6i',Division(ik,1));
        fprintf(fid,'%6s     %12s  %-24s',State{ik,1},County{ik,1},COOPStationName{ik,1});
        fprintf(fid,'%8i  %8i  ',BeginDate(ik,1),EndDate(ik,1));
        fprintf(fid,'%2i  %2i  %2i  ',LatDeg(ik,1),LatMin(ik,1),LatSec(ik,1));
        fprintf(fid,'%4i  %2i  %2i   ',LonDeg(ik,1),LonMin(ik,1),LonSec(ik,1));
        fprintf(fid,'%6i\n  %i  %2i',Elevation(ik,1));
    end
    fprintf(fid,'%s\n','------------- End Decoded File Data-----------');
end
close(hfs);
numCurrentStations=sum(CurrentStation);
ab=1;
%% Now build a table to store the data on all the stations
COOPStationTable=table(COOPNum,Division,State,County,COOPStationName,BeginDate,EndDate,LatS,LonS,Elevation,CurrentStation,...
    'VariableNames',{'COOPNum','Division','State','County','COOPStationName','BeginDate','EndDate','Lat','Lon','Elevation',...
    'CurrentStation'});
COOPActiveStationTable=COOPStationTable;
toDelete = COOPStationTable.CurrentStation < 1;
COOPActiveStationTable(toDelete,:) = [];
[nactive,nncols]=size(COOPActiveStationTable);
nactiveStations=nactive;
ab=2;
%% Save The Current Data
eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
actionstr='save';
varstr='COOPStationTable  COOPActiveStationTable LatS LonS COOPNum COOPOutputFile';
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Saved Output Data to File-',MatFileName);
disp(dispstr);
%% Now create a map of ther selected state down to the county level
if(iCreateMap==1)
% Start by finding out what state was processed
    [iunder]=strfind(COOPOutputFile,'_');
    is=1;
    ie=iunder(1)-1;
    selectedState=COOPOutputFile(is:ie);
% Now match this up with a state
    numstates=length(USAStatesShapeFileList);
    iksave=2;
    for ik=2:numstates
        nowState=char(USAStatesShapeFileList{ik,1});
        tf=strcmp(selectedState,nowState);
        if(tf==1)
            iksave=ik;
            StateShapeFile=char(USAStatesShapeFileList{iksave,4});
        end
    end
    warning('off');
    a1=strcmpi(selectedState,'California');
    if(a1~=1)
        eval(['cd ' USshapefilepath(1:length(USshapefilepath)-1)]);
        S0=shaperead(StateShapeFile,'UseGeoCoords',true);
    else
        eval(['cd ' specialcountiespath(1:length(specialcountiespath)-1)]);
 %       StateShapeFile='CA_Counties.shp';
        StateShapeFile='cnty19_1_basicplus.shp';
        S0=shaperead(StateShapeFile,'UseGeoCoords',true);
        iCalif=1;
        ab=1;
    end
   warning('on');
end
% Call the routine to make the map
titlestr=strcat(selectedState,'-RainFall-Stations');
DisplayStateRainFallStationsRev1(titlestr)
ab=4;
%% Now load in the DTED data for the selected state
if(iDTEDMap==1)
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    load(DTEDFileName)
    dispstr=strcat('Loaded DTEDFile-',DTEDFileName);
    disp(dispstr);
    titlestr=strcat(selectedState,'-DEMMap');
    DisplayStateDEMMap(titlestr)
end
% Closeout Activities
elapsed_time=toc;
dispstr=strcat('Run Complete with an elapsed time of-',num2str(elapsed_time),'-seconds');
disp(dispstr);
fprintf(fid,'\n');
fprintf(fid,'%s\n',dispstr);
fclose(fid);
eval(['cd ' excelpath(1:length(excelpath)-1)]);
if(iRunExcelMacro==1)
    winopen('RistTemplate.xlsm');
end
ab=1;
