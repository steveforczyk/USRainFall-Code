function CalculateDescriptiveStormStats()
% This function will calculate Descriptive stats ErosiveStorm Events
% 
% The purpose of including this capabilty will be to permit comparisons of
% the data to a variety of distributions
% Written By: Stephen Forczyk/Joydeb Saha
% Created: May 24,2024
% Revised:----
% Classification: Unclassified/Public Domain

global RainFallFile1 RainFallFile2 RainFallFile1C RainFallFile2C;
global RainFallFile3 RainFallFile3C S;
global StationStr StationNum RainFallFile RainFallCatalogedFile;
global RainFallTime RainFallFlag RainFallAmt RainFallName;
global DetectTime NoDetectTime ErosiveList ErosiveList2 ErosiveIndices;
global ErosiveTimes SecondPassTimes ErosiveMonthlyCounts;
global ProvinceNames RainFallTime30 I30max;
global PotentialStorms ConsolidatedStorm  DefinedStorms BreakPoints;
global PS2 PS3 PS4 PS5 PS6 PS7 PS8 PS9 PS10 PS11 PS12 PS13 PS14 PS15 PS16;
global SPS2 SPS3 SPS4 SPS5 SPS6 SPS7 SPS8 SPS9 SPS10 SPS11 SPS12 SPS13 SPS14 SPS15 SPS16 
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

global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch

global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath;
global tablepath jpegpath govjpegpath dailyfilepath rainfalldatapath csvfilepath;
global fid fid2;
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
global isumhourlyfiles sf1;% sf1 is the scale factor to go from kg/m^2 to inches of water
global min5peryear total5minper;

%% Start Calculation the stats for the nine variables of interest
% This is based on second pass data
% Variable 1 is Total Precip in mm
StormBasicStats{1,1}='Total Precip-mm';
numvals=length(SPS7);
StormBasicStats{1,2}=numvals;
mean1=mean(SPS7);
median1=median(SPS7);
mode1=mode(SPS7);
std1=std(SPS7);
minval1=min(SPS7);
maxval1=max(SPS7);
skew1=skewness(SPS7);
kurt1=kurtosis(SPS7);
sumvalues1=sum(SPS7);
StormBasicStats{1,3}=mean1;
StormBasicStats{1,4}=median1;
StormBasicStats{1,5}=mode1;
StormBasicStats{1,6}=std1;
StormBasicStats{1,7}=minval1;
StormBasicStats{1,8}=maxval1;
StormBasicStats{1,9}=skew1;
StormBasicStats{1,10}=kurt1;
StormBasicStats{1,11}=sumvalues1;
%Variable 2 is Storm Duration in Hours
StormBasicStats{2,1}='Duration-hrs';
numvals=length(SPS4);
StormBasicStats{2,2}=numvals;
mean2=mean(SPS4);
median2=median(SPS4);
mode2=mode(SPS4);
std2=std(SPS4);
minval2=min(SPS4);
maxval2=max(SPS4);
skew2=skewness(SPS4);
kurt2=kurtosis(SPS4);
sumvalues2=sum(SPS4);
StormBasicStats{2,3}=mean2;
StormBasicStats{2,4}=median2;
StormBasicStats{2,5}=mode2;
StormBasicStats{2,6}=std2;
StormBasicStats{2,7}=minval2;
StormBasicStats{2,8}=maxval2;
StormBasicStats{2,9}=skew2;
StormBasicStats{2,10}=kurt2;
StormBasicStats{2,11}=sumvalues2;
% Variable 3 is OverRate which the number of samples in 1 segment over the
% rate limit
StormBasicStats{3,1}='#OverRateLimit';
numvals=length(SPS10);
StormBasicStats{3,2}=numvals;
mean3=mean(SPS10);
median3=median(SPS10);
mode3=mode(SPS10);
std3=std(SPS10);
minval3=min(SPS10);
maxval3=max(SPS10);
skew3=skewness(SPS10);
kurt3=kurtosis(SPS10);
sumvalues3=sum(SPS10);
StormBasicStats{3,3}=mean3;
StormBasicStats{3,4}=median3;
StormBasicStats{3,5}=mode3;
StormBasicStats{3,6}=std3;
StormBasicStats{3,7}=minval3;
StormBasicStats{3,8}=maxval3;
StormBasicStats{3,9}=skew3;
StormBasicStats{3,10}=kurt3;
StormBasicStats{3,11}=sumvalues3;
% Variable 4 is Max Rain Rate which the maximum rain fall rate over a 5 min
% period
StormBasicStats{4,1}='MaxRainRate5Min';
numvals=length(SPS5);
StormBasicStats{4,2}=numvals;
mean4=mean(SPS5);
median4=median(SPS5);
mode4=mode(SPS5);
std4=std(SPS5);
minval4=min(SPS5);
maxval4=max(SPS5);
skew4=skewness(SPS5);
kurt4=kurtosis(SPS5);
sumvals4=0;
StormBasicStats{4,3}=mean4;
StormBasicStats{4,4}=median4;
StormBasicStats{4,5}=mode4;
StormBasicStats{4,6}=std4;
StormBasicStats{4,7}=minval4;
StormBasicStats{4,8}=maxval4;
StormBasicStats{4,9}=skew4;
StormBasicStats{4,10}=kurt4;
StormBasicStats{4,11}=sumvals4;
% Variable 5 is MAX_15 which the maximum rain fall rate over a 15 minute
% period-used in qualifying a period as an erosive event
StormBasicStats{5,1}='MAXRainRate15Min';
numvals=length(SPS14);
StormBasicStats{5,2}=numvals;
mean5=mean(SPS14);
median5=median(SPS14);
mode5=mode(SPS14);
std5=std(SPS14);
minval5=min(SPS14);
maxval5=max(SPS14);
skew5=skewness(SPS14);
kurt5=kurtosis(SPS14);
sumvals5=0;
StormBasicStats{5,3}=mean5;
StormBasicStats{5,4}=median5;
StormBasicStats{5,5}=mode5;
StormBasicStats{5,6}=std5;
StormBasicStats{5,7}=minval5;
StormBasicStats{5,8}=maxval5;
StormBasicStats{5,9}=skew5;
StormBasicStats{5,10}=kurt5;
StormBasicStats{5,11}=sumvals5;
% % Variable 6 is MAX_30 which the maximum rain fall rate over a 30 minute
% % period
% StormBasicStats{6,1}='MAX_30';
% numvals=length(MAX_30);
% StormBasicStats{6,2}=numvals;
% mean6=mean(MAX_30);
% median6=median(MAX_30);
% mode6=mode(MAX_30);
% std6=std(MAX_30);
% minval6=min(MAX_30);
% maxval6=max(MAX_30);
% skew6=skewness(MAX_30);
% kurt6=kurtosis(MAX_30);
% StormBasicStats{6,3}=mean6;
% StormBasicStats{6,4}=median6;
% StormBasicStats{6,5}=mode6;
% StormBasicStats{6,6}=std6;
% StormBasicStats{6,7}=minval6;
% StormBasicStats{6,8}=maxval6;
% StormBasicStats{6,9}=skew6;
% StormBasicStats{6,10}=kurt6;
% % Variable 7 is MAX_60 which the maximum rain fall rate over a 60 minute
% % period
% StormBasicStats{7,1}='MAX_60';
% numvals=length(MAX_60);
% StormBasicStats{7,2}=numvals;
% mean7=mean(MAX_60);
% median7=median(MAX_60);
% mode7=mode(MAX_60);
% std7=std(MAX_60);
% minval7=min(MAX_60);
% maxval7=max(MAX_60);
% skew7=skewness(MAX_60);
% kurt7=kurtosis(MAX_60);
% StormBasicStats{7,3}=mean7;
% StormBasicStats{7,4}=median7;
% StormBasicStats{7,5}=mode7;
% StormBasicStats{7,6}=std7;
% StormBasicStats{7,7}=minval7;
% StormBasicStats{7,8}=maxval7;
% StormBasicStats{7,9}=skew7;
% StormBasicStats{7,10}=kurt7;
% % Variable 8 is ENERGY which the maximum rain fall rate over a 60 minute
% % period
% StormBasicStats{8,1}='ENERGY';
% numvals=length(ENERGY);
% StormBasicStats{8,2}=numvals;
% mean8=mean(ENERGY);
% median8=median(ENERGY);
% mode8=mode(ENERGY);
% std8=std(ENERGY);
% minval8=min(ENERGY);
% maxval8=max(ENERGY);
% skew8=skewness(ENERGY);
% kurt8=kurtosis(ENERGY);
% StormBasicStats{8,3}=mean8;
% StormBasicStats{8,4}=median8;
% StormBasicStats{8,5}=mode8;
% StormBasicStats{8,6}=std8;
% StormBasicStats{8,7}=minval8;
% StormBasicStats{8,8}=maxval8;
% StormBasicStats{8,9}=skew8;
% StormBasicStats{8,10}=kurt8;
% % Variable 9 is EI130 which the maximum rain fall rate over a 60 minute
% % period
% StormBasicStats{9,1}='EI130';
% numvals=length(EI130);
% StormBasicStats{9,2}=numvals;
% mean9=mean(EI130);
% median9=median(EI130);
% mode9=mode(EI130);
% std9=std(EI130);
% minval9=min(EI130);
% maxval9=max(EI130);
% skew9=skewness(EI130);
% kurt9=kurtosis(EI130);
% StormBasicStats{9,3}=mean9;
% StormBasicStats{9,4}=median9;
% StormBasicStats{9,5}=mode9;
% StormBasicStats{9,6}=std9;
% StormBasicStats{9,7}=minval9;
% StormBasicStats{9,8}=maxval9;
% StormBasicStats{9,9}=skew9;
% StormBasicStats{9,10}=kurt9;
% Create a Table from this cell array

% Print out these results to the log file
fprintf(fid,'%s\n','----------- Start Descriptive Statistics Of Second Pass Variables--------');
str1='Variable';
str2='NumPts';
str3='Mean';
str4='Median';
str5='Mode';
str6='Stdev';
str7='Min Val';
str8='Max Val';
str9='Skew';
str10='Kurtosis';
str11='sum';
% fprintf(fid,'%  10s % 10s % 10s % 10s % 10s % 10s % 10s % 10s % 10s % 10s\n',str1,str2,str3,...
%     str4,str5,str6,str7,str8,str9,str10);
fprintf(fid,'% 10s % 13s % 10s % 10s  % 10s',str1,str2,str3,str4,str5);
fprintf(fid,'% 10s % 10s % 10s % 10s %10s  % 10s\n',str6,str7,str8,str9,str10,str11);
str1='TotalPrecip';
fprintf(fid,'% 10s',str1);
fprintf(fid,'% 13i % 10.4f %10.4f %12.4f',numvals,mean1,median1,mode1);
fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f  % 10.4f %10.4f\n',std1,minval1,maxval1,skew1,kurt1,sumvalues1);
str1='Duration-hr';
fprintf(fid,'% 10s',str1);
fprintf(fid,'% 13i % 10.4f %10.4f %12.4f',numvals,mean2,median2,mode2);
fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f  % 10.4f %10.4f\n',std2,minval2,maxval2,skew2,kurt2,sumvalues2);
str1='OverRate';
fprintf(fid,'% 10s',str1);
fprintf(fid,'% 14i % 10.4f %10.4f %12.4f',numvals,mean3,median3,mode3);
fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f % 10.4f %11.4f\n',std3,minval3,maxval3,skew3,kurt3,sumvalues3);
str1='MAXRate5Min';
fprintf(fid,'% 10s',str1);
fprintf(fid,'% 13i % 10.4f %10.4f %12.4f',numvals,mean4,median4,mode4);
fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f % 10.4f %10.4f\n',std4,minval4,maxval4,skew4,kurt4,sumvals4);
str1='MaxRate15Min';
fprintf(fid,'% 10s',str1);
fprintf(fid,'% 12i % 10.4f %10.4f %12.4f',numvals,mean5,median5,mode5);
fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f % 10.4f %10.4f\n',std5,minval5,maxval5,skew5,kurt5,sumvals5);
% str1='MAX-30-mm/hr';
% fprintf(fid,'% 10s',str1);
% fprintf(fid,'% 12i % 10.4f %10.4f %12.4f',numvals,mean6,median6,mode6);
% fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f %10.4f\n',std6,minval6,maxval6,skew6,kurt6);
% str1='MAX-60-mm/hr';
% fprintf(fid,'% 10s',str1);
% fprintf(fid,'% 12i % 10.4f %10.4f %12.4f',numvals,mean7,median7,mode7);
% fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f %10.4f\n',std7,minval7,maxval7,skew7,kurt7);
% str1='Energy-MJ/ha';
% fprintf(fid,'% 10s',str1);
% fprintf(fid,'% 12i % 10.4f %10.4f %12.4f',numvals,mean8,median8,mode8);
% fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f %10.4f\n',std8,minval8,maxval8,skew8,kurt8);
% str1='EI130-MJ*mm/ha-hr';
% fprintf(fid,'% 10s',str1);
% fprintf(fid,'% 7i % 10.4f %10.4f %12.4f',numvals,mean9,median9,mode9);
% fprintf(fid,'% 10.4f % 10.4f %10.4f % 10.4f %10.4f\n',std9,minval9,maxval9,skew9,kurt9);

fprintf(fid,'%s\n','----------- End Descriptive Statistics Of Secondf Pass Variables--------');
ab=1;
end