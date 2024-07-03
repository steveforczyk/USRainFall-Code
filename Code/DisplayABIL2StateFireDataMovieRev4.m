function DisplayABIL2StateFireDataMovieRev4(FireLats,FireLons,FireHotValues,itype,fireState,fireStateFP,iframe,numfound,titlestr)
% Display various types of fire data for the ABI-L2-FireData set
% obtains from GOES-16. The plot symbols change color and size based on
% the magnitude of FireHotValues. The symbols are plotted in increasing
% order of the FireHotValues so the most important data is not obscured
% The scale is this map is roughly state sized
% This Rev 1 version of the original file is aimed at try to store a
% basemap as a geotiff and then reload it later to save time
% This version will plot additional roads and lakes 

% Written By: Stephen Forczyk
% Created: Sept 30,2021
% Revised: Dec 27,2021 broke some code section to blocks added print
% statement
% 

% Classification: Unclassified

global imatchState SelectedState;
global FireDataSet TotalFireDataSet iFireMovie numframes FireLabels;
global GeoTiffFileName imgdata R1;

global xImgS xImgBS SatDataS GeoSpatialS;
global GoesWaveBand ESunS kappa0S PlanckS FocalPlaneS;
global GOESFileName OutlierPS CloudTopTS LZAS LZABS SZAS SZABS;
global WaterPrelimFeatures WaterFinalFeatures WaterSortedFeatures;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc;
global JpegCounter JpegFileList;

global GOESFileName FireDetails;
global GRB_ErrorsS L0_ErrorsS;
global westEdge eastEdge northEdge southEdge;
global westEdge1 eastEdge1 northEdge1 southEdge1;
global MonthDayStr MonthDayYearStr;
global DayMonthNonLeapYear DayMonthLeapYear CalendarFileName;
global NationalCountiesShp CityShapeData StateBoundaries;
global USAStatesShapeFileList USAStatesFileName;
global UrbanAreasShapeFile TimeCounter;
global iBullsEye iBullsEyeStart iBullsEyeInc iDrawBullsEye;
global orange bubblegum brown brightblue;
global iPrimeRoads iCountyRoads iCommonRoads iStateRecRoads iUSRoads iStateRoads;
global iLakes FlagSelections FlagSelections2;
global TempMovieName vTemp numMovieFrames nowMovieFrame;
global NationalCountiesShape;
global LegendPresent;

global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2 fid;
global idirector mov izoom iwindow;
global matpath GOES16path;
global jpegpath ;
global smhrpath excelpath ascpath nationalshapepath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global ghL;
% additional paths needed for mapping
global matpath1 mappath tiffpath;
global canadapath stateshapepath topopath;
global trajpath militarypath;
global figpath screencapturepath USshapefilepath;
global shapepath2 countrypath countryshapepath usstateboundariespath;
global GOES16Band1path GOES16Band2path GOES16Band3path GOES16Band4path;
global GOES16Band5path GOES16Band6path GOES16Band7path GOES16Band8path
global GOES16Band9path GOES16Band10path GOES16Band11path GOES16Band12path;
global GOES16Band13path GOES16Band14path GOES16Band15path GOES16Band16path;
global figpath;
global GOES16CloudTopHeightpath shapefilepath;
global moviepath firepath geotiffpath;
USshapefilepath='D:\Forczyk\Map_Data\USStateShapeFiles\';

if((iCreatePDFReport==1) && (RptGenPresent==1))
    import mlreportgen.dom.*;
    import mlreportgen.report.*;
end
warning('off')
jpegstr=strcat('Movie file written to path-',moviepath);
fprintf(fid,'%s\n',jpegstr);
numHotPixels=length(FireLats);

MLineVal=1;
PLineVal=1;
numdiv=60;
numMdiv=abs(westEdge1-eastEdge1)/MLineVal;
if(numMdiv>8)
    MLineVal=2;
end
% Set up the map axis
set(gcf,'Position',[hor1 vert1 widd lend])
set(gcf,'MenuBar','none');
h1=axesm('mercator','Frame','on','Grid','on','MapLatLimit',[southEdge1 northEdge1],...
    'MapLonLimit',[westEdge1 eastEdge1],'meridianlabel','on','parallellabel','on','plabellocation',PLineVal,'mlabellocation',MLineVal,...
    'MLabelParallel','south','MLineLocation',1,'PLineLocation',1);
h1.Color=[ 0.3 0.3 0.3];
MidMapLon=(westEdge1+eastEdge1)/2;
MidMapLat=(southEdge1+northEdge1)/2;
XB=[westEdge1 eastEdge1 eastEdge1 westEdge1 westEdge1];
YB=[southEdge1 southEdge1 northEdge1 northEdge1 southEdge1];
numdiv=50;
igo=1;
InnerPos=get(h1,'InnerPosition');
widd3=InnerPos(1,3);
lend3=InnerPos(1,4);
ictr=0;
framestr=strcat('Creating Map for frame-',num2str(iframe));
fprintf(fid,'\n');
fprintf(fid,'%s\n',framestr);
fprintf(fid,'\n');
while igo>0
    logosizelat=abs(northEdge1-southEdge1)/numdiv;
    logosizelon=abs(westEdge1-eastEdge1)/numdiv;
    logosizeinc=min(logosizelat,logosizelon);
    lonext=abs(eastEdge1-westEdge1);
    latext=abs(northEdge1-southEdge1);
    latfrac=logosizelat/abs(northEdge1-southEdge1);
    logostr1=strcat('Logo size lon=',num2str(logosizelon,5));
    logostr2=strcat('Logo size lat=',num2str(logosizelat,5));
    logostr3=strcat('Selected logisizeinc=',num2str(logosizeinc,6));
    latfrac=logosizelat/abs(northEdge1-southEdge1);
    logostr4=strcat('logolatfrac=',num2str(latfrac,6));
    lonext=abs(eastEdge1-westEdge1);
    latext=abs(northEdge1-southEdge1);
    lonpixperdeg=widd3*widd/lonext;
    latpixperdeg=lend3*lend/latext;
    logolatpixextent=latpixperdeg*logosizelat;
    if(iframe==1)
        fprintf(fid,'\n');
        fprintf(fid,'%s\n','----- Logo size calculations-----');
        fprintf(fid,'%s\n',logostr1);
        fprintf(fid,'%s\n',logostr2);
        fprintf(fid,'%s\n',logostr3);
        fprintf(fid,'%s\n',logostr4);
        extstr=strcat('lonpixperdeg=',num2str(lonpixperdeg,6),'-latpixperdeg=',...
            num2str(latpixperdeg,6));
        fprintf(fid,'%s\n',extstr);
        mapaxisstr=strcat('widd3=',num2str(widd3),'-lend3=',num2str(lend3));
        fprintf(fid,'%s\n',mapaxisstr);
        logostr5=strcat('Logo lat size in pixels=',num2str(logolatpixextent,5));
        fprintf(fid,'%s\n',logostr5);
        fprintf(fid,'\n');
        mapstr1=strcat('Map Limits-west =',num2str(westEdge1,4),'-east =',num2str(eastEdge1,4));
        mapstr2=strcat('Map Limits-north =',num2str(northEdge1,4),'-south =',num2str(southEdge1,4));
        fprintf(fid,'%s\n',mapstr1);
        fprintf(fid,'%s\n',mapstr2);
    end
    ictr=ictr+1;
    if ((logolatpixextent>10) && (logolatpixextent<15))
        igo=0;
        passedstr1=strcat('Final logolatpixextent=',num2str(logolatpixextent,5),...
            '-numdiv=',num2str(numdiv));
        if(iframe==1)
            fprintf(fid,'%s\n',passedstr1);
        end
    elseif(logolatpixextent>=15)
        numdiv=numdiv+2;
        failedstr1=strcat('Failed big logolatpixextent=',num2str(logolatpixextent,5),...
            '-new numdiv=',num2str(numdiv));
        if(iframe==1)
            fprintf(fid,'%s\n',failedstr1);
        end
    elseif(logolatpixextent<=10)
        numdiv=numdiv-2;
        failedstr2=strcat('Failed small logolatpixextent=',num2str(logolatpixextent,5),...
            '-new numdiv=',num2str(numdiv));
        if(iframe==1)
            fprintf(fid,'%s\n',failedstr2);
        end
    end
    if(ictr>20)
        igo=0;
    end
end
hold on

tightmap;
if(iframe==1)
tic;
elapsed_time2=0;
TimeCounter{2,2}=TimeCounter{2,2}+elapsed_time2;
eval(['cd ' nationalshapepath(1:length(nationalshapepath)-1)]);
%% start by mapping the Counties from the specific state file
shapefilename=NationalCountiesShp;
tic;
if(iframe==1)
    NationalCountiesShape=shaperead(shapefilename,'UseGeoCoords',true);
    S0=NationalCountiesShape;
else
    S0=NationalCountiesShape;
end
numrecords=length(S0);
waitstr=strcat('Plotting File-',RemoveUnderScores(shapefilename));
h=waitbar(0,waitstr);
iplotcount=0;
iskipcount=0;
imiss=0;
brown=[.396 .263 .129];
icounty=0;
% Only plot the counties from the desired state
tic;
for n=1:numrecords
    BoundingBox=S0(n).BoundingBox;
    MidLon=(BoundingBox(1,1)+BoundingBox(2,1))/2;
    MidLat=(BoundingBox(1,2)+BoundingBox(2,2))/2;
    dist=sqrt((MidMapLon-MidLon)^2 + (MidMapLat-MidLat)^2);
    STATEFP=str2num(S0(n).STATEFP);
    if(STATEFP==fireStateFP)
        CountyLat=S0(n).Lat;
        CountyLon=S0(n).Lon;
        icounty=icounty+1;
        if(icounty>16)
            icounty=1;
        end
        nowColor=[LandColors(icounty,1) LandColors(icounty,2) LandColors(icounty,3)];
        patchm(CountyLat,CountyLon,nowColor);
        iplotcount=iplotcount+1;        
    else
        imiss=imiss+1;
    end
    waitbar(n/numrecords);
end
clear S0
close(h);
elapsed_time3=toc;
TimeCounter{3,2}=TimeCounter{3,2}+elapsed_time3;
tic;
rivers = shaperead('worldrivers.shp', 'UseGeoCoords', true);% low detail
% Find the matching entry for this state
eval(['cd ' USshapefilepath(1:length(USshapefilepath)-1)]);
numshapefiles=length(USAStatesShapeFileList)-1;
for kk=1:numshapefiles
    nowState=char(USAStatesShapeFileList{1+kk,1});
    a1=strcmp(nowState,fireState);
    if(a1==1)
        imatch=kk;
    end
end
numrows=length(rivers);
iriversection=0;
for n=1:numrows % Plot the rivers
   RiverLon=rivers(n).Lon;
   RiverLat=rivers(n).Lat;
   NowName='River';% this file does not have this attribute
   tf=contains(NowName,'River');
   if(tf==1)
       hL(1)=plotm(RiverLat,RiverLon,'b','LineWidth',2,'DisplayName','rivers');
       iriversection=iriversection+1;

   end
end
elapsed_time1=toc;
TimeCounter{1,2}=TimeCounter{1,2}+elapsed_time1;
eval(['cd ' USshapefilepath(1:length(USshapefilepath)-1)]);
numshapefiles=length(USAStatesShapeFileList)-1;
% Find the matching entry for this state
for kk=1:numshapefiles
    nowState=char(USAStatesShapeFileList{1+kk,1});
    a1=strcmp(nowState,fireState);
    if(a1==1)
        imatch=kk;
    end
end
tic;
shapefilename=char(USAStatesShapeFileList{imatch+1,6});
S1=shaperead(shapefilename,'UseGeoCoords',true);
numrecords=length(S1);
if(iframe==1)
    shapefilestr=strcat('Map used state shapefile-',shapefilename,'-with-',num2str(numrecords),'-records');
    fprintf(fid,'%s\n',shapefilestr);
end
% Get the quick list of roads by type
RTTYP=cell(numrecords,1);
RTTYPNUM=zeros(numrecords,1);
RTTYPLen=zeros(numrecords,1);
RTTYPCTS=zeros(6,1);
for n=1:numrecords
    nowType=char(S1(n).RTTYP);
    RTTYP{n,1}=nowType;
    a1=strcmp(nowType,'C');
    a2=strcmp(nowType,'I');
    a3=strcmp(nowType,'M');
    a4=strcmp(nowType,'O');
    a5=strcmp(nowType,'S');
    a6=strcmp(nowType,'U');
    numpts=length(S1(n).Lat);
    RTTYPLen(n,1)=numpts;
    if(a1==1)
        RTTYPNUM(n,1)=1;
        RTTYPCTS(1,1)=RTTYPCTS(1,1)+1;
    elseif(a2==1)
        RTTYPNUM(n,1)=2;
        RTTYPCTS(2,1)=RTTYPCTS(2,1)+1;
    elseif(a3==1)
        RTTYPNUM(n,1)=3;
        RTTYPCTS(3,1)=RTTYPCTS(3,1)+1;
    elseif(a4==1)
        RTTYPNUM(n,1)=4;
        RTTYPCTS(4,1)=RTTYPCTS(4,1)+1;
    elseif(a5==1)
        RTTYPNUM(n,1)=5;
        RTTYPCTS(5,1)=RTTYPCTS(5,1)+1;
    elseif(a6==1)
        RTTYPNUM(n,1)=6;
        RTTYPCTS(6,1)=RTTYPCTS(6,1)+1;
    end
end
if(iframe==1)
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','-Distribution of road types');
    rdstr1=strcat('Road Type C had-',num2str(RTTYPCTS(1,1)),'-cases');
    fprintf(fid,'%s\n',rdstr1);
    rdstr2=strcat('Road Type I had-',num2str(RTTYPCTS(2,1)),'-cases');
    fprintf(fid,'%s\n',rdstr2);
    rdstr3=strcat('Road Type M had-',num2str(RTTYPCTS(3,1)),'-cases');
    fprintf(fid,'%s\n',rdstr3);
    rdstr4=strcat('Road Type O had-',num2str(RTTYPCTS(4,1)),'-cases');
    fprintf(fid,'%s\n',rdstr4);
    rdstr5=strcat('Road Type S had-',num2str(RTTYPCTS(5,1)),'-cases');
    fprintf(fid,'%s\n',rdstr5);
    rdstr6=strcat('Road Type U had-',num2str(RTTYPCTS(6,1)),'-cases');
    fprintf(fid,'%s\n',rdstr6);
    fprintf(fid,'\n');
end
uniqueRoads=unique(RTTYP);
numuniqueRoads=length(uniqueRoads);
tic;
%% Now plot the state highways
    [StateRoads]=find(RTTYPNUM==5);
    numstateroads=length(StateRoads);
    StateRoadData=zeros(numstateroads,2);
    for n=1:numstateroads
        ind=StateRoads(n,1);
        StateRoadData(n,1)=ind;
        StateRoadData(n,2)=RTTYPLen(ind,1);
    end
    [SortedLen,isort]=sort(StateRoadData(:,2),'descend');
    maxlen=SortedLen(1,1);
    minlen=SortedLen(numstateroads,1);
    meanlen=mean(SortedLen);
    if(numstateroads<200)
        maxplot=numstateroads;
    elseif((numstateroads>=200) && (numstateroads<=400))
        maxplot=200+round(0.6*(numstateroads-200));
    elseif(numstateroads>400)
        maxplot=320+round(0.4*(numstateroads-320));
    end
    if(iStateRoads==0)
        maxplot=1;
    end
    roadstr1=strcat('Total State Roads=',num2str(numstateroads),'-maxplot=',num2str(maxplot));
    fprintf(fid,'%s\n',roadstr1);
    waitstr=strcat('Plotting StateRoads-',RemoveUnderScores(shapefilename));
    h=waitbar(0,waitstr);
    igo=1;
    n=0;
    while igo>0
        n=n+1;
        ind=isort(n,1);
        ind2=StateRoadData(ind,1);
        RoadLat=S1(ind2).Lat;
        RoadLon=S1(ind2).Lon;
        hL(1)=plotm(RoadLat,RoadLon,'Color',orange,'LineWidth',2,'DisplayName','State Roads');
        waitbar(n/maxplot);
        if(n>=maxplot)
            igo=0;
        end
    end
    close(h);
    elapsed_time5=toc;
TimeCounter{5,2}=TimeCounter{5,2}+elapsed_time5;
tic;
%% Plot just the interstates
[Interstates]=find(RTTYPNUM==2);
numinterstates=length(Interstates);
InterstateData=zeros(numinterstates,2);
for n=1:numinterstates
    ind=Interstates(n,1);
    InterstateData(n,1)=ind;
    InterstateData(n,2)=RTTYPLen(ind,1);
end
[SortedLen,isort]=sort(InterstateData(:,2),'descend');
maxlen=SortedLen(1,1);
minlen=SortedLen(numinterstates,1);
meanlen=mean(SortedLen);
if(numinterstates<200)
    maxplot=numinterstates;
elseif((numinterstates>=200) && (numinterstates<=400))
    maxplot=round(.80*numinterstates);
elseif(numinterstates>400)
    maxplot=round(.60*numinterstates);
end
if(iPrimeRoads==0)
    numinterstates=1;
end

InterStateNames=cell(numinterstates,1);
for n=1:numinterstates
    ind2=InterstateData(n,1);
    RoadName=char(S1(ind2).FULLNAME);
    RoadLat=S1(ind2).Lat;
    RoadLon=S1(ind2).Lon;
    InterStateNames{n,1}=RoadName;
end
Interstateroadstr1=strcat('# Interstate Roads.......',num2str(numinterstates),'-plot limit=',num2str(maxplot),'-roads');
fprintf(fid,'%s\n',Interstateroadstr1);
% Get the number of UniqueInterstates
UniqueInterStates=unique(InterStateNames);
numUniqueInterStates=length(UniqueInterStates);
UniqueInterStateList=cell(numUniqueInterStates,4);
fprintf(fid,'%s\n','Unique Interstates Follow');
for n=1:numUniqueInterStates
    UniqueInterStateList{n,1}=UniqueInterStates{n,1};
    UniqueInterStateList{n,2}=0;
    UniqueInterStateList{n,3}=[];
    UniqueInterStateList{n,4}=0;
    instatestr=strcat('UniqueInterstate-',num2str(n),'-',UniqueInterStates{n,1});
    fprintf(fid,'%s\n',instatestr);
end
% Now find out the total number of hits for each name
    for j=1:numinterstates
        ind2=InterstateData(j,1);
        nowRoad=char(S1(ind2).FULLNAME);
        for jj=1:numUniqueInterStates
            nowCompareInterState= char(UniqueInterStateList{jj,1});
            a1=strcmp(nowRoad,nowCompareInterState);
            if(a1==1)
                [outstr] = RemoveBlanks(nowRoad);
                tifffilename=strcat('I-',outstr,'.tif');
                UniqueInterStateList{jj,2}=UniqueInterStateList{jj,2}+1;
                UniqueInterStateList{jj,3}=tifffilename;
            end
        end
    end
% Loop over the unique interstate list one more time to prevent logos being
% written for routes that have additional qualifiers for the interstate
% name 
       for jj=1:numUniqueInterStates
           nowCompareInterState= char(UniqueInterStateList{jj,1});
           nowlen=length(nowCompareInterState);
           is=nowlen;
           ie=nowlen;
           lastchar=nowCompareInterState(is:ie);
           lastdbl=double(lastchar);
           if((lastdbl<48) || (lastdbl>57))
               UniqueInterStateList{jj,4}=1;
           end
       end
waitstr=strcat('Plotting Interstates-',RemoveUnderScores(shapefilename));
h=waitbar(0,waitstr);
igo=1;
n=0;
ilogo=0;
tic;
alreadylabelled=0;
while igo>0
    n=n+1;
    ind=isort(n,1);
    ind2=InterstateData(ind,1);
    RoadName=char(S1(ind2).FULLNAME);
% Establish what unique road this is
    kmatchinter=0;
    for kk=1:numUniqueInterStates
        nowUniqueInterState=char(UniqueInterStateList{kk,1});
        a1=strcmp(RoadName,nowUniqueInterState);
        if(a1==1)
            kmatchinter=kk;
            alreadylabelled=UniqueInterStateList{kk,4};
        end
    end
    RoadLat=S1(ind2).Lat;
    RoadLon=S1(ind2).Lon;
    numpts=length(RoadLat);
    hL(2)= plotm(RoadLat,RoadLon,'g','LineWidth',2,'DisplayName','Interstates');
    waitbar(n/numinterstates);
    if(n>=maxplot)
        igo=0;
    end
    RoadCtrLat=mean(RoadLat,'omitnan')-logosizeinc/2;
    RoadCtrLon=mean(RoadLon,'omitnan')+logosizeinc/2;
    [xin,yin,Ind]=Inside(XB,YB,RoadCtrLon,RoadCtrLat);
    a1=isempty(xin);
    if((a1==0) && (alreadylabelled==0) && (kmatchinter>0))
        tiffname=char(UniqueInterStateList{kmatchinter,3});
        eval(['cd ' tiffpath(1:length(tiffpath)-1)]);
        latlim = [(RoadCtrLat-logosizeinc) (RoadCtrLat+logosizeinc)];
        lonlim = [(RoadCtrLon-logosizeinc) (RoadCtrLon+logosizeinc)];
        info=imfinfo(tiffname);
        rasterSize = [info.Width info.Height];
        Rpix = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','north');
        RGB = imread(tiffname);
        geoshow(RGB,Rpix);
        UniqueInterStateList{kmatchinter,4}=1;
        ilogo=ilogo+1;
    end
end
close(h);
elapsed_time4=toc;
TimeCounter{4,2}=TimeCounter{4,2}+elapsed_time4;

%% Now add urban areas
clear S1
tic;
if(iframe==1)
    eval(['cd ' USshapefilepath(1:length(USshapefilepath)-1)]);
    S1=shaperead(UrbanAreasShapeFile,'UseGeoCoords',true);
    CityShapeData=S1;
    numrecords=length(S1);
    citystr1=strcat('Total Cities=',num2str(numrecords),'-on shapefile-',UrbanAreasShapeFile);
    fprintf(fid,'%s\n',citystr1);
else
    S1=CityShapeData;
    numrecords=length(S1); 
end
CityData=zeros(numrecords,1);
numinstate=0;
for n=1:numrecords
    stateFIP=S1(n).StateFIPS;
    if(stateFIP==fireStateFP)
        numinstate=numinstate+1;
    end
end
CityData=zeros(numinstate,4);
indp=0;
for n=1:numrecords
    stateFIP=S1(n).StateFIPS;
    if(stateFIP==fireStateFP)
        indp=indp+1;
        CityName=char(S1(n).CityName);
        CityData(indp,1)=length(S1(n).Lon);
        CityData(indp,2)=S1(n).ALAND10;
        CityData(indp,3)=stateFIP;
        CityData(indp,4)=n;
        citystr3=strcat('Instate City#',num2str(indp),'-City Name-',CityName,'-stateFIP=',...
            num2str(stateFIP),'-n=',num2str(n));
        fprintf(fid,'%s\n',citystr3);
    end
end
% Now make a smaller list if just the in-state cities dorted in descending
% order of size

[SortedCities,indc]=sort(CityData(:,1),'descend');
numinstate=length(indc);
if(iframe==1)
    fprintf(fid,'%s\n','In-State Cities in Descending size order-');
end

for nx=1:numinstate
    nx2=indc(nx);
    n=CityData(nx2,4);
    CityName=char(S1(n).CityName);
    citylen=length(S1(n).Lon);
    cityarea=S1(n).ALAND10;
    STATEFP=(S1(n).StateFIPS);
    citystr4=strcat('Sorted Instate City#',num2str(nx),'-City Name-',CityName,...
        '-Citylen=',num2str(citylen),'-CityArea=',num2str(cityarea),'-stateFIP=',num2str(STATEFP),...
        '-n=',num2str(n));
    if(iframe==1)
        fprintf(fid,'%s\n',citystr4);
    end
end
waitstr=strcat('Plotting Cities-',RemoveUnderScores(UrbanAreasShapeFile));
h=waitbar(0,waitstr);
numurban=0;
if(numinstate>20)
    numinstatep=20;
else
    numinstatep=numinstate;
end
for nx=1:numinstatep
    nx2=indc(nx);
    n=CityData(nx2,4);
    STATEFP=(S1(n).StateFIPS);
    CityName=char(S1(n).CityName);
    Citynamelen=length(CityName);
    if(Citynamelen>12)
        CityName=CityName(1:12);
    end
    if(STATEFP==fireStateFP)
        CityLat=S1(n).Lat;
        CityLon=S1(n).Lon;
        numpts=length(CityLat);
        hL(3)=patchm(CityLat,CityLon,'y','DisplayName','UrbanAreas');
        medLat=median(CityLat,'omitnan');
        medLon=median(CityLon,'omitnan');
        textm(medLat+.1,medLon+.1,CityName,'Color',[1 0 0],'FontSize',8,'FontWeight','bold');
        numurban=numurban+1;
        citystr2=strcat('Plotted city-',num2str(nx),'-named-',CityName);
        if(iframe==1)
            fprintf(fid,'%s\n',citystr2);
        end
        waitbar(n/numinstatep);
    end
end
elapsed_time6=toc;
close(h);
TimeCounter{6,2}=TimeCounter{6,2}+elapsed_time6;
%% Now plot lakes
% Select the correct State_water.shp file
tic
shapefilename=char(USAStatesShapeFileList{imatch+1,9});
waitstr=strcat('Plotting Lakes-',RemoveUnderScores(shapefilename));
h=waitbar(0,waitstr);
S2=shaperead(shapefilename,'UseGeoCoords',true);
numallwater=length(S2);
numwater=numallwater;
if(iLakes==0)
    numwater=5;
end
% make a list of those water features that are defined but with the 'water'
% designator and a name
WaterPrelimFeatures=cell(numwater,3);
ind=0;
for n=1:numallwater
    Natural=char(S2(n).NATURAL);
    LakeName=char(S2(n).NAME);
    LakeLat=S2(n).Lat;
    numpts=length(LakeLat);
    a1=strcmp(Natural,'water');
    a2=isempty(LakeName);
    if((a1==1) && (a2==0))
        ind=ind+1;
        WaterPrelimFeatures{ind,1}=n;
        WaterPrelimFeatures{ind,2}=LakeName;
        WaterPrelimFeatures{ind,3}=numpts;
    end
end
WaterFinalFeatures=zeros(ind,2);
numlakes=ind;
for n=1:ind
    WaterFinalFeatures(n,1)=WaterPrelimFeatures{n,1};
    WaterFinalFeatures(n,2)=WaterPrelimFeatures{n,3};
end
% Now sort in order of decreasing length
[WaterSortedFeatures,indxl]=sort(WaterFinalFeatures(:,2),'descend');
iskip=0;
ilakeplotted=0;
irestore=0;
if((iLakes==0) && (numlakes>10))
    numlakes=10;
end
numlakes2=round(numlakes/4);
if(numlakes2>300)
    numlakes2=300;
end
maxplot=numlakes2;
lakestr1=strcat('Total Lakes=',num2str(numlakes),'-maxplot=',num2str(maxplot));
fprintf(fid,'%s\n',lakestr1);
for nx=1:numlakes2
    nxx=indxl(nx,1);
    n=WaterFinalFeatures(nxx,1);
    Natural=char(S2(n).NATURAL);
    LakeName=char(S2(n).NAME);
    a1=strcmp(Natural,'water');
    a2=isempty(LakeName);
    if((a1==1) && (a2<2))
        LakeLat=S2(n).Lat;
        LakeLon=S2(n).Lon;
        LakeLat2=LakeLat;
        LakeLon2=LakeLon;
        numpts=length(LakeLat);
        A1=isnan(LakeLat);
        numnan1=sum(A1);
        [xin,yin,Ind]=Inside(XB,YB,LakeLon,LakeLat);
        numin1=length(xin);
        numtot1=length(LakeLon);
        numout1=numtot1-numin1-numnan1;
        goodfrac1=numin1/numtot1;
        try
            hL(4)=patchm(LakeLat,LakeLon,'FaceColor',brightblue,...
                'EdgeColor',brightblue,'FaceAlpha',1,'DisplayName','Lakes');
            ilakeplotted=ilakeplotted+1;
            lakestr=strcat('Plotted Lake-',num2str(LakeName));
            fprintf(fid,'%s\n',lakestr);
        catch
            iskip=iskip+1;
            if(goodfrac1>.70)% try to repair the polygon and then plot
                LakeLat2=LakeLat;
                LakeLon2=LakeLon;
                for kk=1:numpts
                    if(LakeLon2(1,kk)<=westEdge1)
                        LakeLon2(1,kk)=westEdge1+.001;
                    end
                    if(LakeLon2(1,kk)>=eastEdge1)
                        LakeLon2(1,kk)=eastEdge1-0.001;
                    end
                    if(LakeLat2(1,kk)<=southEdge1)
                        LakeLat2(1,kk)=southEdge1+.001;
                    end
                    if(LakeLat2(1,kk)>=northEdge1)
                        LakeLat2(1,kk)=northEdge1-.001;
                    end                                       
                end
                [xin2,yin2,Ind2]=Inside(XB,YB,LakeLon2,LakeLat2);
                A2=isnan(LakeLat2);
                numnan2=sum(A2);
                numin2=length(xin2);
                numtot2=length(LakeLon2);
                numout2=numtot2-numin2-numnan2;
                goodfrac2=numin2/numtot2;
                try
                    %hL(4)=patchm(LakeLat2,LakeLon2,'c','DisplayName','Lakes');
                    hL(4)=patchm(LakeLat,LakeLon,'FaceColor',brightblue,...
                    'EdgeColor',brightblue,'FaceAlpha',1,'DisplayName','Lakes');
                    ilakeplotted=ilakeplotted+1;
                    irestore=irestore+1;
                catch
                    
                end
            end
        end
    end
    waitbar(nx/numlakes2);
end
close(h);
elapsed_time7=toc;
TimeCounter{7,2}=TimeCounter{7,2}+elapsed_time7;
tot_time=0;
for jj=1:7
    add_time=TimeCounter{jj,2};
    tot_time=tot_time+add_time;
end
TimeCounter{8,2}=TimeCounter{8,2}+tot_time;
%% Add Fremont Winona Forest if this is oregon
a7=strcmp(SelectedState,'Oregon');
if(a7==1)
    load('D:\Forczyk\Map_Data\MAT_Files_Geographic\Fremont-Winema_Forest.mat');
    plotm(ForestLat,ForestLon,'-.w','LineWidth',2);
end
%% Save the base figure to a geotiff file
    eval(['cd ' geotiffpath(1:length(geotiffpath)-1)]);
    JpegFileName=['ConusHotSpotBasemap' '.jpg'];
    GeoTiffFileName=['ConusHotSpotBasemap' '.tif'];
    baseframe=getframe(gca);
    imgdata=baseframe.cdata;
    figstr2=JpegFileName;
    actionstr='print';
    typestr='-djpeg';
    [cmdString]=MyStrcat2(actionstr,typestr,figstr2);
    eval(cmdString);
    dispstr=strcat('Saved Image To File-',figstr2,'-at location-',geotiffpath);
    disp(dispstr)
    RGB=imread(JpegFileName);
    latlim = [southEdge1 northEdge1];
    lonlim = [westEdge1 eastEdge1];
    [RSize1,RSize2,depth]=size(RGB);% Old version
    [RSize1,RSize2,depth]=size(imgdata);% new version
    rasterSize = [RSize1 RSize2];
    R1 = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','north',...
        'RowsStartFrom','west');

elseif(iframe>1)
    eval(['cd ' geotiffpath(1:length(geotiffpath)-1)]);
    JpegFileName=['ConusHotSpotBasemap' '.jpg'];
    GeoTiffFileName=['ConusHotSpotBasemap' '.tif'];
    RGB=imread(JpegFileName);
    latlim = [southEdge1 northEdge1];
    lonlim = [westEdge1 eastEdge1];
    [RSize1,RSize2,depth]=size(RGB);
    rasterSize = [RSize1 RSize2];
    R = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','north',...
        'RowsStartFrom','west');
    geoshow(imgdata,R1,'DisplayType','image');
end
%% Plot the fire hot spot locations
if(numfound>0)
    cmap = rgbmap('red','blue',12);
    minval=min(FireHotValues);
    maxval=max(FireHotValues);
    [SortFireHotValues,indS]=sort(FireHotValues);
    delval=(maxval-minval)/length(cmap);
    if(delval<1)
        delval=1;
    end
    cmap2=flipud(cmap);
    minsize=12;
    maxsize=24;
    maxFireTemp=0;
    indx=1;
    firestr=strcat('Found-',num2str(numfound),'-fires','-with Temp=',num2str(minval),...
        '-to-',num2str(maxval),'-Deg-k');
    fprintf(fid,'%s\n',firestr);
    for mm=1:numHotPixels
        mms=indS(mm,1);
        nowFireHotValue=FireHotValues(mms,1);
        if(nowFireHotValue>maxFireTemp)
            indx=mm;
            maxFireTemp=nowFireHotValue;
        end
        diffnow=nowFireHotValue-minval;
        numinc=floor(diffnow/delval);
        nowInd=1+numinc;
        if(nowInd>length(cmap))
            nowInd=length(cmap);
        end
        nowColor=[cmap2(nowInd,1) cmap2(nowInd,2) cmap2(nowInd,3)];
        nowSize=floor(minsize+nowInd);
        scatterm(FireLats(mms,1),FireLons(mms,1),nowSize,nowColor,'filled')
    end
    % Now plot the BullsEye on the selected Fire
    LatC=FireLats(indx,1);
    LonC=FireLons(indx,1);
    TempC=FireHotValues(indx,1);
    latext=abs(northEdge1-southEdge1);
    if(latext<8)
        iBullsEye=3;
        iBullsEyeStart=10;
        iBullsEyeInc=10;
    elseif(latext>=8)
        iBullsEye=5;
        iBullsEyeStart=20;
        iBullsEyeInc=20;
    end
    LatC=FireLats(indx,1);
    LonC=FireLons(indx,1);
    for m=1:iBullsEye
        iBullRadius=iBullsEyeStart+(m-1)*iBullsEyeInc;
        [latc,longc] = scircle1(LatC,LonC,iBullRadius,[],earthRadius('km'));
        plotm(latc,longc,'r-.','LineWidth',2);
    end
end
title(titlestr)
hold off
scalebarlen=200;
scalebarloc='se';
scalebar('length',scalebarlen,'units','mi','color','k','location',scalebarloc,'fontangle','bold','RulerStyle','patches');
ArrowLat=northEdge1-2;
ArrowLon=eastEdge1+0.5;
northarrow('latitude',ArrowLat,'longitude',ArrowLon);
harrow=handlem('NorthArrow');
set(harrow,'FaceColor',[1 1 0],'EdgeColor',[1 0 0]);
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
% Extract the frame time
YearS=FireDataSet{1+iframe,2};
DayS=FireDataSet{1+iframe,4};
HourS=FireDataSet{1+iframe,5};
MinuteS=FireDataSet{1+iframe,6};
SecondS=FireDataSet{1+iframe,7};
tx1=.78;
ty1=.08;
txtstr1=strcat('Start Scan-Y',num2str(YearS),'-D-',num2str(DayS),'-H-',...
    num2str(HourS),'-M-',num2str(MinuteS),'-S-',num2str(SecondS));
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',8);
txt2=text(.22,ty1,'Fremont-Winona Natl Forest in White','FontWeight','bold','FontSize',10);
tx3a=.78;
ty3a=.04;
txtstr3a=strcat('Calendar Date-',MonthDayYearStr);
txt3a=text(tx3a,ty3a,txtstr3a,'FontWeight','bold','FontSize',8);
% Get the min and max values of the fire hot values
if(numfound>=1)
    minval=min(FireHotValues);
    maxval=max(FireHotValues);
else
    minval=500;
    maxval=3000;
end
tx4=.18;
ty4=.04;
if((itype==1) && (numfound>0))
    txtstr4=strcat('Hot Spots had min Temp=',num2str(minval,4),'-to-',...
        'max Temp=',num2str(maxval,4),'-DegK');
    txt4=text(tx4,ty4,txtstr4,'FontWeight','bold','FontSize',8);
    tx5=.01;
    ty5=.30;
    txtstr5='Selected Fire Data';
    txt5=text(tx5,ty5,txtstr5,'FontWeight','bold','FontSize',8);
    tx6=.01;
    ty6=.27;
    txtstr6=strcat('Lat=',num2str(LatC,4));
    txt6=text(tx6,ty6,txtstr6,'FontWeight','bold','FontSize',8);
    tx7=.01;
    ty7=.24;
    txtstr7=strcat('Lon=',num2str(LonC,4));
    txt7=text(tx7,ty7,txtstr7,'FontWeight','bold','FontSize',8);
    tx8=.01;
    ty8=.21;
    txtstr8=strcat('Temp=',num2str(TempC,4));
    txt8=text(tx8,ty8,txtstr8,'FontWeight','bold','FontSize',8);
    tx9=.01;
end

set(newaxesh,'Visible','Off');
% grab one frame of data for the movie
eval(['cd ' moviepath(1:length(moviepath)-1)]);
set(gcf,'MenuBar','none');
pause(0.2);
frame=getframe(gcf);
writeVideo(vTemp,frame);
close('all')
warning('on');


close('all');
fprintf(fid,'%s\n','*************** End Run Time Summary State Level Fire Hot Spots *************');
fprintf(fid,'%s\n','////// Finished Executing Routine DisplayABIL2StateFireDataMovieRev4.m //////');
warning('on')
end


