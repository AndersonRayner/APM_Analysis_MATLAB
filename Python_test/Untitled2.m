%% Import data from text file.
% Script for importing data from the following text file:
%
%    C:\Users\Matt\Desktop\Python_test\data.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2016/03/21 23:15:41

%% Initialize variables.
filename = 'C:\Users\Matt\Desktop\Python_test\data.csv';
delimiter = ',';
startRow = 2;

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,42,43,44,45,46,47,48,49,50,51,52,53,54,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,86,87,88,89,90]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end

%% Split data into numeric and cell columns.
rawNumericColumns = raw(:, [1,2,3,42,43,44,45,46,47,48,49,50,51,52,53,54,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,86,87,88,89,90]);
rawCellColumns = raw(:, [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,55,84,85,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513,514,515,516,517,518,519,520,521,522,523,524,525,526,527,528,529,530,531,532,533,534,535,536,537,538,539,540,541,542,543,544,545,546,547,548,549,550,551,552,553,554,555,556,557,558,559,560,561,562,563,564,565,566,567,568,569,570,571,572,573,574,575,576,577,578,579,580,581,582,583,584,585,586,587,588,589,590,591,592,593,594,595,596,597,598,599,600,601,602,603,604,605,606,607,608,609,610,611,612,613,614,615,616,617,618,619,620,621,622,623,624,625,626,627,628,629,630,631,632,633,634,635,636,637,638,639,640,641,642,643,644,645,646,647,648,649,650,651,652,653,654,655,656,657,658,659,660,661,662,663,664,665,666,667,668,669,670,671,672,673,674,675,676,677,678,679,680,681,682,683,684,685,686,687,688,689,690,691,692,693,694,695,696,697,698,699,700,701,702,703,704,705,706,707,708,709,710,711,712,713,714,715,716,717,718,719,720,721,722,723,724,725,726,727,728,729,730,731,732,733,734,735,736,737,738,739,740,741,742,743,744,745,746,747,748,749,750,751,752,753,754,755,756,757,758,759,760,761,762,763,764,765,766,767,768,769,770,771,772,773,774,775,776,777,778,779,780,781,782,783,784,785,786,787,788,789,790,791,792,793,794,795,796,797,798,799,800,801,802,803,804,805,806,807,808,809,810,811,812,813,814,815,816,817,818]);


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells

%% Allocate imported array to column variable names
PARM_TimeUS = cell2mat(rawNumericColumns(:, 1));
PARM_Name = cell2mat(rawNumericColumns(:, 2));
PARM_Value = cell2mat(rawNumericColumns(:, 3));
GPS_TimeUS = rawCellColumns(:, 1);
GPS_Status = rawCellColumns(:, 2);
GPS_GMS = rawCellColumns(:, 3);
GPS_GWk = rawCellColumns(:, 4);
GPS_NSats = rawCellColumns(:, 5);
GPS_HDop = rawCellColumns(:, 6);
GPS_Lat = rawCellColumns(:, 7);
GPS_Lng = rawCellColumns(:, 8);
GPS_RAlt = rawCellColumns(:, 9);
GPS_Alt = rawCellColumns(:, 10);
GPS_Spd = rawCellColumns(:, 11);
GPS_GCrs = rawCellColumns(:, 12);
GPS_VZ = rawCellColumns(:, 13);
GPS_U = rawCellColumns(:, 14);
GPS2_TimeUS = rawCellColumns(:, 15);
GPS2_Status = rawCellColumns(:, 16);
GPS2_GMS = rawCellColumns(:, 17);
GPS2_GWk = rawCellColumns(:, 18);
GPS2_NSats = rawCellColumns(:, 19);
GPS2_HDop = rawCellColumns(:, 20);
GPS2_Lat = rawCellColumns(:, 21);
GPS2_Lng = rawCellColumns(:, 22);
GPS2_RAlt = rawCellColumns(:, 23);
GPS2_Alt = rawCellColumns(:, 24);
GPS2_Spd = rawCellColumns(:, 25);
GPS2_GCrs = rawCellColumns(:, 26);
GPS2_VZ = rawCellColumns(:, 27);
GPS2_U = rawCellColumns(:, 28);
GPA_TimeUS = rawCellColumns(:, 29);
GPA_VDop = rawCellColumns(:, 30);
GPA_HAcc = rawCellColumns(:, 31);
GPA_VAcc = rawCellColumns(:, 32);
GPA_SAcc = rawCellColumns(:, 33);
GPA2_TimeUS = rawCellColumns(:, 34);
GPA2_VDop = rawCellColumns(:, 35);
GPA2_HAcc = rawCellColumns(:, 36);
GPA2_VAcc = rawCellColumns(:, 37);
GPA2_SAcc = rawCellColumns(:, 38);
IMU_TimeUS = cell2mat(rawNumericColumns(:, 4));
IMU_GyrX = cell2mat(rawNumericColumns(:, 5));
IMU_GyrY = cell2mat(rawNumericColumns(:, 6));
IMU_GyrZ = cell2mat(rawNumericColumns(:, 7));
IMU_AccX = cell2mat(rawNumericColumns(:, 8));
IMU_AccY = cell2mat(rawNumericColumns(:, 9));
IMU_AccZ = cell2mat(rawNumericColumns(:, 10));
IMU_ErrG = cell2mat(rawNumericColumns(:, 11));
IMU_ErrA = cell2mat(rawNumericColumns(:, 12));
IMU_Temp = cell2mat(rawNumericColumns(:, 13));
IMU_GyHlt = cell2mat(rawNumericColumns(:, 14));
IMU_AcHlt = cell2mat(rawNumericColumns(:, 15));
MSG_TimeUS = cell2mat(rawNumericColumns(:, 16));
MSG_Message = rawCellColumns(:, 39);
RCIN_TimeUS = cell2mat(rawNumericColumns(:, 17));
RCIN_C1 = cell2mat(rawNumericColumns(:, 18));
RCIN_C2 = cell2mat(rawNumericColumns(:, 19));
RCIN_C3 = cell2mat(rawNumericColumns(:, 20));
RCIN_C4 = cell2mat(rawNumericColumns(:, 21));
RCIN_C5 = cell2mat(rawNumericColumns(:, 22));
RCIN_C6 = cell2mat(rawNumericColumns(:, 23));
RCIN_C7 = cell2mat(rawNumericColumns(:, 24));
RCIN_C8 = cell2mat(rawNumericColumns(:, 25));
RCIN_C9 = cell2mat(rawNumericColumns(:, 26));
RCIN_C10 = cell2mat(rawNumericColumns(:, 27));
RCIN_C11 = cell2mat(rawNumericColumns(:, 28));
RCIN_C12 = cell2mat(rawNumericColumns(:, 29));
RCIN_C13 = cell2mat(rawNumericColumns(:, 30));
RCIN_C14 = cell2mat(rawNumericColumns(:, 31));
RCOU_TimeUS = cell2mat(rawNumericColumns(:, 32));
RCOU_Ch1 = cell2mat(rawNumericColumns(:, 33));
RCOU_Ch2 = cell2mat(rawNumericColumns(:, 34));
RCOU_Ch3 = cell2mat(rawNumericColumns(:, 35));
RCOU_Ch4 = cell2mat(rawNumericColumns(:, 36));
RCOU_Ch5 = cell2mat(rawNumericColumns(:, 37));
RCOU_Ch6 = cell2mat(rawNumericColumns(:, 38));
RCOU_Ch7 = cell2mat(rawNumericColumns(:, 39));
RCOU_Ch8 = cell2mat(rawNumericColumns(:, 40));
RCOU_Ch9 = cell2mat(rawNumericColumns(:, 41));
RCOU_Ch10 = cell2mat(rawNumericColumns(:, 42));
RCOU_Ch11 = cell2mat(rawNumericColumns(:, 43));
RCOU_Ch12 = cell2mat(rawNumericColumns(:, 44));
RSSI_TimeUS = rawCellColumns(:, 40);
RSSI_RXRSSI = rawCellColumns(:, 41);
BARO_TimeUS = cell2mat(rawNumericColumns(:, 45));
BARO_Alt = cell2mat(rawNumericColumns(:, 46));
BARO_Press = cell2mat(rawNumericColumns(:, 47));
BARO_Temp = cell2mat(rawNumericColumns(:, 48));
BARO_CRt = cell2mat(rawNumericColumns(:, 49));
POWR_TimeUS = rawCellColumns(:, 42);
POWR_Vcc = rawCellColumns(:, 43);
POWR_VServo = rawCellColumns(:, 44);
POWR_Flags = rawCellColumns(:, 45);
CMD_TimeUS = rawCellColumns(:, 46);
CMD_CTot = rawCellColumns(:, 47);
CMD_CNum = rawCellColumns(:, 48);
CMD_CId = rawCellColumns(:, 49);
CMD_Prm1 = rawCellColumns(:, 50);
CMD_Prm2 = rawCellColumns(:, 51);
CMD_Prm3 = rawCellColumns(:, 52);
CMD_Prm4 = rawCellColumns(:, 53);
CMD_Lat = rawCellColumns(:, 54);
CMD_Lng = rawCellColumns(:, 55);
CMD_Alt = rawCellColumns(:, 56);
RAD_TimeUS = rawCellColumns(:, 57);
RAD_RSSI = rawCellColumns(:, 58);
RAD_RemRSSI = rawCellColumns(:, 59);
RAD_TxBuf = rawCellColumns(:, 60);
RAD_Noise = rawCellColumns(:, 61);
RAD_RemNoise = rawCellColumns(:, 62);
RAD_RxErrors = rawCellColumns(:, 63);
RAD_Fixed = rawCellColumns(:, 64);
CAM_TimeUS = rawCellColumns(:, 65);
CAM_GPSTime = rawCellColumns(:, 66);
CAM_GPSWeek = rawCellColumns(:, 67);
CAM_Lat = rawCellColumns(:, 68);
CAM_Lng = rawCellColumns(:, 69);
CAM_Alt = rawCellColumns(:, 70);
CAM_RelAlt = rawCellColumns(:, 71);
CAM_GPSAlt = rawCellColumns(:, 72);
CAM_Roll = rawCellColumns(:, 73);
CAM_Pitch = rawCellColumns(:, 74);
CAM_Yaw = rawCellColumns(:, 75);
TRIG_TimeUS = rawCellColumns(:, 76);
TRIG_GPSTime = rawCellColumns(:, 77);
TRIG_GPSWeek = rawCellColumns(:, 78);
TRIG_Lat = rawCellColumns(:, 79);
TRIG_Lng = rawCellColumns(:, 80);
TRIG_Alt = rawCellColumns(:, 81);
TRIG_RelAlt = rawCellColumns(:, 82);
TRIG_GPSAlt = rawCellColumns(:, 83);
TRIG_Roll = rawCellColumns(:, 84);
TRIG_Pitch = rawCellColumns(:, 85);
TRIG_Yaw = rawCellColumns(:, 86);
ARSP_TimeUS = rawCellColumns(:, 87);
ARSP_Airspeed = rawCellColumns(:, 88);
ARSP_DiffPress = rawCellColumns(:, 89);
ARSP_Temp = rawCellColumns(:, 90);
ARSP_RawPress = rawCellColumns(:, 91);
ARSP_Offset = rawCellColumns(:, 92);
CURR_TimeUS = rawCellColumns(:, 93);
CURR_Throttle = rawCellColumns(:, 94);
CURR_Volt = rawCellColumns(:, 95);
CURR_Curr = rawCellColumns(:, 96);
CURR_Vcc = rawCellColumns(:, 97);
CURR_CurrTot = rawCellColumns(:, 98);
CURR_Volt2 = rawCellColumns(:, 99);
ATT_TimeUS = rawCellColumns(:, 100);
ATT_DesRoll = rawCellColumns(:, 101);
ATT_Roll = rawCellColumns(:, 102);
ATT_DesPitch = rawCellColumns(:, 103);
ATT_Pitch = rawCellColumns(:, 104);
ATT_DesYaw = rawCellColumns(:, 105);
ATT_Yaw = rawCellColumns(:, 106);
ATT_ErrRP = rawCellColumns(:, 107);
ATT_ErrYaw = rawCellColumns(:, 108);
MAG_TimeUS = rawCellColumns(:, 109);
MAG_MagX = rawCellColumns(:, 110);
MAG_MagY = rawCellColumns(:, 111);
MAG_MagZ = rawCellColumns(:, 112);
MAG_OfsX = rawCellColumns(:, 113);
MAG_OfsY = rawCellColumns(:, 114);
MAG_OfsZ = rawCellColumns(:, 115);
MAG_MOfsX = rawCellColumns(:, 116);
MAG_MOfsY = rawCellColumns(:, 117);
MAG_MOfsZ = rawCellColumns(:, 118);
MAG_Health = rawCellColumns(:, 119);
MODE_TimeUS = rawCellColumns(:, 120);
MODE_Mode = rawCellColumns(:, 121);
MODE_ModeNum = rawCellColumns(:, 122);
RFND_TimeUS = rawCellColumns(:, 123);
RFND_Dist1 = rawCellColumns(:, 124);
RFND_Dist2 = rawCellColumns(:, 125);
DMS_TimeMS = rawCellColumns(:, 126);
DMS_N = rawCellColumns(:, 127);
DMS_Dp = rawCellColumns(:, 128);
DMS_RT = rawCellColumns(:, 129);
DMS_RS = rawCellColumns(:, 130);
DMS_Er = rawCellColumns(:, 131);
DMS_Fa = rawCellColumns(:, 132);
DMS_Fmn = rawCellColumns(:, 133);
DMS_Fmx = rawCellColumns(:, 134);
DMS_Pa = rawCellColumns(:, 135);
DMS_Pmn = rawCellColumns(:, 136);
DMS_Pmx = rawCellColumns(:, 137);
DMS_Sa = rawCellColumns(:, 138);
DMS_Smn = rawCellColumns(:, 139);
DMS_Smx = rawCellColumns(:, 140);
IMU2_TimeUS = rawCellColumns(:, 141);
IMU2_GyrX = rawCellColumns(:, 142);
IMU2_GyrY = rawCellColumns(:, 143);
IMU2_GyrZ = rawCellColumns(:, 144);
IMU2_AccX = rawCellColumns(:, 145);
IMU2_AccY = rawCellColumns(:, 146);
IMU2_AccZ = rawCellColumns(:, 147);
IMU2_ErrG = rawCellColumns(:, 148);
IMU2_ErrA = rawCellColumns(:, 149);
IMU2_Temp = rawCellColumns(:, 150);
IMU2_GyHlt = rawCellColumns(:, 151);
IMU2_AcHlt = rawCellColumns(:, 152);
IMU3_TimeUS = rawCellColumns(:, 153);
IMU3_GyrX = rawCellColumns(:, 154);
IMU3_GyrY = rawCellColumns(:, 155);
IMU3_GyrZ = rawCellColumns(:, 156);
IMU3_AccX = rawCellColumns(:, 157);
IMU3_AccY = rawCellColumns(:, 158);
IMU3_AccZ = rawCellColumns(:, 159);
IMU3_ErrG = rawCellColumns(:, 160);
IMU3_ErrA = rawCellColumns(:, 161);
IMU3_Temp = rawCellColumns(:, 162);
IMU3_GyHlt = rawCellColumns(:, 163);
IMU3_AcHlt = rawCellColumns(:, 164);
AHR2_TimeUS = rawCellColumns(:, 165);
AHR2_Roll = rawCellColumns(:, 166);
AHR2_Pitch = rawCellColumns(:, 167);
AHR2_Yaw = rawCellColumns(:, 168);
AHR2_Alt = rawCellColumns(:, 169);
AHR2_Lat = rawCellColumns(:, 170);
AHR2_Lng = rawCellColumns(:, 171);
POS_TimeUS = rawCellColumns(:, 172);
POS_Lat = rawCellColumns(:, 173);
POS_Lng = rawCellColumns(:, 174);
POS_Alt = rawCellColumns(:, 175);
POS_RelAlt = rawCellColumns(:, 176);
SIM_TimeUS = rawCellColumns(:, 177);
SIM_Roll = rawCellColumns(:, 178);
SIM_Pitch = rawCellColumns(:, 179);
SIM_Yaw = rawCellColumns(:, 180);
SIM_Alt = rawCellColumns(:, 181);
SIM_Lat = rawCellColumns(:, 182);
SIM_Lng = rawCellColumns(:, 183);
EKF1_TimeUS = rawCellColumns(:, 184);
EKF1_Roll = rawCellColumns(:, 185);
EKF1_Pitch = rawCellColumns(:, 186);
EKF1_Yaw = rawCellColumns(:, 187);
EKF1_VN = rawCellColumns(:, 188);
EKF1_VE = rawCellColumns(:, 189);
EKF1_VD = rawCellColumns(:, 190);
EKF1_dPD = rawCellColumns(:, 191);
EKF1_PN = rawCellColumns(:, 192);
EKF1_PE = rawCellColumns(:, 193);
EKF1_PD = rawCellColumns(:, 194);
EKF1_GX = rawCellColumns(:, 195);
EKF1_GY = rawCellColumns(:, 196);
EKF1_GZ = rawCellColumns(:, 197);
EKF2_TimeUS = rawCellColumns(:, 198);
EKF2_Ratio = rawCellColumns(:, 199);
EKF2_AZ1bias = rawCellColumns(:, 200);
EKF2_AZ2bias = rawCellColumns(:, 201);
EKF2_VWN = rawCellColumns(:, 202);
EKF2_VWE = rawCellColumns(:, 203);
EKF2_MN = rawCellColumns(:, 204);
EKF2_ME = rawCellColumns(:, 205);
EKF2_MD = rawCellColumns(:, 206);
EKF2_MX = rawCellColumns(:, 207);
EKF2_MY = rawCellColumns(:, 208);
EKF2_MZ = rawCellColumns(:, 209);
EKF3_TimeUS = rawCellColumns(:, 210);
EKF3_IVN = rawCellColumns(:, 211);
EKF3_IVE = rawCellColumns(:, 212);
EKF3_IVD = rawCellColumns(:, 213);
EKF3_IPN = rawCellColumns(:, 214);
EKF3_IPE = rawCellColumns(:, 215);
EKF3_IPD = rawCellColumns(:, 216);
EKF3_IMX = rawCellColumns(:, 217);
EKF3_IMY = rawCellColumns(:, 218);
EKF3_IMZ = rawCellColumns(:, 219);
EKF3_IVT = rawCellColumns(:, 220);
EKF4_TimeUS = rawCellColumns(:, 221);
EKF4_SV = rawCellColumns(:, 222);
EKF4_SP = rawCellColumns(:, 223);
EKF4_SH = rawCellColumns(:, 224);
EKF4_SMX = rawCellColumns(:, 225);
EKF4_SMY = rawCellColumns(:, 226);
EKF4_SMZ = rawCellColumns(:, 227);
EKF4_SVT = rawCellColumns(:, 228);
EKF4_OFN = rawCellColumns(:, 229);
EKF4_OFE = rawCellColumns(:, 230);
EKF4_FS = rawCellColumns(:, 231);
EKF4_TS = rawCellColumns(:, 232);
EKF4_SS = rawCellColumns(:, 233);
EKF4_GPS = rawCellColumns(:, 234);
EKF5_TimeUS = rawCellColumns(:, 235);
EKF5_normInnov = rawCellColumns(:, 236);
EKF5_FIX = rawCellColumns(:, 237);
EKF5_FIY = rawCellColumns(:, 238);
EKF5_AFI = rawCellColumns(:, 239);
EKF5_HAGL = rawCellColumns(:, 240);
EKF5_offset = rawCellColumns(:, 241);
EKF5_RI = rawCellColumns(:, 242);
EKF5_meaRng = rawCellColumns(:, 243);
EKF5_errHAGL = rawCellColumns(:, 244);
NKF1_TimeUS = rawCellColumns(:, 245);
NKF1_Roll = rawCellColumns(:, 246);
NKF1_Pitch = rawCellColumns(:, 247);
NKF1_Yaw = rawCellColumns(:, 248);
NKF1_VN = rawCellColumns(:, 249);
NKF1_VE = rawCellColumns(:, 250);
NKF1_VD = rawCellColumns(:, 251);
NKF1_dPD = rawCellColumns(:, 252);
NKF1_PN = rawCellColumns(:, 253);
NKF1_PE = rawCellColumns(:, 254);
NKF1_PD = rawCellColumns(:, 255);
NKF1_GX = rawCellColumns(:, 256);
NKF1_GY = rawCellColumns(:, 257);
NKF1_GZ = rawCellColumns(:, 258);
NKF2_TimeUS = rawCellColumns(:, 259);
NKF2_AZbias = rawCellColumns(:, 260);
NKF2_GSX = rawCellColumns(:, 261);
NKF2_GSY = rawCellColumns(:, 262);
NKF2_GSZ = rawCellColumns(:, 263);
NKF2_VWN = rawCellColumns(:, 264);
NKF2_VWE = rawCellColumns(:, 265);
NKF2_MN = rawCellColumns(:, 266);
NKF2_ME = rawCellColumns(:, 267);
NKF2_MD = rawCellColumns(:, 268);
NKF2_MX = rawCellColumns(:, 269);
NKF2_MY = rawCellColumns(:, 270);
NKF2_MZ = rawCellColumns(:, 271);
NKF2_MI = rawCellColumns(:, 272);
NKF3_TimeUS = rawCellColumns(:, 273);
NKF3_IVN = rawCellColumns(:, 274);
NKF3_IVE = rawCellColumns(:, 275);
NKF3_IVD = rawCellColumns(:, 276);
NKF3_IPN = rawCellColumns(:, 277);
NKF3_IPE = rawCellColumns(:, 278);
NKF3_IPD = rawCellColumns(:, 279);
NKF3_IMX = rawCellColumns(:, 280);
NKF3_IMY = rawCellColumns(:, 281);
NKF3_IMZ = rawCellColumns(:, 282);
NKF3_IYAW = rawCellColumns(:, 283);
NKF3_IVT = rawCellColumns(:, 284);
NKF4_TimeUS = rawCellColumns(:, 285);
NKF4_SV = rawCellColumns(:, 286);
NKF4_SP = rawCellColumns(:, 287);
NKF4_SH = rawCellColumns(:, 288);
NKF4_SM = rawCellColumns(:, 289);
NKF4_SVT = rawCellColumns(:, 290);
NKF4_errRP = rawCellColumns(:, 291);
NKF4_OFN = rawCellColumns(:, 292);
NKF4_OFE = rawCellColumns(:, 293);
NKF4_FS = rawCellColumns(:, 294);
NKF4_TS = rawCellColumns(:, 295);
NKF4_SS = rawCellColumns(:, 296);
NKF4_GPS = rawCellColumns(:, 297);
NKF4_PI = rawCellColumns(:, 298);
NKF5_TimeUS = rawCellColumns(:, 299);
NKF5_normInnov = rawCellColumns(:, 300);
NKF5_FIX = rawCellColumns(:, 301);
NKF5_FIY = rawCellColumns(:, 302);
NKF5_AFI = rawCellColumns(:, 303);
NKF5_HAGL = rawCellColumns(:, 304);
NKF5_offset = rawCellColumns(:, 305);
NKF5_RI = rawCellColumns(:, 306);
NKF5_meaRng = rawCellColumns(:, 307);
NKF5_errHAGL = rawCellColumns(:, 308);
NKF6_TimeUS = rawCellColumns(:, 309);
NKF6_Roll = rawCellColumns(:, 310);
NKF6_Pitch = rawCellColumns(:, 311);
NKF6_Yaw = rawCellColumns(:, 312);
NKF6_VN = rawCellColumns(:, 313);
NKF6_VE = rawCellColumns(:, 314);
NKF6_VD = rawCellColumns(:, 315);
NKF6_dPD = rawCellColumns(:, 316);
NKF6_PN = rawCellColumns(:, 317);
NKF6_PE = rawCellColumns(:, 318);
NKF6_PD = rawCellColumns(:, 319);
NKF6_GX = rawCellColumns(:, 320);
NKF6_GY = rawCellColumns(:, 321);
NKF6_GZ = rawCellColumns(:, 322);
NKF7_TimeUS = rawCellColumns(:, 323);
NKF7_AZbias = rawCellColumns(:, 324);
NKF7_GSX = rawCellColumns(:, 325);
NKF7_GSY = rawCellColumns(:, 326);
NKF7_GSZ = rawCellColumns(:, 327);
NKF7_VWN = rawCellColumns(:, 328);
NKF7_VWE = rawCellColumns(:, 329);
NKF7_MN = rawCellColumns(:, 330);
NKF7_ME = rawCellColumns(:, 331);
NKF7_MD = rawCellColumns(:, 332);
NKF7_MX = rawCellColumns(:, 333);
NKF7_MY = rawCellColumns(:, 334);
NKF7_MZ = rawCellColumns(:, 335);
NKF7_MI = rawCellColumns(:, 336);
NKF8_TimeUS = rawCellColumns(:, 337);
NKF8_IVN = rawCellColumns(:, 338);
NKF8_IVE = rawCellColumns(:, 339);
NKF8_IVD = rawCellColumns(:, 340);
NKF8_IPN = rawCellColumns(:, 341);
NKF8_IPE = rawCellColumns(:, 342);
NKF8_IPD = rawCellColumns(:, 343);
NKF8_IMX = rawCellColumns(:, 344);
NKF8_IMY = rawCellColumns(:, 345);
NKF8_IMZ = rawCellColumns(:, 346);
NKF8_IYAW = rawCellColumns(:, 347);
NKF8_IVT = rawCellColumns(:, 348);
NKF9_TimeUS = rawCellColumns(:, 349);
NKF9_SV = rawCellColumns(:, 350);
NKF9_SP = rawCellColumns(:, 351);
NKF9_SH = rawCellColumns(:, 352);
NKF9_SM = rawCellColumns(:, 353);
NKF9_SVT = rawCellColumns(:, 354);
NKF9_errRP = rawCellColumns(:, 355);
NKF9_OFN = rawCellColumns(:, 356);
NKF9_OFE = rawCellColumns(:, 357);
NKF9_FS = rawCellColumns(:, 358);
NKF9_TS = rawCellColumns(:, 359);
NKF9_SS = rawCellColumns(:, 360);
NKF9_GPS = rawCellColumns(:, 361);
NKF9_PI = rawCellColumns(:, 362);
TERR_TimeUS = rawCellColumns(:, 363);
TERR_Status = rawCellColumns(:, 364);
TERR_Lat = rawCellColumns(:, 365);
TERR_Lng = rawCellColumns(:, 366);
TERR_Spacing = rawCellColumns(:, 367);
TERR_TerrH = rawCellColumns(:, 368);
TERR_CHeight = rawCellColumns(:, 369);
TERR_Pending = rawCellColumns(:, 370);
TERR_Loaded = rawCellColumns(:, 371);
UBX1_TimeUS = rawCellColumns(:, 372);
UBX1_Instance = rawCellColumns(:, 373);
UBX1_noisePerMS = rawCellColumns(:, 374);
UBX1_jamInd = rawCellColumns(:, 375);
UBX1_aPower = rawCellColumns(:, 376);
UBX1_agcCnt = rawCellColumns(:, 377);
UBX2_TimeUS = rawCellColumns(:, 378);
UBX2_Instance = rawCellColumns(:, 379);
UBX2_ofsI = rawCellColumns(:, 380);
UBX2_magI = rawCellColumns(:, 381);
UBX2_ofsQ = rawCellColumns(:, 382);
UBX2_magQ = rawCellColumns(:, 383);
UBY1_TimeUS = rawCellColumns(:, 384);
UBY1_Instance = rawCellColumns(:, 385);
UBY1_noisePerMS = rawCellColumns(:, 386);
UBY1_jamInd = rawCellColumns(:, 387);
UBY1_aPower = rawCellColumns(:, 388);
UBY1_agcCnt = rawCellColumns(:, 389);
UBY2_TimeUS = rawCellColumns(:, 390);
UBY2_Instance = rawCellColumns(:, 391);
UBY2_ofsI = rawCellColumns(:, 392);
UBY2_magI = rawCellColumns(:, 393);
UBY2_ofsQ = rawCellColumns(:, 394);
UBY2_magQ = rawCellColumns(:, 395);
GRAW_TimeUS = rawCellColumns(:, 396);
GRAW_WkMS = rawCellColumns(:, 397);
GRAW_Week = rawCellColumns(:, 398);
GRAW_numSV = rawCellColumns(:, 399);
GRAW_sv = rawCellColumns(:, 400);
GRAW_cpMes = rawCellColumns(:, 401);
GRAW_prMes = rawCellColumns(:, 402);
GRAW_doMes = rawCellColumns(:, 403);
GRAW_mesQI = rawCellColumns(:, 404);
GRAW_cno = rawCellColumns(:, 405);
GRAW_lli = rawCellColumns(:, 406);
GRXH_TimeUS = rawCellColumns(:, 407);
GRXH_rcvTime = rawCellColumns(:, 408);
GRXH_week = rawCellColumns(:, 409);
GRXH_leapS = rawCellColumns(:, 410);
GRXH_numMeas = rawCellColumns(:, 411);
GRXH_recStat = rawCellColumns(:, 412);
GRXS_TimeUS = rawCellColumns(:, 413);
GRXS_prMes = rawCellColumns(:, 414);
GRXS_cpMes = rawCellColumns(:, 415);
GRXS_doMes = rawCellColumns(:, 416);
GRXS_gnss = rawCellColumns(:, 417);
GRXS_sv = rawCellColumns(:, 418);
GRXS_freq = rawCellColumns(:, 419);
GRXS_lock = rawCellColumns(:, 420);
GRXS_cno = rawCellColumns(:, 421);
GRXS_prD = rawCellColumns(:, 422);
GRXS_cpD = rawCellColumns(:, 423);
GRXS_doD = rawCellColumns(:, 424);
GRXS_trk = rawCellColumns(:, 425);
SBFE_TimeUS = rawCellColumns(:, 426);
SBFE_TOW = rawCellColumns(:, 427);
SBFE_WN = rawCellColumns(:, 428);
SBFE_Mode = rawCellColumns(:, 429);
SBFE_Err = rawCellColumns(:, 430);
SBFE_Lat = rawCellColumns(:, 431);
SBFE_Long = rawCellColumns(:, 432);
SBFE_Height = rawCellColumns(:, 433);
SBFE_Undul = rawCellColumns(:, 434);
SBFE_Vn = rawCellColumns(:, 435);
SBFE_Ve = rawCellColumns(:, 436);
SBFE_Vu = rawCellColumns(:, 437);
SBFE_COG = rawCellColumns(:, 438);
ESC1_TimeUS = rawCellColumns(:, 439);
ESC1_RPM = rawCellColumns(:, 440);
ESC1_Volt = rawCellColumns(:, 441);
ESC1_Curr = rawCellColumns(:, 442);
ESC1_Temp = rawCellColumns(:, 443);
ESC2_TimeUS = rawCellColumns(:, 444);
ESC2_RPM = rawCellColumns(:, 445);
ESC2_Volt = rawCellColumns(:, 446);
ESC2_Curr = rawCellColumns(:, 447);
ESC2_Temp = rawCellColumns(:, 448);
ESC3_TimeUS = rawCellColumns(:, 449);
ESC3_RPM = rawCellColumns(:, 450);
ESC3_Volt = rawCellColumns(:, 451);
ESC3_Curr = rawCellColumns(:, 452);
ESC3_Temp = rawCellColumns(:, 453);
ESC4_TimeUS = rawCellColumns(:, 454);
ESC4_RPM = rawCellColumns(:, 455);
ESC4_Volt = rawCellColumns(:, 456);
ESC4_Curr = rawCellColumns(:, 457);
ESC4_Temp = rawCellColumns(:, 458);
ESC5_TimeUS = rawCellColumns(:, 459);
ESC5_RPM = rawCellColumns(:, 460);
ESC5_Volt = rawCellColumns(:, 461);
ESC5_Curr = rawCellColumns(:, 462);
ESC5_Temp = rawCellColumns(:, 463);
ESC6_TimeUS = rawCellColumns(:, 464);
ESC6_RPM = rawCellColumns(:, 465);
ESC6_Volt = rawCellColumns(:, 466);
ESC6_Curr = rawCellColumns(:, 467);
ESC6_Temp = rawCellColumns(:, 468);
ESC7_TimeUS = rawCellColumns(:, 469);
ESC7_RPM = rawCellColumns(:, 470);
ESC7_Volt = rawCellColumns(:, 471);
ESC7_Curr = rawCellColumns(:, 472);
ESC7_Temp = rawCellColumns(:, 473);
ESC8_TimeUS = rawCellColumns(:, 474);
ESC8_RPM = rawCellColumns(:, 475);
ESC8_Volt = rawCellColumns(:, 476);
ESC8_Curr = rawCellColumns(:, 477);
ESC8_Temp = rawCellColumns(:, 478);
MAG2_TimeUS = rawCellColumns(:, 479);
MAG2_MagX = rawCellColumns(:, 480);
MAG2_MagY = rawCellColumns(:, 481);
MAG2_MagZ = rawCellColumns(:, 482);
MAG2_OfsX = rawCellColumns(:, 483);
MAG2_OfsY = rawCellColumns(:, 484);
MAG2_OfsZ = rawCellColumns(:, 485);
MAG2_MOfsX = rawCellColumns(:, 486);
MAG2_MOfsY = rawCellColumns(:, 487);
MAG2_MOfsZ = rawCellColumns(:, 488);
MAG2_Health = rawCellColumns(:, 489);
MAG3_TimeUS = rawCellColumns(:, 490);
MAG3_MagX = rawCellColumns(:, 491);
MAG3_MagY = rawCellColumns(:, 492);
MAG3_MagZ = rawCellColumns(:, 493);
MAG3_OfsX = rawCellColumns(:, 494);
MAG3_OfsY = rawCellColumns(:, 495);
MAG3_OfsZ = rawCellColumns(:, 496);
MAG3_MOfsX = rawCellColumns(:, 497);
MAG3_MOfsY = rawCellColumns(:, 498);
MAG3_MOfsZ = rawCellColumns(:, 499);
MAG3_Health = rawCellColumns(:, 500);
ACC1_TimeUS = rawCellColumns(:, 501);
ACC1_SampleUS = rawCellColumns(:, 502);
ACC1_AccX = rawCellColumns(:, 503);
ACC1_AccY = rawCellColumns(:, 504);
ACC1_AccZ = rawCellColumns(:, 505);
ACC2_TimeUS = rawCellColumns(:, 506);
ACC2_SampleUS = rawCellColumns(:, 507);
ACC2_AccX = rawCellColumns(:, 508);
ACC2_AccY = rawCellColumns(:, 509);
ACC2_AccZ = rawCellColumns(:, 510);
ACC3_TimeUS = rawCellColumns(:, 511);
ACC3_SampleUS = rawCellColumns(:, 512);
ACC3_AccX = rawCellColumns(:, 513);
ACC3_AccY = rawCellColumns(:, 514);
ACC3_AccZ = rawCellColumns(:, 515);
GYR1_TimeUS = rawCellColumns(:, 516);
GYR1_SampleUS = rawCellColumns(:, 517);
GYR1_GyrX = rawCellColumns(:, 518);
GYR1_GyrY = rawCellColumns(:, 519);
GYR1_GyrZ = rawCellColumns(:, 520);
GYR2_TimeUS = rawCellColumns(:, 521);
GYR2_SampleUS = rawCellColumns(:, 522);
GYR2_GyrX = rawCellColumns(:, 523);
GYR2_GyrY = rawCellColumns(:, 524);
GYR2_GyrZ = rawCellColumns(:, 525);
GYR3_TimeUS = rawCellColumns(:, 526);
GYR3_SampleUS = rawCellColumns(:, 527);
GYR3_GyrX = rawCellColumns(:, 528);
GYR3_GyrY = rawCellColumns(:, 529);
GYR3_GyrZ = rawCellColumns(:, 530);
PIDR_TimeUS = rawCellColumns(:, 531);
PIDR_Des = rawCellColumns(:, 532);
PIDR_P = rawCellColumns(:, 533);
PIDR_I = rawCellColumns(:, 534);
PIDR_D = rawCellColumns(:, 535);
PIDR_FF = rawCellColumns(:, 536);
PIDR_AFF = rawCellColumns(:, 537);
PIDP_TimeUS = rawCellColumns(:, 538);
PIDP_Des = rawCellColumns(:, 539);
PIDP_P = rawCellColumns(:, 540);
PIDP_I = rawCellColumns(:, 541);
PIDP_D = rawCellColumns(:, 542);
PIDP_FF = rawCellColumns(:, 543);
PIDP_AFF = rawCellColumns(:, 544);
PIDY_TimeUS = rawCellColumns(:, 545);
PIDY_Des = rawCellColumns(:, 546);
PIDY_P = rawCellColumns(:, 547);
PIDY_I = rawCellColumns(:, 548);
PIDY_D = rawCellColumns(:, 549);
PIDY_FF = rawCellColumns(:, 550);
PIDY_AFF = rawCellColumns(:, 551);
PIDA_TimeUS = rawCellColumns(:, 552);
PIDA_Des = rawCellColumns(:, 553);
PIDA_P = rawCellColumns(:, 554);
PIDA_I = rawCellColumns(:, 555);
PIDA_D = rawCellColumns(:, 556);
PIDA_FF = rawCellColumns(:, 557);
PIDA_AFF = rawCellColumns(:, 558);
PIDS_TimeUS = rawCellColumns(:, 559);
PIDS_Des = rawCellColumns(:, 560);
PIDS_P = rawCellColumns(:, 561);
PIDS_I = rawCellColumns(:, 562);
PIDS_D = rawCellColumns(:, 563);
PIDS_FF = rawCellColumns(:, 564);
PIDS_AFF = rawCellColumns(:, 565);
BAR2_TimeUS = rawCellColumns(:, 566);
BAR2_Alt = rawCellColumns(:, 567);
BAR2_Press = rawCellColumns(:, 568);
BAR2_Temp = rawCellColumns(:, 569);
BAR2_CRt = rawCellColumns(:, 570);
BAR3_TimeUS = rawCellColumns(:, 571);
BAR3_Alt = rawCellColumns(:, 572);
BAR3_Press = rawCellColumns(:, 573);
BAR3_Temp = rawCellColumns(:, 574);
BAR3_CRt = rawCellColumns(:, 575);
VIBE_TimeUS = rawCellColumns(:, 576);
VIBE_VibeX = rawCellColumns(:, 577);
VIBE_VibeY = rawCellColumns(:, 578);
VIBE_VibeZ = rawCellColumns(:, 579);
VIBE_Clip0 = rawCellColumns(:, 580);
VIBE_Clip1 = rawCellColumns(:, 581);
VIBE_Clip2 = rawCellColumns(:, 582);
IMT_TimeUS = rawCellColumns(:, 583);
IMT_DelT = rawCellColumns(:, 584);
IMT_DelvT = rawCellColumns(:, 585);
IMT_DelAX = rawCellColumns(:, 586);
IMT_DelAY = rawCellColumns(:, 587);
IMT_DelAZ = rawCellColumns(:, 588);
IMT_DelVX = rawCellColumns(:, 589);
IMT_DelVY = rawCellColumns(:, 590);
IMT_DelVZ = rawCellColumns(:, 591);
IMT2_TimeUS = rawCellColumns(:, 592);
IMT2_DelT = rawCellColumns(:, 593);
IMT2_DelvT = rawCellColumns(:, 594);
IMT2_DelAX = rawCellColumns(:, 595);
IMT2_DelAY = rawCellColumns(:, 596);
IMT2_DelAZ = rawCellColumns(:, 597);
IMT2_DelVX = rawCellColumns(:, 598);
IMT2_DelVY = rawCellColumns(:, 599);
IMT2_DelVZ = rawCellColumns(:, 600);
IMT3_TimeUS = rawCellColumns(:, 601);
IMT3_DelT = rawCellColumns(:, 602);
IMT3_DelvT = rawCellColumns(:, 603);
IMT3_DelAX = rawCellColumns(:, 604);
IMT3_DelAY = rawCellColumns(:, 605);
IMT3_DelAZ = rawCellColumns(:, 606);
IMT3_DelVX = rawCellColumns(:, 607);
IMT3_DelVY = rawCellColumns(:, 608);
IMT3_DelVZ = rawCellColumns(:, 609);
ORGN_TimeUS = rawCellColumns(:, 610);
ORGN_Type = rawCellColumns(:, 611);
ORGN_Lat = rawCellColumns(:, 612);
ORGN_Lng = rawCellColumns(:, 613);
ORGN_Alt = rawCellColumns(:, 614);
RPM_TimeUS = rawCellColumns(:, 615);
RPM_rpm1 = rawCellColumns(:, 616);
RPM_rpm2 = rawCellColumns(:, 617);
GMB1_TimeMS = rawCellColumns(:, 618);
GMB1_dt = rawCellColumns(:, 619);
GMB1_dax = rawCellColumns(:, 620);
GMB1_day = rawCellColumns(:, 621);
GMB1_daz = rawCellColumns(:, 622);
GMB1_dvx = rawCellColumns(:, 623);
GMB1_dvy = rawCellColumns(:, 624);
GMB1_dvz = rawCellColumns(:, 625);
GMB1_jx = rawCellColumns(:, 626);
GMB1_jy = rawCellColumns(:, 627);
GMB1_jz = rawCellColumns(:, 628);
GMB2_TimeMS = rawCellColumns(:, 629);
GMB2_es = rawCellColumns(:, 630);
GMB2_ex = rawCellColumns(:, 631);
GMB2_ey = rawCellColumns(:, 632);
GMB2_ez = rawCellColumns(:, 633);
GMB2_rx = rawCellColumns(:, 634);
GMB2_ry = rawCellColumns(:, 635);
GMB2_rz = rawCellColumns(:, 636);
GMB2_tx = rawCellColumns(:, 637);
GMB2_ty = rawCellColumns(:, 638);
GMB2_tz = rawCellColumns(:, 639);
GMB3_TimeMS = rawCellColumns(:, 640);
GMB3_rl_torque_cmd = rawCellColumns(:, 641);
GMB3_el_torque_cmd = rawCellColumns(:, 642);
GMB3_az_torque_cmd = rawCellColumns(:, 643);
SBPH_TimeUS = rawCellColumns(:, 644);
SBPH_CrcError = rawCellColumns(:, 645);
SBPH_LastInject = rawCellColumns(:, 646);
SBPH_IARhyp = rawCellColumns(:, 647);
SBR1_TimeUS = rawCellColumns(:, 648);
SBR1_msg_type = rawCellColumns(:, 649);
SBR1_sender_id = rawCellColumns(:, 650);
SBR1_msg_len = rawCellColumns(:, 651);
SBR1_d1 = rawCellColumns(:, 652);
SBR2_TimeUS = rawCellColumns(:, 653);
SBR2_msg_type = rawCellColumns(:, 654);
SBR2_d2 = rawCellColumns(:, 655);
SBR2_d3 = rawCellColumns(:, 656);
SBR2_d4 = rawCellColumns(:, 657);
ATUN_TimeUS = rawCellColumns(:, 658);
ATUN_Axis = rawCellColumns(:, 659);
ATUN_TuneStep = rawCellColumns(:, 660);
ATUN_Targ = rawCellColumns(:, 661);
ATUN_Min = rawCellColumns(:, 662);
ATUN_Max = rawCellColumns(:, 663);
ATUN_RP = rawCellColumns(:, 664);
ATUN_RD = rawCellColumns(:, 665);
ATUN_SP = rawCellColumns(:, 666);
ATUN_ddt = rawCellColumns(:, 667);
ATDE_TimeUS = rawCellColumns(:, 668);
ATDE_Angle = rawCellColumns(:, 669);
ATDE_Rate = rawCellColumns(:, 670);
PTUN_TimeUS = rawCellColumns(:, 671);
PTUN_Param = rawCellColumns(:, 672);
PTUN_TunVal = rawCellColumns(:, 673);
PTUN_CtrlIn = rawCellColumns(:, 674);
PTUN_TunLo = rawCellColumns(:, 675);
PTUN_TunHi = rawCellColumns(:, 676);
OF_TimeUS = rawCellColumns(:, 677);
OF_Qual = rawCellColumns(:, 678);
OF_flowX = rawCellColumns(:, 679);
OF_flowY = rawCellColumns(:, 680);
OF_bodyX = rawCellColumns(:, 681);
OF_bodyY = rawCellColumns(:, 682);
NTUN_TimeUS = rawCellColumns(:, 683);
NTUN_DPosX = rawCellColumns(:, 684);
NTUN_DPosY = rawCellColumns(:, 685);
NTUN_PosX = rawCellColumns(:, 686);
NTUN_PosY = rawCellColumns(:, 687);
NTUN_DVelX = rawCellColumns(:, 688);
NTUN_DVelY = rawCellColumns(:, 689);
NTUN_VelX = rawCellColumns(:, 690);
NTUN_VelY = rawCellColumns(:, 691);
NTUN_DAccX = rawCellColumns(:, 692);
NTUN_DAccY = rawCellColumns(:, 693);
CTUN_TimeUS = rawCellColumns(:, 694);
CTUN_ThrIn = rawCellColumns(:, 695);
CTUN_AngBst = rawCellColumns(:, 696);
CTUN_ThrOut = rawCellColumns(:, 697);
CTUN_DAlt = rawCellColumns(:, 698);
CTUN_Alt = rawCellColumns(:, 699);
CTUN_BarAlt = rawCellColumns(:, 700);
CTUN_DSAlt = rawCellColumns(:, 701);
CTUN_SAlt = rawCellColumns(:, 702);
CTUN_DCRt = rawCellColumns(:, 703);
CTUN_CRt = rawCellColumns(:, 704);
PM_TimeUS = rawCellColumns(:, 705);
PM_NLon = rawCellColumns(:, 706);
PM_NLoop = rawCellColumns(:, 707);
PM_MaxT = rawCellColumns(:, 708);
PM_PMT = rawCellColumns(:, 709);
PM_I2CErr = rawCellColumns(:, 710);
PM_INSErr = rawCellColumns(:, 711);
RATE_TimeUS = rawCellColumns(:, 712);
RATE_RDes = rawCellColumns(:, 713);
RATE_R = rawCellColumns(:, 714);
RATE_ROut = rawCellColumns(:, 715);
RATE_PDes = rawCellColumns(:, 716);
RATE_P = rawCellColumns(:, 717);
RATE_POut = rawCellColumns(:, 718);
RATE_YDes = rawCellColumns(:, 719);
RATE_Y = rawCellColumns(:, 720);
RATE_YOut = rawCellColumns(:, 721);
RATE_ADes = rawCellColumns(:, 722);
RATE_A = rawCellColumns(:, 723);
RATE_AOut = rawCellColumns(:, 724);
MOTB_TimeUS = rawCellColumns(:, 725);
MOTB_LiftMax = rawCellColumns(:, 726);
MOTB_BatVolt = rawCellColumns(:, 727);
MOTB_BatRes = rawCellColumns(:, 728);
MOTB_ThLimit = rawCellColumns(:, 729);
STRT_TimeUS = rawCellColumns(:, 730);
EV_TimeUS = rawCellColumns(:, 731);
EV_Id = rawCellColumns(:, 732);
D16_TimeUS = rawCellColumns(:, 733);
D16_Id = rawCellColumns(:, 734);
D16_Value = rawCellColumns(:, 735);
DU16_TimeUS = rawCellColumns(:, 736);
DU16_Id = rawCellColumns(:, 737);
DU16_Value = rawCellColumns(:, 738);
D32_TimeUS = rawCellColumns(:, 739);
D32_Id = rawCellColumns(:, 740);
D32_Value = rawCellColumns(:, 741);
DU32_TimeUS = rawCellColumns(:, 742);
DU32_Id = rawCellColumns(:, 743);
DU32_Value = rawCellColumns(:, 744);
DFLT_TimeUS = rawCellColumns(:, 745);
DFLT_Id = rawCellColumns(:, 746);
DFLT_Value = rawCellColumns(:, 747);
ERR_TimeUS = rawCellColumns(:, 748);
ERR_Subsys = rawCellColumns(:, 749);
ERR_ECode = rawCellColumns(:, 750);
HELI_TimeUS = rawCellColumns(:, 751);
HELI_DRRPM = rawCellColumns(:, 752);
HELI_ERRPM = rawCellColumns(:, 753);
PL_TimeUS = rawCellColumns(:, 754);
PL_Heal = rawCellColumns(:, 755);
PL_bX = rawCellColumns(:, 756);
PL_bY = rawCellColumns(:, 757);
PL_eX = rawCellColumns(:, 758);
PL_eY = rawCellColumns(:, 759);
PL_pX = rawCellColumns(:, 760);
PL_pY = rawCellColumns(:, 761);
GUID_TimeUS = rawCellColumns(:, 762);
GUID_Type = rawCellColumns(:, 763);
GUID_pX = rawCellColumns(:, 764);
GUID_pY = rawCellColumns(:, 765);
GUID_pZ = rawCellColumns(:, 766);
GUID_vX = rawCellColumns(:, 767);
GUID_vY = rawCellColumns(:, 768);
GUID_vZ = rawCellColumns(:, 769);

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns R;