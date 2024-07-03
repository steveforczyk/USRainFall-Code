function DisplayStateRainFallStationsRev1(titlestr)
% Display the locatations of the active state rain fall stations 
% This differs from the original Rev0 version by using a different source
% for the country data -this is the same for all states
% Written By: Stephen Forczyk
% Created: June 10,2024
% Revised: ----
% 

% Classification: Unclassified/Public Domain
global COOPFileName COOPNum Division State County;
global COOPStationName BeginDate EndDate;
global LatDeg LatMin LatSec LonDeg LonMin LonSec Elevation NumDelim;
global LatS LonS COOPStationTable CurrentStation MatFileName;
global StateFIPSCodes NationalCountiesShp AllStateBoundaries StateShapeFile;
global USAStatesShapeFileList USAStatesFileName CountyBoundaryFile S0 SC StateBoundaryData selectedState;
global StateLats StateLons selectedFIPS nactiveStations;

global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch;
global westEdge eastEdge northEdge southEdge;
global westEdge1 eastEdge1 northEdge1 southEdge1;

global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath ristpath;
global tablepath jpegpath govjpegpath dailyfilepath rainfalldatapath csvfilepath excelpath;
global textpath USshapefilepath countyshapepath stateboundarypath specialcountiespath;
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

ab=1;
numrecords=length(SC);
numFIPSCodes=length(StateFIPSCodes);
% Find the FIPs code of the selected State
for i=1:numFIPSCodes
    a1=strcmpi(selectedState,StateFIPSCodes{i,1});
    if(a1==1)
        selectedFIPS=StateFIPSCodes{i,3};
        selectedRow=i+1;
        ab=2;
    end
end
ab=1;
StateLats=StateBoundaryData{selectedRow,4};
StateLons=StateBoundaryData{selectedRow,5};
StateLats=StateLats';
StateLons=StateLons';
westEdge=min(StateLons);
eastEdge=max(StateLons);
southEdge=min(StateLats);
northEdge=max(StateLats);
% Define the plot axes boundaries
westEdge1=round(westEdge)-1;
eastEdge1=round(eastEdge)+1;
northEdge1=round(northEdge)+1;
southEdge1=round(southEdge)-1;


PLineVal=1;
MLineVal=1;
% Set up the map axis
set(gcf,'Position',[hor1 vert1 widd lend])
set(gcf,'MenuBar','none');
h1=axesm('mercator','Frame','on','Grid','on','MapLatLimit',[southEdge1 northEdge1],...
    'MapLonLimit',[westEdge1 eastEdge1],'meridianlabel','on','parallellabel','on','plabellocation',PLineVal,'mlabellocation',MLineVal,...
    'MLabelParallel','south','MLineLocation',1,'PLineLocation',1);
% Plot the state outlines
plotm(StateLats,StateLons,'r');
istate=0;
hold on
% Plot the counties
numplotted=0;
sumtf1=0;
sumtf2=0;
sumtf3=0;
sumtf4=0;
sumtf5=0;
sumtf6=0;
icounty=0;
for n=1:numrecords
    icounty=icounty+1;
    if(icounty>16)
        icounty=1;
    end
    nowFIP=str2double(SC(n).STATEFP);
    nowName=SC(n).NAMELSAD;
    if(selectedFIPS==nowFIP)
        CountyLat=SC(n).Lat;
        CountyLon=SC(n).Lon;
        nowColor=[LandColors(icounty,1) LandColors(icounty,2) LandColors(icounty,3)];% cycle thru 16 colors
        patchm(CountyLat,CountyLon,nowColor);
        numplotted=numplotted+1;
        plotfrac=numplotted/numrecords;
        icounty=icounty+1;
    end
end
% Plot the Active Rain Gauges
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
scalebarlen=100;
scalebarloc='se';
scalebar('length',scalebarlen,'units','miles','color','k','location',scalebarloc,'fontangle','bold','RulerStyle','patches');
ArrowLat=northEdge1-0.7;
ArrowLon=eastEdge1+0.7;
northarrow('latitude',ArrowLat,'longitude',ArrowLon);
harrow=handlem('NorthArrow');
set(harrow,'FaceColor',[1 1 0],'EdgeColor',[1 0 0]);
fprintf(fid,'\n');
fprintf(fid,'%s\n','----------------- Stations Plot Data -------------');
fprintf(fid,'%17s        %10i\n','Number of Records',numrecords);
fprintf(fid,'%14s            %8i\n','Active Stations',numplotted);
fprintf(fid,'%20s     %9.4f\n','Fraction Of All Records',plotfrac);
fprintf(fid,'%s\n','----------------- End Stations Plot Data -------------');
fprintf(fid,'\n');
%% Add text to the bottom of the graph
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.14;
ty1=.04;
txtstr1=strcat('Total Stations On File-',num2str(numstations),...
    '-Active Stations-',num2str(numactive));
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',10);
tx2=.14;
ty2=.01;
txtstr2='State Borders in Red-some county lines extend to in shore waters';
txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
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
end