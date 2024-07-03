% This script will mere a number of DTED files
% This script only runs on R2024a and later
% Written By: Stephen Forczyk
% Created: Jun 8,2024
% Revised: Jun/Jul 2024 add more states
% Classification: Unclassified/Public Domain

global COOPFileName COOPNum Division State County;
global COOPStationName BeginDate EndDate;
global LatDeg LatMin LatSec LonDeg LonMin LonSec Elevation NumDelim;
global LatS LonS COOPStationTable CurrentStation MatFileName;
global StateFIPSCodes NationalCountiesShp AllStateBoundaries StateShapeFile;
global USAStatesShapeFileList USAStatesFileName CountyBoundaryFile S0;
global Alabama AlabamaRB MatFileName;
global Iowa IowaRB Idaho IdahoRB Illinois IllinoisRB Nevada NevadaRB;
global Indiana IndianaRB Florida FloridaRB Kentucky KentuckyRB Maine MaineRB;
global Missouri MissouriRB Minnesota MinnesotaRB Mississippi MississippiRB;
global NorthCarolina NorthCarolinaRB NorthDakota NorthDakotaRB;
global Kansas KansasRB Louisiana LouisianaRB Montana MontanaRB;
global Nebraska NebraskaRB NewMexico NewMexicoRB;

global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue almond beige wheat butterscotch

global datapath matlabpath moviepath tiffpath logfilepath mappath maskpath ristpath;
global tablepath jpegpath govjpegpath dailyfilepath rainfalldatapath csvfilepath excelpath;
global textpath USshapefilepath countyshapepath stateboundarypath statedtedpath;
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
%% Default Values
COOPFileName='Alabama_COOP_Stations.txt';
MatFileName='UnifiedAlabamaDTED.mat';
% Flag values
idecode=0;
iMovie=1;
iCreateMap=1;
iExcel=1;
iRunExcelMacro=0;
iFastSave=1;
iLogo=1;
iMethod=2;
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
Fipsvalue=35;% Fips Code for NewMexico

%% Initialize some arrays to Pre Allocate Memory-this is for section 1
tic;
switch Fipsvalue
    
    case 1 % Alabama
        latlim = [ 30  35]; 
        lonlim = [ -89 -84];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
        MatFileName='UnifiedAlabamaDTED.mat';
        ab=1;
        % Now load these files-Create a combined DTED file for Alabama
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Alabama');
    disp(dispstr)
    [Alabama,AlabamaRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,...
        A13,R13,A14,R14,A15,R15,A16,R16,A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35,A36,R36);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    actionstr='save';
    varstr1='Alabama AlabamaRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Alabama,AlabamaRB)
    geoshow(Alabama,AlabamaRB,DisplayType="surface")
    demcmap(Alabama)
    maxht=max(max(Alabama));
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    case 4  % Arizona
        latlim = [ 31.00  38.0]; 
        lonlim = [ -115 -109];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Connecticut
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");
        elseif(n==49)
            [A49,R49] = readgeoraster(nowFile,OutputType="double");
        elseif(n==50)
            [A50,R50] = readgeoraster(nowFile,OutputType="double");
        elseif(n==51)
            [A51,R51] = readgeoraster(nowFile,OutputType="double");
        elseif(n==52)
            [A52,R52] = readgeoraster(nowFile,OutputType="double");
        elseif(n==53)
            [A53,R53] = readgeoraster(nowFile,OutputType="double");
        elseif(n==54)
            [A54,R54] = readgeoraster(nowFile,OutputType="double");
        elseif(n==55)
            [A55,R55] = readgeoraster(nowFile,OutputType="double");
        elseif(n==56)
            [A56,R56] = readgeoraster(nowFile,OutputType="double");
 
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Azizona');
    disp(dispstr)
    [Arizona,ArizonaRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35,A36,R36,...
        A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,A47,R47,A48,R48,...
        A49,R49,A50,R50,A51,R51,A52,R52,A53,R53,A54,R54,A55,R55,A56,R56);
    %% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedAzizonaDTED.mat';
    actionstr='save';
    varstr1='Arizona ArizonaRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Arizona,ArizonaRB)
    geoshow(Arizona,ArizonaRB,DisplayType="surface")
    demcmap(Arizona)
    maxht=max(max(Arizona));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Arizona2=Arizona;
    Arizona2(Arizona2<0)=NaN;
    demcmap(Arizona2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=3;
    case 5 % Arkansas
        latlim = [ 33  37]; 
        lonlim = [ -95 -89];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
        MatFileName='UnifiedArkansasDTED.mat';
        ab=1;
        % Now load these files-Create a combined DTED file for Tennessee
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Arkansas');
    disp(dispstr)
  
    [Arkansas,ArkansasRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,...
          A13,R13,A14,R14,A15,R15,A16,R16,A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
          A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    actionstr='save';
    varstr1='Arkansas ArkansasRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Arkansas,ArkansasRB)
    geoshow(Arkansas,ArkansasRB,DisplayType="surface")
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
%    demcmap(Arkansas,64,cmapland);
    Arkansas2=Arkansas;
    Arkansas2(Arkansas2<0)=NaN;
    demcmap(Arkansas2,64,cmapland);
    maxht=max(max(Arkansas));
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=1;
    case 8  % Colorado
        latlim = [ 36  42]; 
        lonlim = [ -110 -102];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Colorado
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");        
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");
        elseif(n==49)
            [A49,R49] = readgeoraster(nowFile,OutputType="double");
        elseif(n==50)
            [A50,R50] = readgeoraster(nowFile,OutputType="double");
        elseif(n==51)
            [A51,R51] = readgeoraster(nowFile,OutputType="double");
        elseif(n==52)
            [A52,R52] = readgeoraster(nowFile,OutputType="double");
        elseif(n==53)
            [A53,R53] = readgeoraster(nowFile,OutputType="double");
        elseif(n==54)
            [A54,R54] = readgeoraster(nowFile,OutputType="double");
        elseif(n==55)
            [A55,R55] = readgeoraster(nowFile,OutputType="double");
        elseif(n==56)
            [A56,R56] = readgeoraster(nowFile,OutputType="double");
        elseif(n==57)
            [A57,R57] = readgeoraster(nowFile,OutputType="double");
        elseif(n==58)
            [A58,R58] = readgeoraster(nowFile,OutputType="double");
        elseif(n==59)
            [A59,R59] = readgeoraster(nowFile,OutputType="double");
        elseif(n==60)
            [A60,R60] = readgeoraster(nowFile,OutputType="double");
        elseif(n==61)
            [A61,R61] = readgeoraster(nowFile,OutputType="double");
        elseif(n==62)
            [A62,R62] = readgeoraster(nowFile,OutputType="double");
        elseif(n==63)
            [A63,R63] = readgeoraster(nowFile,OutputType="double");
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Colorado');
    disp(dispstr)
    ab=1;
    [Colorado,ColoradoRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,...
          A13,R13,A14,R14,A15,R15,A16,R16,A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
          A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35,A36,R36,...
          A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,A47,R47,A48,R48,...
          A49,R49,A50,R50,A51,R51,A52,R52,A53,R53,A54,R54,A55,R55,A56,R56,A57,R57,A58,R58,A59,R59,A60,R60,...
          A61,R61,A62,R62,A63,R63);
    case 9  % Connecticut
        latlim = [ 41.00  42.1]; 
        lonlim = [ -73.8 -71.5];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Connecticut
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");

 
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Colorado');
    disp(dispstr)
    ab=1;
    [Connecticut,ConnecticutRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6);
    %% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedConnecticutDTED.mat';
    actionstr='save';
    varstr1='Connecticut ConnecticutRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Connecticut,ConnecticutRB)
    geoshow(Connecticut,ConnecticutRB,DisplayType="surface")
    demcmap(Connecticut)
    maxht=max(max(Connecticut));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Connecticut2=Connecticut;
    Connecticut2(Connecticut2<0)=NaN;
    demcmap(Connecticut2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=3;
    case 12  % Florida Too many missing files
        latlim = [ 26  31]; 
        lonlim = [ -87 -80];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Connecticut
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");
        elseif(n==49)
            [A49,R49] = readgeoraster(nowFile,OutputType="double");
        elseif(n==50)
            [A50,R50] = readgeoraster(nowFile,OutputType="double");
        elseif(n==51)
            [A51,R51] = readgeoraster(nowFile,OutputType="double");
        elseif(n==52)
            [A52,R52] = readgeoraster(nowFile,OutputType="double");
        elseif(n==53)
            [A53,R53] = readgeoraster(nowFile,OutputType="double");
        elseif(n==54)
            [A54,R54] = readgeoraster(nowFile,OutputType="double");
        elseif(n==55)
            [A55,R55] = readgeoraster(nowFile,OutputType="double");
        elseif(n==56)
            [A56,R56] = readgeoraster(nowFile,OutputType="double");
  


        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Florida');
    disp(dispstr)

     [Florida,FloridaRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,...
        A34,R34,A35,R35,A36,R36,A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,...
        A47,R47,A48,R48);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedIndianaDTED.mat';
    actionstr='save';
    varstr1='Indiana IndianaRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Indiana,IndianaRB)
    geoshow(Indiana,IndianaRB,DisplayType="surface")
    demcmap(Indiana)
    maxht=max(max(Indiana));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Indiana2=Indiana;
    Indiana2(Indiana2<0)=NaN;
    demcmap(Indiana2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=3;
    case 13  % Georgia
        latlim = [ 30  35]; 
        lonlim = [ -86 -82];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Georgia
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Colorado');
    disp(dispstr)
    ab=1;
    [Georgia,GeorgiaRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,...
          A13,R13,A14,R14,A15,R15,A16,R16,A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
          A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30);
    ab=2;
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedGeorgiaDTED.mat';
    actionstr='save';
    varstr1='Georgia GeorgiaRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Georgia,GeorgiaRB)
    geoshow(Georgia,GeorgiaRB,DisplayType="surface")
    demcmap(Georgia)
    maxht=max(max(Georgia));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Georgia2=Georgia;
    Georgia2(Georgia2<0)=NaN;
    demcmap(Georgia2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=3;
   case 16  % Idaho
        latlim = [ 42.0  49.0]; 
        lonlim = [ -118 -111];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Connecticut
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");
        elseif(n==49)
            [A49,R49] = readgeoraster(nowFile,OutputType="double");
        elseif(n==50)
            [A50,R50] = readgeoraster(nowFile,OutputType="double");
        elseif(n==51)
            [A51,R51] = readgeoraster(nowFile,OutputType="double");
        elseif(n==52)
            [A52,R52] = readgeoraster(nowFile,OutputType="double");
        elseif(n==53)
            [A53,R53] = readgeoraster(nowFile,OutputType="double");
        elseif(n==54)
            [A54,R54] = readgeoraster(nowFile,OutputType="double");
        elseif(n==55)
            [A55,R55] = readgeoraster(nowFile,OutputType="double");
        elseif(n==56)
            [A56,R56] = readgeoraster(nowFile,OutputType="double");
        elseif(n==57)
            [A57,R57] = readgeoraster(nowFile,OutputType="double");
        elseif(n==58)
            [A58,R58] = readgeoraster(nowFile,OutputType="double");
        elseif(n==59)
            [A59,R59] = readgeoraster(nowFile,OutputType="double");
        elseif(n==60)
            [A60,R60] = readgeoraster(nowFile,OutputType="double");
        elseif(n==61)
            [A61,R61] = readgeoraster(nowFile,OutputType="double");
        elseif(n==62)
            [A62,R62] = readgeoraster(nowFile,OutputType="double");
        elseif(n==63)
            [A63,R63] = readgeoraster(nowFile,OutputType="double");
        elseif(n==64)
            [A64,R64] = readgeoraster(nowFile,OutputType="double");
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Idaho');
    disp(dispstr)
    ab=1;
    [Idaho,IdahoRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,...
        A34,R34,A35,R35,A36,R36,A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,...
        A47,R47,A48,R48,A49,R49,A50,R50,A51,R51,A52,R52,A53,R53,A54,R54,A55,R55,A56,R56,A57,R57,A58,R58,...
        A59,R59,A60,R60,A61,R61,A62,R62,A63,R63,A64,R64);
    %% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedIdahoDTED.mat';
    actionstr='save';
    varstr1='Idaho IdahoRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Idaho,IdahoRB)
    geoshow(Idaho,IdahoRB,DisplayType="surface")
    demcmap(Idaho)
    maxht=max(max(Idaho));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Idaho2=Idaho;
    Idaho2(Idaho2<0)=NaN;
    demcmap(Idaho2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=3;
    case 17  % Illinois
        latlim = [ 36  43]; 
        lonlim = [ -92 -87];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Connecticut
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");

        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Illinois');
    disp(dispstr)

     [Illinois,IllinoisRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,...
        A34,R34,A35,R35,A36,R36,A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,...
        A47,R47,A48,R48);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedIllinoisDTED.mat';
    actionstr='save';
    varstr1='Illinois IllinoisRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Illinois,IllinoisRB)
    geoshow(Illinois,IllinoisRB,DisplayType="surface")
    demcmap(Illinois)
    maxht=max(max(Illinois));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Illinois2=Illinois;
    Illinois2(Illinois2<0)=NaN;
    demcmap(Illinois2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=3;
    case 18  % Indiana
        latlim = [ 36  43]; 
        lonlim = [ -92 -87];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Connecticut
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");

        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Indiana');
    disp(dispstr)

     [Indiana,IndianaRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,...
        A34,R34,A35,R35,A36,R36,A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,...
        A47,R47,A48,R48);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedIndianaDTED.mat';
    actionstr='save';
    varstr1='Indiana IndianaRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Indiana,IndianaRB)
    geoshow(Indiana,IndianaRB,DisplayType="surface")
    demcmap(Indiana)
    maxht=max(max(Indiana));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Indiana2=Indiana;
    Indiana2(Indiana2<0)=NaN;
    demcmap(Indiana2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=3;
    case 19  % Iowa
        latlim = [ 40.0  44.0]; 
        lonlim = [ -97 -90];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Connecticut
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");

 
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Iowa');
    disp(dispstr)
    ab=1;
    [Iowa,IowaRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35,A36,R36,...
        A37,R37,A38,R38,A39,R39,A40,R40);
    %% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedIowaDTED.mat';
    actionstr='save';
    varstr1='Iowa IowaRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Iowa,IowaRB)
    geoshow(Iowa,IowaRB,DisplayType="surface")
    demcmap(Iowa)
    maxht=max(max(Iowa));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Iowa2=Iowa;
    Iowa2(Iowa2<0)=NaN;
    demcmap(Iowa2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=3;
    case 20  % Kansas
        latlim = [ 37  40]; 
        lonlim = [ -102 -94];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Minnesota
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==37)
        %     [A37,R37] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==38)
        %     [A38,R38] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==39)
        %     [A39,R39] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==40)
        %     [A40,R40] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==41)
        %     [A41,R41] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==42)
        %     [A42,R42] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==43)
        %     [A43,R43] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==44)
        %     [A44,R44] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==45)
        %     [A45,R45] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==46)
        %     [A46,R46] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==47)
        %     [A47,R47] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==48)
        %     [A48,R48] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==49)
        %     [A49,R49] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==50)
        %     [A50,R50] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==51)
        %     [A51,R51] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==52)
        %     [A52,R52] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==53)
        %     [A53,R53] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==54)
        %     [A54,R54] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==55)
        %     [A55,R55] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==56)
        %     [A56,R56] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==57)
        %     [A57,R57] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==58)
        %     [A58,R58] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==59)
        %     [A59,R59] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==60)
        %     [A60,R60] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==61)
        %     [A61,R61] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==62)
        %     [A62,R62] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==63)
        %     [A63,R63] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==64)
        %     [A64,R64] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==65)
        %     [A65,R65] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==66)
        %     [A66,R66] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==67)
        %     [A67,R67] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==68)
        %     [A68,R68] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==69)
        %     [A69,R69] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==70)
        %     [A70,R70] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==71)
        %     [A71,R71] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==72)
        %     [A72,R72] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==73)
        %     [A73,R33] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==74)
        %     [A74,R74] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==75)
        %     [A75,R55] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==76)
        %     [A76,R76] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==77)
        %     [A77,R77] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==78)
        %     [A78,R78] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==79)
        %     [A79,R79] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==80)
        %     [A80,R80] = readgeoraster(nowFile,OutputType="double");
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Kansas');
    disp(dispstr)
    ab=1;
    [Kansas,KansasRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,...
        A34,R34,A35,R35,A36,R36);
    %,A37,R37,A38,R38,A39,R39,A40,R40);
    %A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,A47,R47,A48,R48,A49,R49,A50,R50);
    %A51,R51,A52,R52,A53,R53,A54,R54,A55,R55);
    % A56,R56,A57,R57,A58,R58,...
    %     A59,R59,A60,R60);
    %A61,R61,A62,R62,A63,R63,A64,R64,A65,R65,A66,R66,A67,R67,A68,R68,A69,R69,A70,R70,...
    %    A71,R71,A72,R72,A73,R73,A74,R74,A75,R75,A76,R76,A77,R77,A78,R78,A79,R79,A80,R80);
    %% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedKansasDTED.mat';
    actionstr='save';
    varstr1='Kansas KansasRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Kansas,KansasRB)
    geoshow(Kansas,KansasRB,DisplayType="surface")
    demcmap(Kansas)
    maxht=max(max(Kansas));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Kansas2=Kansas;
    Kansas2(Kansas2<0)=NaN;
    demcmap(Kansas2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    title('Kansas DEM PLot');
    ab=3;
    case 21  % Kentucky
        latlim = [ 36  40]; 
        lonlim = [ -90 -81];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Connecticut
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");
        elseif(n==49)
            [A49,R49] = readgeoraster(nowFile,OutputType="double");
        elseif(n==50)
            [A50,R50] = readgeoraster(nowFile,OutputType="double");
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Kentucky');
    disp(dispstr)

     [Kentucky,KentuckyRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,...
        A34,R34,A35,R35,A36,R36,A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,...
        A47,R47,A48,R48,A49,R49,A50,R50);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedKentuckyDTED.mat';
    actionstr='save';
    varstr1='Kentucky KentuckyRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Kentucky,KentuckyRB)
    geoshow(Kentucky,KentuckyRB,DisplayType="surface")
    demcmap(Kentucky)
    maxht=max(max(Kentucky));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Kentucky2=Kentucky;
    Kentucky2(Kentucky2<0)=NaN;
    demcmap(Kentucky2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=3;
    case 22  % Louisiana
        latlim = [ 29  34]; 
        lonlim = [ -93 -88];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Connecticut
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==37)
        %     [A37,R37] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==38)
        %     [A38,R38] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==39)
        %     [A39,R39] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==40)
        %     [A40,R40] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==41)
        %     [A41,R41] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==42)
        %     [A42,R42] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==43)
        %     [A43,R43] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==44)
        %     [A44,R44] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==45)
        %     [A45,R45] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==46)
        %     [A46,R46] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==47)
        %     [A47,R47] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==48)
        %     [A48,R48] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==49)
        %     [A49,R49] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==50)
        %     [A50,R50] = readgeoraster(nowFile,OutputType="double");
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Kentucky');
    disp(dispstr)

     [Louisiana,LouisianaRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,...
        A34,R34,A35,R35,A36,R36);
     %,A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42);
     % A43,R43,A44,R44,A45,R45,A46,R46,...
     %    A47,R47,A48,R48,A49,R49);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedLouisianaDTED.mat';
    actionstr='save';
    varstr1='Louisiana LouisianaRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Louisiana,LouisianaRB)
    geoshow(Louisiana,LouisianaRB,DisplayType="surface")
    demcmap(Louisiana)
    maxht=max(max(Louisiana));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Louisiana2=Louisiana;
    Louisiana2(Louisiana2<0)=NaN;
    demcmap(Louisiana2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    title('Louisiana DEM Map');
    ab=3;
    case 23  % Maine
        latlim = [ 44  48]; 
        lonlim = [ -71 -66];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Connecticut
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==31)
        %     [A31,R31] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==32)
        %     [A32,R32] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==33)
        %     [A33,R33] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==34)
        %     [A34,R34] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==35)
        %     [A35,R35] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==36)
        %     [A36,R36] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==37)
        %     [A37,R37] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==38)
        %     [A38,R38] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==39)
        %     [A39,R39] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==40)
        %     [A40,R40] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==41)
        %     [A41,R41] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==42)
        %     [A42,R42] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==43)
        %     [A43,R43] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==44)
        %     [A44,R44] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==45)
        %     [A45,R45] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==46)
        %     [A46,R46] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==47)
        %     [A47,R47] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==48)
        %     [A48,R48] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==49)
        %     [A49,R49] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==50)
        %     [A50,R50] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==51)
        %     [A51,R51] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==52)
        %     [A52,R52] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==53)
        %     [A53,R53] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==54)
        %     [A54,R54] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==55)
        %     [A55,R55] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==56)
        %     [A56,R56] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==57)
        %     [A57,R57] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==58)
        %     [A58,R58] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==59)
        %     [A59,R59] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==60)
        %     [A60,R60] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==61)
        %     [A61,R61] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==62)
        %     [A62,R62] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==63)
        %     [A63,R63] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==64)
        %     [A64,R64] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==65)
        %     [A65,R65] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==66)
        %     [A66,R66] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==67)
        %     [A67,R67] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==68)
        %     [A68,R68] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==69)
        %     [A69,R69] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==70)
        %     [A70,R70] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==71)
        %     [A71,R71] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==72)
        %     [A72,R72] = readgeoraster(nowFile,OutputType="double");


        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Kentucky');
    disp(dispstr)

     [Maine,MainRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30);
        % ,A31,R31,A32,R32,A33,R33,...
        % A34,R34,A35,R35,A36,R36);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedMaineDTED.mat';
    actionstr='save';
    varstr1='Maine MaineRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Maine,MaineRB)
    geoshow(Maine,MaineRB,DisplayType="surface")
    demcmap(Maine)
    maxht=max(max(Maine));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Maine2=Maine;
    Maine2(Maine2<0)=NaN;
    demcmap(Maine2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=3;
    case 25 % Massachusetts
        latlim = [ 41  43]; 
        lonlim = [ -74 -70];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
        MatFileName='UnifiedWestMassachusettsDTED.mat';
        ab=1;
        % Now load these files-Create a combined DTED file for Massacusetts
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for WesternMass');
    disp(dispstr)
    [WMassachusetts,WMassachusettsRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    actionstr='save';
    varstr1='WMassachusetts WMassachusettsRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Massachusetts,MassachusettsRB)
    geoshow(Massachusetts,MassachusettsRB,DisplayType="surface")
    demcmap(WMassacusetts);
    maxht=max(max(WMassachusetts));
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=1;
    case 27  % Minnesota
        latlim = [ 43  48]; 
        lonlim = [ -98 -89];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Minnesota
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");
        elseif(n==49)
            [A49,R49] = readgeoraster(nowFile,OutputType="double");
        elseif(n==50)
            [A50,R50] = readgeoraster(nowFile,OutputType="double");
        elseif(n==51)
            [A51,R51] = readgeoraster(nowFile,OutputType="double");
        elseif(n==52)
            [A52,R52] = readgeoraster(nowFile,OutputType="double");
        elseif(n==53)
            [A53,R53] = readgeoraster(nowFile,OutputType="double");
        elseif(n==54)
            [A54,R54] = readgeoraster(nowFile,OutputType="double");
        elseif(n==55)
            [A55,R55] = readgeoraster(nowFile,OutputType="double");
        elseif(n==56)
            [A56,R56] = readgeoraster(nowFile,OutputType="double");
        elseif(n==57)
            [A57,R57] = readgeoraster(nowFile,OutputType="double");
        elseif(n==58)
            [A58,R58] = readgeoraster(nowFile,OutputType="double");
        elseif(n==59)
            [A59,R59] = readgeoraster(nowFile,OutputType="double");
        elseif(n==60)
            [A60,R60] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==61)
        %     [A61,R61] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==62)
        %     [A62,R62] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==63)
        %     [A63,R63] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==64)
        %     [A64,R64] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==65)
        %     [A65,R65] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==66)
        %     [A66,R66] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==67)
        %     [A67,R67] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==68)
        %     [A68,R68] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==69)
        %     [A69,R69] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==70)
        %     [A70,R70] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==71)
        %     [A71,R71] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==72)
        %     [A72,R72] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==73)
        %     [A73,R33] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==74)
        %     [A74,R74] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==75)
        %     [A75,R55] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==76)
        %     [A76,R76] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==77)
        %     [A77,R77] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==78)
        %     [A78,R78] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==79)
        %     [A79,R79] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==80)
        %     [A80,R80] = readgeoraster(nowFile,OutputType="double");
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Minnesota');
    disp(dispstr)
    ab=1;
    [Minnesota,MinnesotaRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,...
        A34,R34,A35,R35,A36,R36,A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,...
        A47,R47,A48,R48,A49,R49,A50,R50,A51,R51,A52,R52,A53,R53,A54,R54,A55,R55,A56,R56,A57,R57,A58,R58,...
        A59,R59,A60,R60);
    %A61,R61,A62,R62,A63,R63,A64,R64,A65,R65,A66,R66,A67,R67,A68,R68,A69,R69,A70,R70,...
    %    A71,R71,A72,R72,A73,R73,A74,R74,A75,R75,A76,R76,A77,R77,A78,R78,A79,R79,A80,R80);
    %% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedMinnesotaDTED.mat';
    actionstr='save';
    varstr1='Minnesota MinnesotaRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Minnesota,MinnesotaRB)
    geoshow(Minnesota,MinnesotaRB,DisplayType="surface")
    demcmap(Minnesota)
    maxht=max(max(Minnesota));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Minnesota2=Minnesota;
    Minnesota2(Minnesota2<0)=NaN;
    demcmap(Minnesota2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    title('Minnesota DEM PLot');
    ab=3;
    case 28  % Mississippi
        latlim = [ 30  35]; 
        lonlim = [ -92 -88];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Missouri
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==31)
        %     [A31,R31] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==32)
        %     [A32,R32] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==33)
        %     [A33,R33] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==34)
        %     [A34,R34] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==35)
        %     [A35,R35] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==36)
        %     [A36,R36] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==37)
        %     [A37,R37] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==38)
        %     [A38,R38] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==39)
        %     [A39,R39] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==40)
        %     [A40,R40] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==41)
        %     [A41,R41] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==42)
        %     [A42,R42] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==43)
        %     [A43,R43] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==44)
        %     [A44,R44] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==45)
        %     [A45,R45] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==46)
        %     [A46,R46] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==47)
        %     [A47,R47] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==48)
        %     [A48,R48] = readgeoraster(nowFile,OutputType="double");

        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Mississippi');
    disp(dispstr)

 [Mississippi,MississippiRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
    A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
    A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
    A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30);
 % A31,R31,A32,R32,A33,R33,...
 %    A34,R34,A35,R35,A36,R36,A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,...
 %    A47,R47,A48,R48);
    %% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedMississippiDTED.mat';
    actionstr='save';
    varstr1='Mississippi MississippiRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Mississippi,MississippiRB)
    geoshow(Mississippi,MississippiRB,DisplayType="surface")
    demcmap(Mississippi)
    maxht=max(max(Mississippi));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Mississippi2=Mississippi;
    Mississippi2(Mississippi2<0)=NaN;
    demcmap(Mississippi2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    title('Mississippi DEM Map');
    ab=3;
    case 29  % Missouri
        latlim = [ 36  41]; 
        lonlim = [ -96 -89];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Missouri
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");

        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Missouri');
    disp(dispstr)

 [Missouri,MissouriRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
    A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
    A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
    A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,...
    A34,R34,A35,R35,A36,R36,A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,...
    A47,R47,A48,R48);
    %% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedMissouriDTED.mat';
    actionstr='save';
    varstr1='Missouri MissouriRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Missouri,MissouriRB)
    geoshow(Missouri,MissouriRB,DisplayType="surface")
    demcmap(Missouri)
    maxht=max(max(Missouri));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Missouri2=Missouri;
    Missouri2(Missouri2<0)=NaN;
    demcmap(Missouri2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=3;
    case 30  % Montana
        latlim = [ 44  49]; 
        lonlim = [ -117 -104];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Connecticut
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");
        elseif(n==49)
            [A49,R49] = readgeoraster(nowFile,OutputType="double");
        elseif(n==50)
            [A50,R50] = readgeoraster(nowFile,OutputType="double");
        elseif(n==51)
            [A51,R51] = readgeoraster(nowFile,OutputType="double");
        elseif(n==52)
            [A52,R52] = readgeoraster(nowFile,OutputType="double");
        elseif(n==53)
            [A53,R53] = readgeoraster(nowFile,OutputType="double");
        elseif(n==54)
            [A54,R54] = readgeoraster(nowFile,OutputType="double");
        elseif(n==55)
            [A55,R55] = readgeoraster(nowFile,OutputType="double");
        elseif(n==56)
            [A56,R56] = readgeoraster(nowFile,OutputType="double");
        elseif(n==57)
            [A57,R57] = readgeoraster(nowFile,OutputType="double");
        elseif(n==58)
            [A58,R58] = readgeoraster(nowFile,OutputType="double");
        elseif(n==59)
            [A59,R59] = readgeoraster(nowFile,OutputType="double");
        elseif(n==60)
            [A60,R60] = readgeoraster(nowFile,OutputType="double");
        elseif(n==61)
            [A61,R61] = readgeoraster(nowFile,OutputType="double");
        elseif(n==62)
            [A62,R62] = readgeoraster(nowFile,OutputType="double");
        elseif(n==63)
            [A63,R63] = readgeoraster(nowFile,OutputType="double");
        elseif(n==64)
            [A64,R64] = readgeoraster(nowFile,OutputType="double");
        elseif(n==65)
            [A65,R65] = readgeoraster(nowFile,OutputType="double");
        elseif(n==66)
            [A66,R66] = readgeoraster(nowFile,OutputType="double");
        elseif(n==67)
            [A67,R67] = readgeoraster(nowFile,OutputType="double");
        elseif(n==68)
            [A68,R68] = readgeoraster(nowFile,OutputType="double");
        elseif(n==69)
            [A69,R69] = readgeoraster(nowFile,OutputType="double");
        elseif(n==70)
            [A70,R70] = readgeoraster(nowFile,OutputType="double");
        elseif(n==71)
            [A71,R71] = readgeoraster(nowFile,OutputType="double");
        elseif(n==72)
            [A72,R72] = readgeoraster(nowFile,OutputType="double");
        elseif(n==73)
            [A73,R73] = readgeoraster(nowFile,OutputType="double");
        elseif(n==74)
            [A74,R74] = readgeoraster(nowFile,OutputType="double");
        elseif(n==75)
            [A75,R75] = readgeoraster(nowFile,OutputType="double");
        elseif(n==76)
            [A76,R76] = readgeoraster(nowFile,OutputType="double");
        elseif(n==77)
            [A77,R77] = readgeoraster(nowFile,OutputType="double");
        elseif(n==78)
            [A78,R78] = readgeoraster(nowFile,OutputType="double");
        elseif(n==79)
            [A79,R79] = readgeoraster(nowFile,OutputType="double");
        elseif(n==80)
            [A80,R80] = readgeoraster(nowFile,OutputType="double");
        elseif(n==81)
            [A81,R81] = readgeoraster(nowFile,OutputType="double");
        elseif(n==82)
            [A82,R82] = readgeoraster(nowFile,OutputType="double");
        elseif(n==83)
            [A83,R83] = readgeoraster(nowFile,OutputType="double");
        elseif(n==84)
            [A84,R84] = readgeoraster(nowFile,OutputType="double");
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Montana');
    disp(dispstr)

     [Montana,MontanaRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35,A36,R36,...
        A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,...
        A47,R47,A48,R48,A49,R49,A50,R50,A51,R51,A52,R52,A53,R53,A54,R54,A55,R55,A56,R56,...
        A57,R57,A58,R58,A59,R59,A60,R60,A61,R61,A62,R62,A63,R63,A64,R64,A65,R65,A66,R66,...
        A67,R67,A68,R68,A69,R69,A70,R70,A71,R71,A72,R72,A73,R73,A74,R74,A75,R75,A76,R76,...
        A77,R77,A78,R78,A79,R79,A80,R80,A81,R81,A82,R82,A83,R83,A84,R84);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedMontanaDTED.mat';
    actionstr='save';
    varstr1='Montana MontanaRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Montana,MontanaRB)
    geoshow(Montana,MontanaRB,DisplayType="surface")
    demcmap(Montana)
    maxht=max(max(Montana));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Montana2=Montana;
    Montana2(Montana2<0)=NaN;
    demcmap(Montana2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    title('Montana DEM Map')
    ab=3;
  case 31  % Nebraska
        latlim = [ 40  43]; 
        lonlim = [ -104 -95];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Connecticut
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==41)
        %     [A41,R41] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==42)
        %     [A42,R42] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==43)
        %     [A43,R43] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==44)
        %     [A44,R44] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==45)
        %     [A45,R45] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==46)
        %     [A46,R46] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==47)
        %     [A47,R47] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==48)
        %     [A48,R48] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==49)
        %     [A49,R49] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==50)
        %     [A50,R50] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==51)
        %     [A51,R51] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==52)
        %     [A52,R52] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==53)
        %     [A53,R53] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==54)
        %     [A54,R54] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==55)
        %     [A55,R55] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==56)
        %     [A56,R56] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==57)
        %     [A57,R57] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==58)
        %     [A58,R58] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==59)
        %     [A59,R59] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==60)
        %     [A60,R60] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==61)
        %     [A61,R61] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==62)
        %     [A62,R62] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==63)
        %     [A63,R63] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==64)
        %     [A64,R64] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==65)
        %     [A65,R65] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==66)
        %     [A66,R66] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==67)
        %     [A67,R67] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==68)
        %     [A68,R68] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==69)
        %     [A69,R69] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==70)
        %     [A70,R70] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==71)
        %     [A71,R71] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==72)
        %     [A72,R72] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==73)
        %     [A73,R73] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==74)
        %     [A74,R74] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==75)
        %     [A75,R75] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==76)
        %     [A76,R76] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==77)
        %     [A77,R77] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==78)
        %     [A78,R78] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==79)
        %     [A79,R79] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==80)
        %     [A80,R80] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==81)
        %     [A81,R81] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==82)
        %     [A82,R82] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==83)
        %     [A83,R83] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==84)
        %     [A84,R84] = readgeoraster(nowFile,OutputType="double");
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Nebraska');
    disp(dispstr)

     [Nebraska,NebraskaRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35,A36,R36,...
        A37,R37,A38,R38,A39,R39,A40,R40);
     % A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,...
     %    A47,R47,A48,R48,A49,R49,A50,R50,A51,R51,A52,R52,A53,R53,A54,R54,A55,R55,A56,R56,...
     %    A57,R57,A58,R58,A59,R59,A60,R60,A61,R61,A62,R62,A63,R63,A64,R64,A65,R65,A66,R66,...
     %    A67,R67,A68,R68,A69,R69,A70,R70,A71,R71,A72,R72,A73,R73,A74,R74,A75,R75,A76,R76,...
     %    A77,R77,A78,R78,A79,R79,A80,R80,A81,R81,A82,R82,A83,R83,A84,R84);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedNebraskaDTED.mat';
    actionstr='save';
    varstr1='Nebraska NebraskaRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Nebraska,NebraskaRB)
    geoshow(Nebraska,NebraskaRB,DisplayType="surface")
    demcmap(Nebraska)
    maxht=max(max(Nebraska));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Nebraska2=Nebraska;
    Nebraska2(Nebraska2<0)=NaN;
    demcmap(Nebraska2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    title('Nebraska DEM Map')
    ab=3;
  case 32  % Nevada
        latlim = [ 35  42]; 
        lonlim = [ -120 -114];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Connecticut
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");
        elseif(n==49)
            [A49,R49] = readgeoraster(nowFile,OutputType="double");
        elseif(n==50)
            [A50,R50] = readgeoraster(nowFile,OutputType="double");
        elseif(n==51)
            [A51,R51] = readgeoraster(nowFile,OutputType="double");
        elseif(n==52)
            [A52,R52] = readgeoraster(nowFile,OutputType="double");
        elseif(n==53)
            [A53,R53] = readgeoraster(nowFile,OutputType="double");
        elseif(n==54)
            [A54,R54] = readgeoraster(nowFile,OutputType="double");
        elseif(n==55)
            [A55,R55] = readgeoraster(nowFile,OutputType="double");
        elseif(n==56)
            [A56,R56] = readgeoraster(nowFile,OutputType="double");
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Nevada');
    disp(dispstr)

 [Nevada,NevadaRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
    A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
    A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
    A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,...
    A34,R34,A35,R35,A36,R36,A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,...
    A47,R47,A48,R48,A49,R49,A50,R50,A51,R51,A52,R52,A53,R53,A54,R54,A55,R55,A56,R56);
    %% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedNevadaDTED.mat';
    actionstr='save';
    varstr1='Nevada NevadaRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Nevada,NevadaRB)
    geoshow(Nevada,NevadaRB,DisplayType="surface")
    demcmap(Nevada)
    maxht=max(max(Nevada));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Nevada2=Nevada;
    Nevada2(Nevada2<0)=NaN;
    demcmap(Nevada2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=3;
    case 35  % New Mexico
        latlim = [ 31  37]; 
        lonlim = [ -109 -103];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Connecticut
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");
        elseif(n==49)
            [A49,R49] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==50)
        %     [A50,R50] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==51)
        %     [A51,R51] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==52)
        %     [A52,R52] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==53)
        %     [A53,R53] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==54)
        %     [A54,R54] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==55)
        %     [A55,R55] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==56)
        %     [A56,R56] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==57)
        %     [A57,R57] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==58)
        %     [A58,R58] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==59)
        %     [A59,R59] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==60)
        %     [A60,R60] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==61)
        %     [A61,R61] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==62)
        %     [A62,R62] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==63)
        %     [A63,R63] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==64)
        %     [A64,R64] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==65)
        %     [A65,R65] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==66)
        %     [A66,R66] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==67)
        %     [A67,R67] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==68)
        %     [A68,R68] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==69)
        %     [A69,R69] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==70)
        %     [A70,R70] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==71)
        %     [A71,R71] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==72)
        %     [A72,R72] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==73)
        %     [A73,R73] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==74)
        %     [A74,R74] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==75)
        %     [A75,R75] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==76)
        %     [A76,R76] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==77)
        %     [A77,R77] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==78)
        %     [A78,R78] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==79)
        %     [A79,R79] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==80)
        %     [A80,R80] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==81)
        %     [A81,R81] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==82)
        %     [A82,R82] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==83)
        %     [A83,R83] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==84)
        %     [A84,R84] = readgeoraster(nowFile,OutputType="double");
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for New Mexico');
    disp(dispstr)

     [NewMexico,NewMexicoRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35,A36,R36,...
        A37,R37,A38,R38,A39,R39,A40,R40,...
        A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,A47,R47,A48,R48,A49,R49);
        % A50,R50,A51,R51,A52,R52,A53,R53,A54,R54,A55,R55,A56,R56,...
        % A57,R57,A58,R58,A59,R59,A60,R60,A61,R61,A62,R62,A63,R63,A64,R64,A65,R65,A66,R66,...
        % A67,R67,A68,R68,A69,R69,A70,R70);
     % A71,R71,A72,R72,A73,R73,A74,R74,A75,R75,A76,R76,...
     %    A77,R77,A78,R78,A79,R79,A80,R80,A81,R81,A82,R82,A83,R83,A84,R84);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedNewMexicoDTED.mat';
    actionstr='save';
    varstr1='NewMexico NewMexicoRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(NewMexico,NewMexicoRB)
    geoshow(NewMexico,NewMexicoRB,DisplayType="surface")
%    demcmap(NewMexico)
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    NewMexico2=NewMexico;
    NewMexico2(NewMexico2<0)=NaN;
    demcmap(NewMexico2,64,cmapland);
    maxht=max(max(NewMexico));
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    title('New Mexico DEM Map')
    ab=3;
    case 37  % NorthCarolina
        latlim = [ 33  37]; 
        lonlim = [ -85 -78];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Minnesota
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==41)
        %     [A41,R41] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==42)
        %     [A42,R42] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==43)
        %     [A43,R43] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==44)
        %     [A44,R44] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==45)
        %     [A45,R45] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==46)
        %     [A46,R46] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==47)
        %     [A47,R47] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==48)
        %     [A48,R48] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==49)
        %     [A49,R49] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==50)
        %     [A50,R50] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==51)
        %     [A51,R51] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==52)
        %     [A52,R52] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==53)
        %     [A53,R53] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==54)
        %     [A54,R54] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==55)
        %     [A55,R55] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==56)
        %     [A56,R56] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==57)
        %     [A57,R57] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==58)
        %     [A58,R58] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==59)
        %     [A59,R59] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==60)
        %     [A60,R60] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==61)
        %     [A61,R61] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==62)
        %     [A62,R62] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==63)
        %     [A63,R63] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==64)
        %     [A64,R64] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==65)
        %     [A65,R65] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==66)
        %     [A66,R66] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==67)
        %     [A67,R67] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==68)
        %     [A68,R68] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==69)
        %     [A69,R69] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==70)
        %     [A70,R70] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==71)
        %     [A71,R71] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==72)
        %     [A72,R72] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==73)
        %     [A73,R33] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==74)
        %     [A74,R74] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==75)
        %     [A75,R55] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==76)
        %     [A76,R76] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==77)
        %     [A77,R77] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==78)
        %     [A78,R78] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==79)
        %     [A79,R79] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==80)
        %     [A80,R80] = readgeoraster(nowFile,OutputType="double");
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for NorthCarolina');
    disp(dispstr)
    ab=1;
    [NorthCarolina,NorthCarolinaRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,...
        A34,R34,A35,R35,A36,R36,A37,R37,A38,R38,A39,R39,A40,R40);
    %,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45);
    %,A46,R46,A47,R47,A48,R48,A49,R49,A50,R50);
    %A51,R51,A52,R52,A53,R53,A54,R54,A55,R55);
    % A56,R56,A57,R57,A58,R58,...
    %     A59,R59,A60,R60);
    %A61,R61,A62,R62,A63,R63,A64,R64,A65,R65,A66,R66,A67,R67,A68,R68,A69,R69,A70,R70,...
    %    A71,R71,A72,R72,A73,R73,A74,R74,A75,R75,A76,R76,A77,R77,A78,R78,A79,R79,A80,R80);
    %% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedNorthCarolinaDTED.mat';
    actionstr='save';
    varstr1='NorthCarolina NorthCarolinaRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(NorthCarolina,NorthCarolinaRB)
    geoshow(NorthCarolina,NorthCarolinaRB,DisplayType="surface")
    demcmap(NorthCarolina)
    maxht=max(max(NorthCarolina));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    NorthCarolina2=NorthCarolina;
    NorthCarolina2(NorthCarolina2<0)=NaN;
    demcmap(NorthCarolina2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    title('North Carolina DEM PLot');
    ab=3;
    case 38  % NorthDakota
        latlim = [ 45  48]; 
        lonlim = [ -105 -96];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
 % Now load these files-Create a combined DTED file for Minnesota
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==41)
        %     [A41,R41] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==42)
        %     [A42,R42] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==43)
        %     [A43,R43] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==44)
        %     [A44,R44] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==45)
        %     [A45,R45] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==46)
        %     [A46,R46] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==47)
        %     [A47,R47] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==48)
        %     [A48,R48] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==49)
        %     [A49,R49] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==50)
        %     [A50,R50] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==51)
        %     [A51,R51] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==52)
        %     [A52,R52] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==53)
        %     [A53,R53] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==54)
        %     [A54,R54] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==55)
        %     [A55,R55] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==56)
        %     [A56,R56] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==57)
        %     [A57,R57] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==58)
        %     [A58,R58] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==59)
        %     [A59,R59] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==60)
        %     [A60,R60] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==61)
        %     [A61,R61] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==62)
        %     [A62,R62] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==63)
        %     [A63,R63] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==64)
        %     [A64,R64] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==65)
        %     [A65,R65] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==66)
        %     [A66,R66] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==67)
        %     [A67,R67] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==68)
        %     [A68,R68] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==69)
        %     [A69,R69] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==70)
        %     [A70,R70] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==71)
        %     [A71,R71] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==72)
        %     [A72,R72] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==73)
        %     [A73,R33] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==74)
        %     [A74,R74] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==75)
        %     [A75,R55] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==76)
        %     [A76,R76] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==77)
        %     [A77,R77] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==78)
        %     [A78,R78] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==79)
        %     [A79,R79] = readgeoraster(nowFile,OutputType="double");
        % elseif(n==80)
        %     [A80,R80] = readgeoraster(nowFile,OutputType="double");
        else
            disp('skipped this file')
        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for NorthDakota');
    disp(dispstr)
    ab=1;
    [NorthDakota,NorthDakotaRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
        A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14,A15,R15,A16,R16,...
        A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
        A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,...
        A34,R34,A35,R35,A36,R36,A37,R37,A38,R38,A39,R39,A40,R40);
    %A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,A47,R47,A48,R48,A49,R49,A50,R50);
    %A51,R51,A52,R52,A53,R53,A54,R54,A55,R55);
    % A56,R56,A57,R57,A58,R58,...
    %     A59,R59,A60,R60);
    %A61,R61,A62,R62,A63,R63,A64,R64,A65,R65,A66,R66,A67,R67,A68,R68,A69,R69,A70,R70,...
    %    A71,R71,A72,R72,A73,R73,A74,R74,A75,R75,A76,R76,A77,R77,A78,R78,A79,R79,A80,R80);
    %% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    MatFileName='UnifiedNorthDakotaDTED.mat';
    actionstr='save';
    varstr1='NorthDakota NorthDakotaRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(NorthDakota,NorthDakotaRB)
    geoshow(NorthDakota,NorthDakotaRB,DisplayType="surface")
    demcmap(NorthDakota)
    maxht=max(max(NorthDakota));
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    NorthDakota2=NorthDakota;
    NorthDakota2(NorthDakota2<0)=NaN;
    demcmap(NorthDakota2,64,cmapland);
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    title('North Dakota DEM PLot');
    ab=3;
    case 41 % Oregon
        latlim = [ 41  47]; 
        lonlim = [ -125 -116];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
        MatFileName='UnifiedOregonDTED.mat';
        ab=1;
        % Now load these files-Create a combined DTED file for Tennessee
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");
        elseif(n==49)
            [A49,R49] = readgeoraster(nowFile,OutputType="double");
        elseif(n==50)
            [A50,R50] = readgeoraster(nowFile,OutputType="double");
        elseif(n==51)
            [A51,R51] = readgeoraster(nowFile,OutputType="double");
        elseif(n==52)
            [A52,R52] = readgeoraster(nowFile,OutputType="double");
        elseif(n==53)
            [A53,R53] = readgeoraster(nowFile,OutputType="double");
        elseif(n==54)
            [A54,R54] = readgeoraster(nowFile,OutputType="double");
        elseif(n==55)
            [A55,R55] = readgeoraster(nowFile,OutputType="double");
        elseif(n==56)
            [A56,R56] = readgeoraster(nowFile,OutputType="double");
        elseif(n==57)
            [A57,R57] = readgeoraster(nowFile,OutputType="double");
        elseif(n==58)
            [A58,R58] = readgeoraster(nowFile,OutputType="double");
        elseif(n==59)
            [A59,R59] = readgeoraster(nowFile,OutputType="double");
        elseif(n==60)
            [A60,R60] = readgeoraster(nowFile,OutputType="double");
        elseif(n==61)
            [A61,R61] = readgeoraster(nowFile,OutputType="double");
        elseif(n==62)
            [A62,R62] = readgeoraster(nowFile,OutputType="double");
        elseif(n==63)
            [A63,R63] = readgeoraster(nowFile,OutputType="double");
        elseif(n==64)
            [A64,R64] = readgeoraster(nowFile,OutputType="double");
        elseif(n==65)
            [A65,R65] = readgeoraster(nowFile,OutputType="double");
        elseif(n==66)
            [A66,R66] = readgeoraster(nowFile,OutputType="double");
        elseif(n==67)
            [A67,R67] = readgeoraster(nowFile,OutputType="double");
        elseif(n==68)
            [A68,R68] = readgeoraster(nowFile,OutputType="double");
        elseif(n==69)
            [A69,R69] = readgeoraster(nowFile,OutputType="double");
        elseif(n==70)
            [A70,R70] = readgeoraster(nowFile,OutputType="double");

        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Oregon');
    disp(dispstr)
  
    [Oregon,OregonRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,...
          A13,R13,A14,R14,A15,R15,A16,R16,A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
          A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35,A36,R36,...
          A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,A47,R47,A48,R48,...
          A49,R49,A50,R50,A51,R51,A52,R52,A53,R53,A54,R54,A55,R55,A56,R56,A57,R57,A58,R58,A59,R59,A60,R60,...
          A61,R61,A62,R62,A63,R63,A64,R64,A65,R65,A66,R66,A67,R67,A68,R68,A69,R69,A70,R70);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    actionstr='save';
    varstr1='Oregon OregonRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Oregon,OregonRB)
    geoshow(Oregon,OregonRB,DisplayType="surface")
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Oregon2=Oregon;
    Oregon2(Oregon2<0)=NaN;
    demcmap(Oregon2,64,cmapland);
    demcmap(Oregon);
    maxht=max(max(Oregon));
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=1;
    case 47 % Tennessee
        latlim = [ 34  37]; 
        lonlim = [ -91 -81];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
        MatFileName='UnifiedTenesseeDTED.mat';
        ab=1;
        % Now load these files-Create a combined DTED file for Tennessee
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");


        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Tenessee');
    disp(dispstr)
  
    [Tennessee,TennesseeRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,...
          A13,R13,A14,R14,A15,R15,A16,R16,A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
          A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35,A36,R36,...
          A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    actionstr='save';
    varstr1='Tennessee TennesseeRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Tennessee,TennesseeRB)
    geoshow(Tennessee,TennesseeRB,DisplayType="surface")
    demcmap(Tennessee);
    maxht=max(max(Tennessee));
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=1;
    case 53 % Washington
        latlim = [ 45  50]; 
        lonlim = [ -125 -116];
        DTEDFiles=dteds(latlim,lonlim,1);
        numDTEDFiles=length(DTEDFiles);
        MatFileName='UnifiedWashingtonDTED.mat';
        ab=1;
        % Now load these files-Create a combined DTED file for Tennessee
    for n=1:numDTEDFiles
        nowFile=char(DTEDFiles{n,1});
        if(n==1)
            [A1,R1] = readgeoraster(nowFile,OutputType="double");
        elseif(n==2)
            [A2,R2] = readgeoraster(nowFile,OutputType="double");
        elseif(n==3)
            [A3,R3] = readgeoraster(nowFile,OutputType="double");
        elseif(n==4)
            [A4,R4] = readgeoraster(nowFile,OutputType="double");
        elseif(n==5)
            [A5,R5] = readgeoraster(nowFile,OutputType="double");
        elseif(n==6)
            [A6,R6] = readgeoraster(nowFile,OutputType="double");
        elseif(n==7)
            [A7,R7] = readgeoraster(nowFile,OutputType="double");
        elseif(n==8)
            [A8,R8] = readgeoraster(nowFile,OutputType="double");
        elseif(n==9)
            [A9,R9] = readgeoraster(nowFile,OutputType="double");
        elseif(n==10)
            [A10,R10] = readgeoraster(nowFile,OutputType="double");
        elseif(n==11)
            [A11,R11] = readgeoraster(nowFile,OutputType="double");
        elseif(n==12)
            [A12,R12] = readgeoraster(nowFile,OutputType="double");
        elseif(n==13)
            [A13,R13] = readgeoraster(nowFile,OutputType="double");
        elseif(n==14)
            [A14,R14] = readgeoraster(nowFile,OutputType="double");
        elseif(n==15)
            [A15,R15] = readgeoraster(nowFile,OutputType="double");
        elseif(n==16)
            [A16,R16] = readgeoraster(nowFile,OutputType="double");
        elseif(n==17)
            [A17,R17] = readgeoraster(nowFile,OutputType="double");
        elseif(n==18)
            [A18,R18] = readgeoraster(nowFile,OutputType="double");
        elseif(n==19)
            [A19,R19] = readgeoraster(nowFile,OutputType="double");
        elseif(n==20)
            [A20,R20] = readgeoraster(nowFile,OutputType="double");
        elseif(n==21)
            [A21,R21] = readgeoraster(nowFile,OutputType="double");
        elseif(n==22)
            [A22,R22] = readgeoraster(nowFile,OutputType="double");
        elseif(n==23)
            [A23,R23] = readgeoraster(nowFile,OutputType="double");
        elseif(n==24)
            [A24,R24] = readgeoraster(nowFile,OutputType="double");
        elseif(n==25)
            [A25,R25] = readgeoraster(nowFile,OutputType="double");
        elseif(n==26)
            [A26,R26] = readgeoraster(nowFile,OutputType="double");
        elseif(n==27)
            [A27,R27] = readgeoraster(nowFile,OutputType="double");
        elseif(n==28)
            [A28,R28] = readgeoraster(nowFile,OutputType="double");
        elseif(n==29)
            [A29,R29] = readgeoraster(nowFile,OutputType="double");
        elseif(n==30)
            [A30,R30] = readgeoraster(nowFile,OutputType="double");
        elseif(n==31)
            [A31,R31] = readgeoraster(nowFile,OutputType="double");
        elseif(n==32)
            [A32,R32] = readgeoraster(nowFile,OutputType="double");
        elseif(n==33)
            [A33,R33] = readgeoraster(nowFile,OutputType="double");
        elseif(n==34)
            [A34,R34] = readgeoraster(nowFile,OutputType="double");
        elseif(n==35)
            [A35,R35] = readgeoraster(nowFile,OutputType="double");
        elseif(n==36)
            [A36,R36] = readgeoraster(nowFile,OutputType="double");
        elseif(n==37)
            [A37,R37] = readgeoraster(nowFile,OutputType="double");
        elseif(n==38)
            [A38,R38] = readgeoraster(nowFile,OutputType="double");
        elseif(n==39)
            [A39,R39] = readgeoraster(nowFile,OutputType="double");
        elseif(n==40)
            [A40,R40] = readgeoraster(nowFile,OutputType="double");
        elseif(n==41)
            [A41,R41] = readgeoraster(nowFile,OutputType="double");
        elseif(n==42)
            [A42,R42] = readgeoraster(nowFile,OutputType="double");
        elseif(n==43)
            [A43,R43] = readgeoraster(nowFile,OutputType="double");
        elseif(n==44)
            [A44,R44] = readgeoraster(nowFile,OutputType="double");
        elseif(n==45)
            [A45,R45] = readgeoraster(nowFile,OutputType="double");
        elseif(n==46)
            [A46,R46] = readgeoraster(nowFile,OutputType="double");
        elseif(n==47)
            [A47,R47] = readgeoraster(nowFile,OutputType="double");
        elseif(n==48)
            [A48,R48] = readgeoraster(nowFile,OutputType="double");
        elseif(n==49)
            [A49,R49] = readgeoraster(nowFile,OutputType="double");
        elseif(n==50)
            [A50,R50] = readgeoraster(nowFile,OutputType="double");
        elseif(n==51)
            [A51,R51] = readgeoraster(nowFile,OutputType="double");
        elseif(n==52)
            [A52,R52] = readgeoraster(nowFile,OutputType="double");
        elseif(n==53)
            [A53,R53] = readgeoraster(nowFile,OutputType="double");
        elseif(n==54)
            [A54,R54] = readgeoraster(nowFile,OutputType="double");
        elseif(n==55)
            [A55,R55] = readgeoraster(nowFile,OutputType="double");
        elseif(n==56)
            [A56,R56] = readgeoraster(nowFile,OutputType="double");
        elseif(n==57)
            [A57,R57] = readgeoraster(nowFile,OutputType="double");
        elseif(n==58)
            [A58,R58] = readgeoraster(nowFile,OutputType="double");
        elseif(n==59)
            [A59,R59] = readgeoraster(nowFile,OutputType="double");
        elseif(n==60)
            [A60,R60] = readgeoraster(nowFile,OutputType="double");

        end
        dispstr=strcat('Read in file-',nowFile,'-which file#',num2str(n),'-of-',num2str(numDTEDFiles));
        disp(dispstr)
        ab=2;
    end
    dispstr=strcat('finished reading-',num2str(numDTEDFiles),'-DTED files for Oregon');
    disp(dispstr)
      [Washington,WashingtonRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,...
         A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,A13,R13,A14,R14);
    % [Washington,WashingtonRB] = mergetiles(A1,R1,A2,R2,A3,R3,A4,R4,A5,R5,A6,R6,A7,R7,A8,R8,A9,R9,A10,R10,A11,R11,A12,R12,...
    %       A13,R13,A14,R14,A15,R15,A16,R16,A17,R17,A18,R18,A19,R19,A20,R20,A21,R21,A22,R22,A23,R23,A24,R24,...
    %       A25,R25,A26,R26,A27,R27,A28,R28,A29,R29,A30,R30,A31,R31,A32,R32,A33,R33,A34,R34,A35,R35,A36,R36,...
    %       A37,R37,A38,R38,A39,R39,A40,R40,A41,R41,A42,R42,A43,R43,A44,R44,A45,R45,A46,R46,A47,R47,A48,R48);
%% Save this file
    eval(['cd ' statedtedpath(1:length(statedtedpath)-1)]);
    actionstr='save';
    varstr1='Washington WashingtonRB DTEDFiles latlim lonlim';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dispstr=strcat('Saved State Level DEM File as-',MatFileName);
    disp(dispstr);
%% Now plot the data
    usamap(Washington,WashingtonRB)
    geoshow(Washington,WashingtonRB,DisplayType="surface")
    cmapsea  = [0.8 0 0.8; 0 0 0.8];
    cmapland = [0.7 0 0; 0.8 0.8 0; 1 1 0.8 ];
    cmapland=colormap('jet');
    Washingto2=Washington;
    Washington2(Washington<0)=NaN;
    demcmap(Washington2,64,cmapland);
    demcmap(Washington);
    maxht=max(max(Washington));
    dispstr=strcat('Max Elevation=',num2str(maxht));
    disp(dispstr)
    c = colorbar;
    c.Label.String = "Elevation (m)";
    ab=1;
    otherwise
        disp('Logic not written for this fips code')

end 