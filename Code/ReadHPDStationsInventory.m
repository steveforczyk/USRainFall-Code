% Read NCI HPD Station Inventory
% Contains 15 Min Precip Data for a single COOP Station

% Written By: Stephen Forczyk
% Created:June 15,2024
% Revised:June 16,2024 wrote code to save data in a table
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
global StationName StationLat StationLon StationElev Element StationDlySum;
global StationDlySumMF StationDlySumQF StationDlySumS1 StationDlySumS2;
global YearN MonthN DayN HoursN MinutesN SecN YearRec MonthRec DayRec RecordTimes;
global HPDStationFile;
global StnID LatStn LonStn ElvStn StateStn NameStn WMO_ID Sample_Interval UTC_Offset;
global POR_Date_Range PCT_POR_Good Last_Half_POR PCT_Last_Half_Good;
global Last_QTR_POR PCT_Last_Qtr_Good HPDStationTable;

global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch

global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath matlabdata cooppath;
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
matlabpath='K:\Joydeb\NCEI_Data\Mat_Files\';
moviepath='D:\Joydeb\Movies\';
tiffpath='D:\Joydeb\Tiff_Files\';
logfilepath='D:\Joydeb\LogFiles\';
mappath='K:\Joydeb\Map_Files\';
maskpath='D:\Joydeb\Mask_Files\';
matlabdata='K:\Joydeb\Matlab_Data\';
tablepath='K:\Joydeb\NCEI_Data\Tables\';
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
cooppath='K:\Joydeb\NCEI_Data\COOP_Data\';
textpath='K:\Joydeb\NCEI_Data\';
HPDStationFile='HPDStationsInventory.txt';

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
%% Read The HPD Station Inventory File 
% Import the station data
eval(['cd ' textpath(1:length(textpath)-1)]);
[ FileLines ] = file2cell(HPDStationFile,false);% Read the whole file into a cell array
numrecords=length(FileLines);
ab=1;
StnID=cell(numrecords,1);
LatStn=zeros(numrecords,1);
LonStn=zeros(numrecords,1);
ElvStn=zeros(numrecords,1);
StateStn=cell(numrecords,1);
NameStn=cell(numrecords,1);
WMO_ID=cell(numrecords,1);
Sample_Interval=cell(numrecords,1);
UTC_Offset=cell(numrecords,1);
POR_Date_Range=cell(numrecords,1);
PCT_POR_Good=zeros(numrecords,1);
Last_Half_POR=cell(numrecords,1);
PCT_Last_Half_Good=zeros(numrecords,1);
PCT_Last_Qtr_Good=zeros(numrecords,1);
%% Now process the records one at a time
for n=1:numrecords
    nowLine=FileLines{n,1};
    is=1;
    ie=11;
    str1=nowLine(is:ie);
    StnID{n,1}=str1;
    ab=1;
    is=13;
    ie=20;
    LatStn(n,1)=str2double(nowLine(is:ie));
    is=22;
    ie=30;
    LonStn(n,1)=str2double(nowLine(is:ie));
    is=32;
    ie=37;
    ElvStn(n,1)=str2double(nowLine(is:ie));
    is=39;
    ie=40;
    str2=nowLine(is:ie);
    StateStn{n,1}=str2;
    ab=1;
    is=42;
    ie=122;
    str3=nowLine(is:ie);
    NameStn{n,1}=str3;
    ab=1;
    is=124;
    ie=128;
    str4=nowLine(is:ie);
    WMO_ID{n,1}=str4;
    is=130;
    ie=133;
    str5=nowLine(is:ie);
    Sample_Interval{n,1}=str5;
    is=135;
    ie=139;
    str6=nowLine(is:ie);
    UTC_Offset{n,1}=str6;
    is=141;
    ie=157;
    str7=nowLine(is:ie);
    POR_Date_Range{n,1}=str7;
    is=159;
    ie=163;
    PCT_POR_Good(n,1)=str2double(nowLine(is:ie));
    is=166;
    ie=182;
    str8=nowLine(is:ie);
    Last_Half_POR{n,1}=str8;
    is=184;
    ie=188;
    PCT_Last_Half_Good(n,1)=str2double(nowLine(is:ie));
    is=191;
    ie=207;
    str9=nowLine(is:ie);
    Last_QTR_POR{n,1}=str9;
    is=209;
    ie=213;
    str10=nowLine(is:ie);
    PCT_Last_Qtr_Good(n,1)=str2double(str10);
end
ab=2;
% Now make a Table
HPDStationTable=table(StnID,LatStn(:,1),LonStn(:,1),ElvStn(:,1),StateStn,NameStn,WMO_ID,Sample_Interval,...
    UTC_Offset,POR_Date_Range,PCT_POR_Good(:,1),Last_Half_POR,PCT_Last_Half_Good(:,1),Last_QTR_POR,PCT_Last_Qtr_Good(:,1),...
    'VariableNames',{'StationID','LatStn','LonStn','ElvStn',...
    'StateStn','NameStn','WMO','SampleInterval',...
    'UTCOffset','PORDateRange','PCTPorGood','LastHalfPOR','PCTLSTHalfGood','LastQtrPOR','PctLastQtrGood'});
ab=3;
%% Now save this table
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='HPDStationTable HPDStationFile';
varstr2=' StnID LatStn LonStn ElvStn StateStn NameStn WMO_ID Sample_Interval UTC_Offset';
varstr3=' POR_Date_Range PCT_POR_Good Last_Half_POR PCT_Last_Half_Good';
varstr4=' Last_QTR_POR PCT_Last_Qtr_Good';
varstr=strcat(varstr1,varstr2,varstr3,varstr4);
MatFileName='HPD_StationInventory.mat';
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Saved Station Table to File-',MatFileName);
disp(dispstr);