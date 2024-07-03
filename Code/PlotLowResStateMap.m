function PlotLowResStateMap(titlestr,ikind)
% This map will plot a simple low resolution state map with the rainfall
% monitors located on it
% 
% Written By: Stephen Forczyk
% Created: June 19,2024
% Revised: June 20,2024 to add in state stations and below chart captions
% Revised: June 23,2024 made numerous adjustments to the chart to provide
%          a better view such as reduce the clutter from lables and
%          correcting s mistake in labelling the selected rain gage
% Classification: Unclassified/Public Domain
global ChosenStateLat ChosenStateLon ChosenStatePoP ChosenStateName maxNCEICities;
global StateBoundaries imatchFIPS StateBoundaryData;
global InStateStationLat InStateStationLon InStateStationElv InStateStationName instatect;
global westEdge eastEdge northEdge southEdge west;
global HPDStationFile numCOOPStations StationMetaData SR;

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
global orange bubblegum brown brightblue almond beige wheat butterscotch

% Get the limits for the plot
% Get the matching entry in the StateBoundaries Table
for ik=2:52
    nowFIPS=StateBoundaries{ik,8};
    if(nowFIPS==imatchFIPS)
        imatch=ik;
        ab=1;
    end
end

westEdge1=StateBoundaries{imatch,3};
eastEdge1=StateBoundaries{imatch,4};
southEdge1=StateBoundaries{imatch,5};
northEdge1=StateBoundaries{imatch,6};
westEdge=floor(westEdge1)-.2;
eastEdge=ceil(eastEdge1)+.2;
southEdge=floor(southEdge1)-.2;
northEdge=ceil(northEdge1)+.2;
lonExtent=eastEdge-westEdge;
latExtent=northEdge-southEdge;
% Be sure to get the corresponding index in the StateBoundary data
% This step is needed because the StatBoundaryData cell lacks and entry
% for Washington DC and is thus 1 row shorter
for ik=2:51
     nowFIPS=StateBoundaryData{ik,3};
     if(nowFIPS==imatchFIPS)
        imatch2=ik;
     end
end
StateLats=StateBoundaryData{imatch2,4};
StateLons=StateBoundaryData{imatch2,5};
% StateLats=StateLats';
% StateLons=StateLons';
if(lonExtent>10)
    MLineVal=2;
else
    MLineVal=1;
end
if(latExtent>10)
    PLineVal=2;
else
    PLineVal=1;
end

% Get the station metadata
slat=StationMetaData.Lat;
slon=StationMetaData.Lon;
sname=StationMetaData.NameStn;
statename=StationMetaData.StateStn;
stationdaterange=StationMetaData.PORDateRange;
movie_figure=figure('Position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
set(gcf,'Position',[hor1 vert1 widd lend])
set(gcf,'MenuBar','none');
h1=axesm('mercator','Frame','on','Grid','on','MapLatLimit',[southEdge northEdge],...
    'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',PLineVal,'mlabellocation',MLineVal,...
    'MLabelParallel','south','MLineLocation',1,'PLineLocation',1);
% Plot the state outlines
%plotm(StateLats,StateLons,'FaceColor',[0.9961    0.7020    0.0314]);
patchesm(StateLats,StateLons,wheat);
hold on
% Now plot the selected Cities
for n=1:maxNCEICities
    nowLat=ChosenStateLat(n,1);
    nowLon=ChosenStateLon(n,1);
    nowText=ChosenStateName{n,1};
    textlen=length(nowText);
    if(textlen>10)
        nowText=nowText(1:10);
    end
    scatterm(ChosenStateLat(n,1),ChosenStateLon(n,1),"filled","k")
    if(mod(n,1)==0)
        h1=textm(nowLat,nowLon+.1,nowText,"Color","black","FontSize",8);
    end
end
% Now plot the raingages
interval=1;
if((instatect>20) && (instatect<20))
    interval=2;
elseif(instatect>=20)
    interval=4;
end
for n=1:instatect
    nowLat=InStateStationLat(n,1);
    nowLon=InStateStationLon(n,1);
    nowText=InStateStationName{n,1};
    scatterm(nowLat,nowLon,24,'d','filled',"blue");
    if(mod(n,interval)==0)
        h2=textm(nowLat+.1,nowLon+.1,nowText,"Color","blue","FontSize",8);
    end
end
% Plot the chosen raingage
scatterm(slat,slon,80,'d','filled',"red");
h3=textm(slat+.1,slon+.1,sname,"Color","red","FontSize",8);
title(titlestr)
% Plot any Rivers
% numitem=length(SR);
% ihit=0;
% % if(numitem>3000)
% %     numitem=3000;
% % end
% for ik=1:numitem
%     nowType=SR(ik).TYPE;
%     nowName=SR(ik).PNAME;
%     namelen=length(nowName);
%     a1=strcmpi(nowType,'M');
%     if((a1==1) && (namelen>5))
%         lats=SR(ik).Lat;
%         lons=SR(ik).Lon;
%         plotm(lats,lons,'b','LineWidth',2);
%         ihit=ihit+1;
%         dispstr=strcat('Plotted Item-',num2str(ihit),'-of-',num2str(numitem),'-total records');
%         disp(dispstr)
%         ab=1;
%     end
% end
rivers = shaperead('worldrivers.shp', 'UseGeoCoords', true);
numrows=length(rivers);
for n=1:numrows % Plot the rivers
   NowLon=rivers(n).Lon;
   NowLat=rivers(n).Lat;
   hL(1)=plotm(NowLat,NowLon,'b','DisplayName','rivers');
end
% Plot a Bullseye on the chosen rainfall station
[latc,longc] = scircle1(slat,slon,15,[],earthRadius('km'));
plotm(latc,longc,'r-.','LineWidth',2);
hold off
tightmap;
%%Add a logo
if(iLogo==1)
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .21,.08,]);
    [x, ~]=imread(LogoFileName1);
    imshow(x);
    set(ha2,'handlevisibility','off','visible','off')
end
% Set up an axis for writing text at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.10;
ty1=.05;
if(ikind==1)
    txtstr1=strcat('Plot of Instate Rain Gages-',num2str(instatect),'-in total');
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',10);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('State-',statename,'-Station-',sname,'-Lat-',num2str(slat),...
        '-Lon-',num2str(slon),'-DateRange-',stationdaterange);
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
end
set(newaxesh,'Visible','Off');
pause(chart_time)
% Save the chart
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
figstr=strcat(titlestr,'.jpg');
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
pause(5)
close('all')
end