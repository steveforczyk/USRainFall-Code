function DisplayStateDEMMap(titlestr)
% Display the locatations of the active state rain fall stations 
% superimposed on a Topogrphical map

% Written By: Stephen Forczyk
% Created: June 6,2024
% Revised:----
% Classification: Unclassified/Public Domain
% statement
% 

% Classification: Unclassified/Public Domain
global COOPFileName COOPNum Division State County;
global COOPStationName BeginDate EndDate;
global LatDeg LatMin LatSec LonDeg LonMin LonSec Elevation NumDelim;
global LatS LonS COOPStationTable CurrentStation MatFileName;
global StateFIPSCodes NationalCountiesShp AllStateBoundaries StateShapeFile;
global USAStatesShapeFileList USAStatesFileName CountyBoundaryFile S0;
global StateLats StateLons;
global iDTEDMap DTEDFileName Alabama AlabamaRB;


global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch;
global westEdge eastEdge northEdge southEdge;
global westEdge1 eastEdge1 northEdge1 southEdge1;

global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath ristpath;
global tablepath jpegpath govjpegpath dailyfilepath rainfalldatapath csvfilepath excelpath;
global textpath USshapefilepath countyshapepath stateboundarypath;
global fid fid2;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog ;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global iMethod;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;
global iLogo LogoFileName1 iCheckConfig iExcel iRunExcelMacro;
global iCreateMap;

ab=1;
numrecords=length(S0);
westEdge=400;
eastEdge=-400;
southEdge=185;
northEdge=-185;
for ik=1:numrecords
    StateLats=S0(ik).Lat;
    StateLons=S0(ik).Lon;
    StateLats=StateLats';
    StateLons=StateLons';
    maxLonNow=max(StateLons);
    minLonNow=min(StateLons);
    westEdge=min(westEdge,minLonNow);
    eastEdge=max(eastEdge,maxLonNow);
    maxLatNow=max(StateLats);
    minLatNow=min(StateLats);
    northEdge=max(northEdge,maxLatNow);
    southEdge=min(southEdge,minLatNow);
    ab=1;
end
ab=2;

westEdge1=round(westEdge)-1;
eastEdge1=round(eastEdge)+1;
northEdge1=round(northEdge)+1;
southEdge1=round(southEdge)-1;
southEdge1=30;
northEdge1=35;
ab=2;
PLineVal=1;
MLineVal=1;
% Set up the map axis
% set(gcf,'Position',[hor1 vert1 widd lend])
% set(gcf,'MenuBar','none');
% h1=axesm('mercator','Frame','on','Grid','on','MapLatLimit',[southEdge1 northEdge1],...
%     'MapLonLimit',[westEdge1 eastEdge1],'meridianlabel','on','parallellabel','on','plabellocation',PLineVal,'mlabellocation',MLineVal,...
%     'MLabelParallel','south','MLineLocation',1,'PLineLocation',1);
% istate=0;
movie_figure=figure('position',[hor1 vert1 widd lend]);
h1=axesm('MapProjection','miller','Frame','on',...
    'MapLatLimit',[southEdge1 northEdge1],'MapLonLimit',[westEdge1 eastEdge1],'Grid','on',...
    'MeridianLabel','on','ParallelLabel','on','mlinelocation',1,...
    'plinelocation',1,'mlabellocation',1,'plabellocation',1,...
    'GColor','y','glinewidth',2,'GlineStyle','-','FlineWidth',1);
axis off
framem on
geoshow(Alabama,AlabamaRB,'DisplayType','surface');
colormap(demcmap(Alabama,2048));
colorbar('vert');
ab=2;
% load the state boundary files
hold on
eval(['cd ' stateboundarypath(1:length(stateboundarypath)-1)]);
load('AlabamaBoundaries.mat','AlabamaLat','AlabamaLon');
plot3m(AlabamaLat,AlabamaLon,3000,'r');
%% Plot the counties
% for n=1:numrecords
%     istate=istate+1;
%     if(istate>16)
%         istate=1;
%     end
%     nowName=S0(n).NAME;
%     tf1=isempty(nowName);
%     StateLat=S0(n).Lat;
%     StateLon=S0(n).Lon;
%     StateLat=StateLat';
%     StateLon=StateLon';
%     nowColor=[LandColors(istate,1) LandColors(istate,2) LandColors(istate,3)];% cycle thru 16 colors
%     if(tf1==0)% Plot just the county boundaries
%         tf2=contains(nowName,'County','IgnoreCase',true);
%         if(tf2==1)
%             patchm(StateLat,StateLon,nowColor);
%         end
%     end
% end
% Plot the Active Rain Gauges
ab=1;
numstations=length(LatS);
numactive=0;
for ik=1:numstations
    iActive=CurrentStation(ik,1);
    LatNow=LatS(ik,1);
    LonNow=LonS(ik,1);
    if(iActive==1)
        scatterm(LatNow,LonNow,"filled","r");
        numactive=numactive+1;
    end
end

tightmap;
title(titlestr)
hold off
ab=2;
scalebarlen=100;
scalebarloc='se';
scalebar('length',scalebarlen,'units','miles','color','k','location',scalebarloc,'fontangle','bold','RulerStyle','patches');
ArrowLat=northEdge-2;
ArrowLon=eastEdge+2;
northarrow('latitude',ArrowLat,'longitude',ArrowLon);
harrow=handlem('NorthArrow');
set(harrow,'FaceColor',[1 1 0],'EdgeColor',[1 0 0]);
%% Add text to the bottom of the graph
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.14;
ty1=.04;
txtstr1=strcat('Total Stations On File-',num2str(numstations),...
    '-Active Stations-',num2str(numactive));
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',10);
% tx2=.14;
% ty2=.06;
% txtstr2=strcat('Max 5 minute Rain=',num2str(Allraintotmax5),'-Max 15 min-',num2str(Allraintotmax15),...
%     '-Max 30 min-',num2str(Allraintotmax30),'-in mm');
% txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',8);
set(newaxesh,'Visible','Off');
pause(chart_time);
%% Save this chart
figstr=strcat(titlestr,'.jpg');
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all')
ab=1;
end