function PlotRainFallRatesCumilDist(outputXVals,outputValues,cumilOutput,titlestr)
% plot the cumiliative distribution of the rainfall data but omit
% the periods of zero rain which is the majority of time
% Written By: Stephen Forczyk
% Created: Feb 15,2021
% Revised: ------
% Classification: Unclassified

global TotalValues TotalWet TotalDry;
global Allraintotmax5 Allrate5sample Allraintotmax15 Allrate15sample Allraintotmax30 Allrate30sample;
global idebug isavefiles;

global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2 fid;
global idirector mov izoom iwindow;
global matpath GOES16path;
global jpegpath ;
global smhrpath excelpath ascpath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
% additional paths needed for mapping
global matpath1 mappath;
global canadapath stateshapepath topopath;
global trajpath militarypath;
global figpath screencapturepath gridpath;
global shapepath2 countrypath countryshapepath usstateboundariespath;

% if((iCreatePDFReport==1) && (RptGenPresent==1))
%     import mlreportgen.dom.*;
%     import mlreportgen.report.*;
% end
fprintf(fid,'\n');
fprintf(fid,'%s\n','-----Create Rainfall Cumilative Distribution Plot-----');


% Now create a line plot of the cumilative distribution
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
set(gca,'Position',[.16 .18  .70 .70]);
%h=plot(outputXVals,outputValues,'g');
h=plot(cumilOutput,outputValues,'g');
xlabel('Fraction','FontWeight','bold');
ylabelstr='RainFall Rate mm/hr';
ylabel(ylabelstr,'FontWeight','bold');
set(gca,'FontWeight','bold');
set(gca,'XGrid','On','YGrid','On');
ht=title(titlestr);
set(ht,'FontWeight','bold');
% Set up the axis for writing at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.14;
ty1=.10;
txtstr1=strcat('TotalSamples-',num2str(TotalValues),...
    '-TotalRainSamples-',num2str(TotalWet),'-Dry Samples-',num2str(TotalDry));
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',10);
tx2=.14;
ty2=.06;
txtstr2=strcat('Max 5 minute Rain=',num2str(Allraintotmax5),'-Max 15 min-',num2str(Allraintotmax15),...
    '-Max 30 min-',num2str(Allraintotmax30),'-in mm');
txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',8);
set(newaxesh,'Visible','Off');
pause(chart_time);
% Save this chart
figstr=strcat(titlestr,'.jpg');
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all')
% if((iCreatePDFReport==1) && (RptGenPresent==1))
%     [ibreak]=strfind(GOESFileName,'_e');
%     is=1;
%     ie=ibreak(1)-1;
%     GOESShortFileName=GOESFileName(is:ie);
%     br = PageBreak();
%     add(chapter,br);
%     add(chapter,Section('AOD Cumil Distribution'));
%     imdata = imread(figstr);
%     [nhigh,nwid,ndepth]=size(imdata);
%     image = mlreportgen.report.FormalImage();
%     image.Image = which(figstr);
%     pdftxtstr=strcat('AOD Data For File-',GOESShortFileName);
%     pdftext = Text(pdftxtstr);
%     pdftext.Color = 'red';
%     image.Caption = pdftext;
%     nhighs=floor(nhigh/2.5);
%     nwids=floor(nwid/2.5);
%     heightstr=strcat(num2str(nhighs),'px');
%     widthstr=strcat(num2str(nwids),'px');
%     image.Height = heightstr;
%     image.Width = widthstr;
%     image.ScaleToFit=0;
%     add(chapter,image);
% % Now add some text 
%     parastr81=strcat('The Data for this chart was taken from file-',GOESShortFileName,'.');
%     parastr82='This chart shows the cumilative distribution of all valid AOD estimates.';
%     parastr83=strcat('The median value for the AOD is-',num2str(ptile50ht,6),'-this includes land and sea based pixels values lumped together.');
%     parastr89=strcat(parastr81,parastr82,parastr83);
%     p8 = Paragraph(parastr89);
%     p8.Style = {OuterMargin("0pt", "0pt","0pt","10pt")};
%     add(chapter,p8);
%     add(rpt,chapter);
%     close('all');
%     dispstr=strcat('Saved file-',figstr);
%     disp(dispstr);
%     savestr1=strcat('Saved Plot to File-',figstr);
%     fprintf(fid,'%s\n',savestr1);
%     fprintf(fid,'%s\n','-----Finished AOD Cumilative Distribution Plot-----');
%     fprintf(fid,'\n');
% end


end