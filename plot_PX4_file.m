% function plot_PX4_file(file)
% Fields can be retrieved from DataFlash.h.  Search for log_XXX
close all
clear all
clc

addpath('./functions/');

% file = '1.mat';
% file = '2.mat';
% file = '3dr_aero.mat';
% file = '4.mat';
% file = '5.mat';
% file = '6.mat';
% file = '7.mat';
% file = '8.mat';
% file = '27.mat';
% file = 'airspeed_test.mat';
% file = 'bwb_flight.mat';
% file = 'lost_wing_flight.mat';
% file = 'marulan_quad_flight.mat';
file = 'write_off_flight.mat';

% Need to convert GPS into an X,Y,Z for the playback later on

load(file)

%% Settings
% xlims = [200 640]; % Sets the time limits.  Setting to 0 or commenting disables the feature
plot_all = 0;
grid_on = 1;


%% Turn individual plots on or off
plot_AHR2 = 0;
plot_ARSP = 0;
plot_ATT  = 0;
plot_BARO = 0;
plot_CTUN = 0;
plot_CURR = 0;
plot_EKF1 = 0;
plot_EKF2 = 0;
plot_EKF3 = 0;
plot_EKF4 = 0;
plot_GPA  = 0;
plot_GPS  = 1;
plot_IMU  = 0;
plot_IMU2 = 0;
plot_MAG  = 0;
plot_MAG2 = 0;
plot_NTUN = 0;
plot_PM   = 0;
plot_POS  = 0;
plot_POWR = 0;
plot_RAD  = 0;
plot_RCIN = 0;
plot_RCOU = 0;
plot_VIBE = 0;

%% ==== RAW DATA
%% AHR2 - DCM Attitude Estimate
if exist('AHR2','var') && (plot_all || plot_AHR2);
    freq = calc_data_frequency(AHR2.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['AHR2 Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(3,2,1); hold all; plot(AHR2.t,AHR2.Roll); ylabel('Roll [ deg ]');
    subplot(3,2,3); hold all; plot(AHR2.t,AHR2.Pitch); ylabel('Pitch [ deg ]');
    subplot(3,2,5); hold all; plot(AHR2.t,unwrap_360(AHR2.Yaw)); ylabel('Yaw [ deg ]'); xlabel('Time [ s ]');
    subplot(3,2,2); hold all; plot(AHR2.t,AHR2.Alt); ylabel('Altitude [ m ]'); xlabel('Time [ s ]');
    subplot(3,2,[4,6]); hold all; plot(AHR2.Lng/1e7,AHR2.Lat/1e7); axis equal; xlabel('Longitude'); ylabel('Latitude');
    % A note on these equal-axis Lat/Lng plots.  Not quite right at 1 Lat ~= 1 Lng, need to fix.
end
%% ARSP - Airspeed Data
if exist('ARSP','var') && (plot_all || plot_ARSP);
    freq = calc_data_frequency(ARSP.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['ARSP Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(3,1,1); hold all; plot(ARSP.t,ARSP.Airspeed); ylabel('Airspeed [ m/s ]');
    subplot(3,1,2); hold all; ...
        try plot(ARSP.t,ARSP.DiffPress,'DisplayName','Differential'); end; ...
        try plot(ARSP.t,ARSP.RawPress ,'DisplayName','Raw'   ); end; ...
        try plot(ARSP.t,ARSP.Offset   ,'DisplayName','Offset'); end; ...
        ylabel('Pressure'); legend('-DynamicLegend');
    subplot(3,1,3); hold all; plot(ARSP.t,ARSP.Temp); ylabel('Air Temperature [ C ]'); xlabel('Time [ s ]');
end
%% ATT  - Attitude Estimate
if exist('ATT','var') && (plot_all || plot_ATT);
    freq = calc_data_frequency(ATT.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['ATT Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(3,1,1); hold all; ...
        try plot(ATT.t,ATT.DesRoll,'DisplayName','Commanded'); end; ...
        try plot(ATT.t,ATT.Roll,'DisplayName','Actual'); end; ...
        ylabel('Roll [ deg ]'); legend('-DynamicLegend'); ylim([-50 50]);
    subplot(3,1,2); hold all; ...
        try plot(ATT.t,ATT.DesPitch); end; ...
        try plot(ATT.t,ATT.Pitch); end; ...
        ylabel('Pitch [ deg ]'); ylim([-50 50]);
    subplot(3,1,3); hold all; ...
        try plot(ATT.t,unwrap_360(ATT.DesYaw)); end; ...
        try plot(ATT.t,unwrap_360(ATT.Yaw)); end; ...
        ylabel('Yaw [ deg ]');  xlabel('Time [ s ]');
end
%% BARO - Barometer
if exist('BARO','var') && (plot_all || plot_BARO);
    freq = calc_data_frequency(BARO.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['BARO Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(3,1,1); hold all; plot(BARO.t,BARO.Alt); ylabel('Altitude [ m ]');
    subplot(3,1,2); hold all; plot(BARO.t,BARO.Press); ylabel('Pressure [ Pa ]');
    subplot(3,1,3); hold all; plot(BARO.t,BARO.Temp); ylabel('Temperature [ C ]'); xlabel('Time [ s ]');
end
%% CMD  - TO DO
%% CTUN -
if exist('CTUN','var') && (plot_all || plot_CTUN);
    freq = calc_data_frequency(CTUN.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['CTUN Data - ',num2str(freq,'%.0f'),' Hz']);
    
    try % for a quad
        subplot(3,1,1); hold all; ...
            plot(CTUN.t,CTUN.ThrIn); ...
            plot(CTUN.t,CTUN.AngBst); ...
            plot(CTUN.t,CTUN.ThrOut); ...
            ylabel('Throttle [ - ]'); legend('ThrIn','AngBst','ThrOut');
        subplot(3,1,2); hold all; ...
            plot(CTUN.t,CTUN.BarAlt); ...
            plot(CTUN.t,CTUN.DSAlt); ...
            plot(CTUN.t,CTUN.SAlt); ...
            plot(CTUN.t,CTUN.Alt); ...
            ylabel('Alt [ m ]'); legend('BarAlt','DSonarAlt','SonarAlt','Alt');
        subplot(3,1,3); hold all; ...
            plot(CTUN.t,CTUN.DCRt); ...
            plot(CTUN.t,CTUN.CRt); ...
            ylabel('Climb Rate [ cm/s ]'); xlabel('Time [ s ]'); legend('Desired Climb Rate','Climb Rate');
    catch % for a plane
        subplot(3,1,1); hold all;...
            plot(CTUN.t,CTUN.NavRoll);...
            plot(CTUN.t,CTUN.Roll);...
            legend('NavRoll','Roll'); ylabel('Roll [ deg ]');
        subplot(3,1,2); hold all;...
            plot(CTUN.t,CTUN.NavPitch);...
            plot(CTUN.t,CTUN.Pitch);...
            legend('NavPitch','Pitch'); ylabel('Pitch [ deg ]'); xlabel('Time [ s ]');
        subplot(3,2,5); hold all;...
            plot(CTUN.t,CTUN.ThrOut);...
            ylabel('ThrOut [ % ]'); xlabel('Time [ s ]');
        subplot(3,2,6); hold all;...
            plot(CTUN.t,CTUN.RdrOut);...
            ylabel('RdrOut [ PWM ]');  xlabel('Time [ s ]');% I think
        
    end
end
%% CURR - Current
if exist('CURR','var') && (plot_all || plot_CURR);
    freq = calc_data_frequency(CURR.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['CURR Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(3,2,1); hold all; ...
        try plot(CURR.t,CURR.Throttle); catch; plot(CURR.t,CURR.Thr); end; ...
        ylabel('Throttle [ % ]');
    subplot(3,2,3); hold all; plot(CURR.t,CURR.Volt/100); ylabel('Volt [ V ]');
    subplot(3,2,5); hold all; plot(CURR.t,CURR.Curr/100); ylabel('Curr [ A ]'); xlabel('Time [ s ]');
    subplot(1,2,2); hold all; ...
        try    hAx = plotyy(CURR.t,CURR.Throttle,CURR.t,CURR.Curr.*CURR.Volt/1e4); ...
        catch; hAx = plotyy(CURR.t,CURR.Thr,CURR.t,CURR.Curr.*CURR.Volt/1e4); end; ...
        xlabel('Time [ s ]'); legend('Throttle','Power'); set(hAx,{'ycolor'},{'k';'k'}); ...
        set(hAx(1),'YTick',0:10:100);
        ylabel(hAx(1),'Throttle [ % ]'); ...
        ylabel(hAx(2),'Power [ W ]');
end
%% DU32 - TO DO
if exist('DU32','var')
    % http://copter.ardupilot.com/wiki/common-downloading-and-analyzing-data-logs-in-mission-planner/
    % https://github.com/diydrones/ardupilot/blob/master/ArduCopter/defines.h#L278
    
    for ii = 1:length(DU32.TimeUS)
        switch DU32.Id(ii)
            case 7 % bitmask of internal state
                b = de2bi(DU32.Value(ii,:)); % This converts the error code back into the bitmasks
                % Who knows though?
            case 9 % simple mode�s initial heading in centi-degrees
                
        end
    end
    
end
%% EKF1 -
if exist('EKF1','var') && (plot_all || plot_EKF1);
    freq = calc_data_frequency(EKF1.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['EKF1 Attitude - ',num2str(freq,'%.0f'),' Hz']);
    subplot(3,1,1); hold all; ...
        plot(EKF1.t,EKF1.Roll); ylabel('Roll [ deg ]'); ...
        subplot(3,1,2); hold all; ...
        plot(EKF1.t,EKF1.Pitch); ylabel('Pitch [ deg ]');
    subplot(3,1,3); hold all; ...
        plot(EKF1.t,EKF1.Yaw); ylabel('Yaw [ deg ]'); xlabel('Time [ s ]');
    
    figure(gcf+1); clf; hold all; set(gcf,'name',['EKF1 Velocity - ',num2str(freq,'%.0f'),' Hz']); ...
        plot(EKF1.t,EKF1.VN);  plot(EKF1.t,EKF1.VE); ...
        plot(EKF1.t,sqrt(EKF1.VN.^2+EKF1.VE.^2));...
        legend('V_{north}','V_{east}','V','location','best');...
        xlabel('Time [ s ]'); ylabel('Velocity [ m/s ]');
    
    figure(gcf+1); clf; hold all; set(gcf,'name',['EKF1 Position - ',num2str(freq,'%.0f'),' Hz']);...
        subplot(1,2,1); hold all; plot(EKF1.PE,EKF1.PN); axis equal; xlabel('East [ m ]'); ylabel('North [ m ]');...
        subplot(2,2,2); hold all; plot(EKF1.t,-EKF1.PD); ylabel('Altitude [ m ]');...
        subplot(2,2,4); hold all; plot(EKF1.t,-EKF1.VD); ylabel('Climb Rate [ m/s ]'); xlabel('Time [ s ]'); ...
        figure(15); clf; hold all; set(gcf,'name',['EKF1 Rates - ',num2str(freq,'%.0f'),' Hz']);
    
    figure(gcf+1); clf; hold all; set(gcf,'name',['EKF1 Rate - ',num2str(freq,'%.0f'),' Hz']); % maybe
    subplot(3,1,1); hold all; ...
        plot(EKF1.t,EKF1.GX*180/pi);  ylabel('Roll Rate [ deg/s ]'); ...
        subplot(3,1,2); hold all; ...
        plot(EKF1.t,EKF1.GY*180/pi); ylabel('Pitch Rate [ deg/s ]');
    subplot(3,1,3); hold all; ...
        plot(EKF1.t,EKF1.GZ*180/pi); ylabel('Yaw Rate [ deg/s ]'); xlabel('Time [ s ]');
end
%% EKF2 -
%     int8_t Ratio;  What is this?
if exist('EKF2','var') && (plot_all || plot_EKF2)
    freq = calc_data_frequency(EKF2.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['EKF1 Bias - ',num2str(freq,'%.0f'),' Hz']);
    plot(EKF2.t,EKF2.AZ1bias); plot(EKF2.t,EKF2.AZ2bias); legend('AZ1','AZ2');
    
    figure(gcf+1); clf; hold all; set(gcf,'name',['EKF1 Wind Estimate - ',num2str(freq,'%.0f'),' Hz']);
    plot(EKF2.t,EKF2.VWN); plot(EKF2.t,EKF2.VWE);
    
    figure(gcf+1); clf; hold all; set(gcf,'name',['EKF1 Magnetometer - ',num2str(freq,'%.0f'),' Hz']);
    subplot(3,2,1); plot(EKF2.t,EKF2.MN); ylabel('MagN');
    subplot(3,2,3); plot(EKF2.t,EKF2.ME); ylabel('MagE');
    subplot(3,2,5); plot(EKF2.t,EKF2.MD); ylabel('MagD'); xlabel('Time [ s ]');
    subplot(3,2,2); plot(EKF2.t,EKF2.MX); ylabel('MagX');
    subplot(3,2,4); plot(EKF2.t,EKF2.MY); ylabel('MagY');
    subplot(3,2,6); plot(EKF2.t,EKF2.MZ); ylabel('MagZ'); xlabel('Time [ s ]');
end
%% EKF3 -
if exist('EKF3','var') && (plot_all || plot_EKF3);
    freq = calc_data_frequency(EKF3.t);
    figure(gcf+1);clf; hold all; set(gcf,'name',['EKF3 Innovation - ',num2str(freq,'%.0f'),' Hz']);
    subplot(4,1,1); hold all; plot(EKF3.t,EKF3.IVN); plot(EKF3.t,EKF3.IVE); plot(EKF3.t,EKF3.IVD); legend('innovVN','innovVE','innovVD');
    subplot(4,1,2); hold all; plot(EKF3.t,EKF3.IPN); plot(EKF3.t,EKF3.IPE); plot(EKF3.t,EKF3.IPD); legend('innovPN','innovPE','innovPD');
    subplot(4,1,3); hold all; plot(EKF3.t,EKF3.IMZ); plot(EKF3.t,EKF3.IMY); plot(EKF3.t,EKF3.IMZ); legend('innovMX','innovMY','innovMZ');
    subplot(4,1,4); hold all; plot(EKF3.t,EKF3.IVT); legend('innovVT');
    
    %   uint64_t time_us;
    %     int16_t innovVN;
    %     int16_t innovVE;
    %     int16_t innovVD;
    %     int16_t innovPN;
    %     int16_t innovPE;
    %     int16_t innovPD;
    %     int16_t innovMX;
    %     int16_t innovMY;
    %     int16_t innovMZ;
    %     int16_t innovVT;
end
%% EKF4 -
if exist('EKF4','var') && (plot_all || plot_EKF4);
    freq = calc_data_frequency(EKF4.t);
    figure(gcf+1);clf; hold all; set(gcf,'name',['EKF4 Variance - ',num2str(freq,'%.0f'),' Hz']);
    subplot(4,2,1); hold all; plot(EKF4.t,EKF4.SV); plot(EKF4.t,EKF4.SP);legend('sqrtvarV','sqrtvarP','location','northWest');
    subplot(4,2,3); hold all; plot(EKF4.t,EKF4.SH); legend('sqrtvarH','location','northWest')
    subplot(4,2,2); hold all; plot(EKF4.t,EKF4.SMX); plot(EKF4.t,EKF4.SMY); plot(EKF4.t,EKF4.SMZ); legend('sqrtvarMX','sqrtvarMY','sqrtvarMZ','location','northWest');
    try subplot(4,2,5); hold all; plot(EKF4.t,EKF4.OFN); plot(EKF4.t,EKF4.OFE); legend('offsetNorth','offsetEast','location','northWest');
    catch;subplot(4,2,5); hold all; plot(EKF4.t,EKF4.OFN); plot(EKF4.t,EKF4.EFE); legend('offsetNorth','offsetEast','location','northWest'); end
    subplot(4,2,7); hold all; plot(EKF4.t,EKF4.SVT); legend('sqrtvarVT','location','northWest');
    subplot(4,2,4); hold all; plot(EKF4.t,EKF4.FS); legend('faults','location','northWest');
    subplot(4,2,6); hold all; plot(EKF4.t,EKF4.TS); legend('timeouts','location','northWest');
    subplot(4,2,8); hold all; plot(EKF4.t,EKF4.SS); legend('solution','location','northWest');
    %   uint64_t time_us;   TimeUS
    %     int16_t sqrtvarV; SV
    %     int16_t sqrtvarP; SP
    %     int16_t sqrtvarH; SH
    %     int16_t sqrtvarMX; SMX
    %     int16_t sqrtvarMY; SMY
    %     int16_t sqrtvarMZ;SMZ
    %     int16_t sqrtvarVT; SVT
    %     int8_t  offsetNorth; OFN
    %     int8_t  offsetEast; EFE
    %     uint8_t faults; FS
    %     uint8_t timeouts; TS
    %     uint16_t solution; SS
    %     uint16_t gps; Doesn't seem to be in there
end
%% ERR  - TO DO
if exist('ERR','var');
    fprintf('== ERRORS ==\n')
    % https://github.com/diydrones/ardupilot/blob/master/ArduCopter/defines.h#335
    % ERROR CODES
    % #define ERROR_SUBSYSTEM_MAIN                1
    % #define ERROR_SUBSYSTEM_RADIO               2
    % #define ERROR_SUBSYSTEM_COMPASS             3
    % #define ERROR_SUBSYSTEM_OPTFLOW             4
    % #define ERROR_SUBSYSTEM_FAILSAFE_RADIO      5
    % #define ERROR_SUBSYSTEM_FAILSAFE_BATT       6
    % #define ERROR_SUBSYSTEM_FAILSAFE_GPS        7   // not used
    % #define ERROR_SUBSYSTEM_FAILSAFE_GCS        8
    % #define ERROR_SUBSYSTEM_FAILSAFE_FENCE      9
    % #define ERROR_SUBSYSTEM_FLIGHT_MODE         10
    % #define ERROR_SUBSYSTEM_GPS                 11  // not used
    % #define ERROR_SUBSYSTEM_CRASH_CHECK         12
    % #define ERROR_SUBSYSTEM_FLIP                13
    % #define ERROR_SUBSYSTEM_AUTOTUNE            14
    % #define ERROR_SUBSYSTEM_PARACHUTE           15
    % #define ERROR_SUBSYSTEM_EKFCHECK            16
    % #define ERROR_SUBSYSTEM_FAILSAFE_EKFINAV    17
    % #define ERROR_SUBSYSTEM_BARO                18
    % #define ERROR_SUBSYSTEM_CPU                 19
    for ii = 1:length(ERR.TimeUS)
        fprintf('%.2f s - ',ERR.TimeUS(ii)/1e6);
        if ERR.ECode(ii) == 0
            fprintf('ERROR - ');
        elseif ERR.ECode(ii) == 2
            fprintf('FIXED - ');
        else
            warning('unknown code');
            return
        end
        
        switch ERR.Subsys(ii)
            case 16
                fprintf('EKF issue\n');
                
            otherwise
                warning('unknown error code %.0f\n',ERR.Subsys(ii));
                return
        end
    end
    fprintf('\n');
end
%% EV   - Event Number
% https://github.com/diydrones/ardupilot/blob/master/ArduCopter/defines.h#L278
if exist('EV','var');
    fprintf('== EVENTS ==\n');
    
    for ii = 1:length(EV.TimeUS)
        fprintf('%6.2f s - ',EV.TimeUS(ii)/1e6);
        switch EV.Id(ii)
            case 1; fprintf('DATA_MAVLINK_FLOAT\n');
            case 2; fprintf('DATA_MAVLINK_INT32\n');
            case 3; fprintf('DATA_MAVLINK_INT16\n');
            case 4; fprintf('DATA_MAVLINK_INT8\n');
            case 7; fprintf('DATA_AP_STATE\n');
            case 8; fprintf('DATA_SYSTEM_TIME_SET\n');
            case 9; fprintf('DATA_INIT_SIMPLE_BEARING\n');
            case 10; fprintf('DATA_ARMED\n');
            case 11; fprintf('DATA_DISARMED\n');
            case 15; fprintf('DATA_AUTO_ARMED\n');
            case 16; fprintf('DATA_TAKEOFF\n');
            case 17; fprintf('DATA_LAND_COMPLETE_MAYBE\n');
            case 18; fprintf('DATA_LAND_COMPLETE\n');
            case 28; fprintf('DATA_NOT_LANDED\n');
            case 19; fprintf('DATA_LOST_GPS\n');
            case 21; fprintf('DATA_FLIP_START\n');
            case 22; fprintf('DATA_FLIP_END\n');
            case 25; fprintf('DATA_SET_HOME\n');
            case 26; fprintf('DATA_SET_SIMPLE_ON\n');
            case 27; fprintf('DATA_SET_SIMPLE_OFF\n');
            case 29; fprintf('DATA_SET_SUPERSIMPLE_ON\n');
            case 30; fprintf('DATA_AUTOTUNE_INITIALISED\n');
            case 31; fprintf('DATA_AUTOTUNE_OFF\n');
            case 32; fprintf('DATA_AUTOTUNE_RESTART\n');
            case 33; fprintf('DATA_AUTOTUNE_SUCCESS\n');
            case 34; fprintf('DATA_AUTOTUNE_FAILED\n');
            case 35; fprintf('DATA_AUTOTUNE_REACHED_LIMIT\n');
            case 36; fprintf('DATA_AUTOTUNE_PILOT_TESTING\n');
            case 37; fprintf('DATA_AUTOTUNE_SAVEDGAINS\n');
            case 38; fprintf('DATA_SAVE_TRIM\n');
            case 39; fprintf('DATA_SAVEWP_ADD_WP\n');
            case 40; fprintf('DATA_SAVEWP_CLEAR_MISSION_RTL\n');
            case 41; fprintf('DATA_FENCE_ENABLE\n');
            case 42; fprintf('DATA_FENCE_DISABLE\n');
            case 43; fprintf('DATA_ACRO_TRAINER_DISABLED\n');
            case 44; fprintf('DATA_ACRO_TRAINER_LEVELING\n');
            case 45; fprintf('DATA_ACRO_TRAINER_LIMITED\n');
            case 46; fprintf('DATA_EPM_GRAB\n');
            case 47; fprintf('DATA_EPM_RELEASE\n');
            case 48; fprintf('DATA_EPM_NEUTRAL\n');
            case 49; fprintf('DATA_PARACHUTE_DISABLED\n');
            case 50; fprintf('DATA_PARACHUTE_ENABLED\n');
            case 51; fprintf('DATA_PARACHUTE_RELEASED\n');
            case 52; fprintf('DATA_LANDING_GEAR_DEPLOYED\n');
            case 53; fprintf('DATA_LANDING_GEAR_RETRACTED\n');
            case 54; fprintf('DATA_MOTORS_EMERGENCY_STOPPED\n');
            case 55; fprintf('DATA_MOTORS_EMERGENCY_STOP_CLEARED\n');
            case 56; fprintf('DATA_MOTORS_INTERLOCK_DISABLED\n');
            case 57; fprintf('DATA_MOTORS_INTERLOCK_ENABLED\n');
            case 58; fprintf('DATA_ROTOR_RUNUP_COMPLETE\n');
            case 59; fprintf('DATA_ROTOR_SPEED_BELOW_CRITICAL\n');
            case 60; fprintf('DATA_EKF_ALT_RESET\n');
                
            otherwise; error('Unknown');
        end
    end
    fprintf('\n');
end
%% GPA  - GPS reliability (maybe?)
if exist('GPA','var') && (plot_all || plot_GPA);
    freq = calc_data_frequency(GPS.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['GPA Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(2,2,1); hold all; plot(GPA.t,GPA.VDop); ylabel('VDop [ ? ]');
    subplot(2,2,2); hold all; plot(GPA.t,GPA.HAcc/100); ylabel('Horizontal Accuracy [ ? ]');
    subplot(2,2,3); hold all; plot(GPA.t,GPA.VAcc/100); ylabel('Vertical Accuracy [ ? ]');
    subplot(2,2,4); hold all; plot(GPA.t,GPA.SAcc/100); ylabel('Speed Accuracy [ ? ]');
end
%% GPS  - GPS Data
if exist('GPS','var') && (plot_all || plot_GPS);
    freq = calc_data_frequency(GPS.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['GPS Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(4,2,2); hold all; plot(GPS.t,GPS.NSats); ylabel('Satellites');
    subplot(4,2,4); hold all; plot(GPS.t,GPS.HDop); ylabel('HDOP'); ylim([0 5]);
    subplot(2,2,4); hold all; plot(GPS.t,GPS.Spd); ylabel('Speed [ m/s ]'); xlabel('Time [ s ]');
    subplot(1,2,1); hold all;...
        plot(GPS.Lng/1e7,GPS.Lat/1e7,'k','lineWidth',4);...
        plot(GPS.Lng/1e7,GPS.Lat/1e7,'w');...
        plot(GPS.Lng(2)/1e7,GPS.Lat(2)/1e7,'go');...
        plot(GPS.Lng(end)/1e7,GPS.Lat(end)/1e7,'ro');...
        ylabel('Latitude [ deg ]'); xlabel('Longitude [ deg ]'); axis equal; ...
        plot_google_map('MapType','hybrid','Refresh',1)
    % == Unplotted fields
    % GMS - GPS millisecond week
    % GWk - GPS week
    % RAlt - Relative altitude
    % Alt - Altitude
    % Spd - Ground speed
    % GCrs - Ground course heading [ centi-degrees ]
    % VZ - Velocity in Z
    % U - Used as primary sensor
end
%% IMU  - Inertial Data (IMU1)
if exist('IMU','var') && (plot_all || plot_IMU);
    freq = calc_data_frequency(IMU.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['IMU Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(2,1,1); hold all; ...
        plot(IMU.t,IMU.AccX); ...
        plot(IMU.t,IMU.AccY); ...
        plot(IMU.t,IMU.AccZ); ...
        ylabel('Accelerations [ m/s^2 ]'); xlabel('Time [ s ]');
    subplot(2,1,2); hold all; ...
        plot(IMU.t,IMU.GyrX*180/pi); ...
        plot(IMU.t,IMU.GyrY*180/pi); ...
        plot(IMU.t,IMU.GyrZ*180/pi); ...
        ylabel('Rates [ deg/s ]'); legend('X','Y','Z');
end
%% IMU2 - Inertial Data (IMU2)
if exist('IMU2','var') && (plot_all || plot_IMU2);
    freq = calc_data_frequency(IMU2.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['IMU2 Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(2,1,1); hold all; ...
        plot(IMU2.t,IMU2.AccX); ...
        plot(IMU2.t,IMU2.AccY); ...
        plot(IMU2.t,IMU2.AccZ); ...
        ylabel('Accelerations [ m/s^2 ]'); xlabel('Time [ s ]');
    subplot(2,1,2); hold all; ...
        plot(IMU2.t,IMU2.GyrX*180/pi); ...
        plot(IMU2.t,IMU2.GyrY*180/pi); ...
        plot(IMU2.t,IMU2.GyrZ*180/pi); ...
        ylabel('Rates [ deg/s ]'); legend('X','Y','Z');
end
%% MAG  - Magnetometer Data
if exist('MAG','var') && (plot_all || plot_MAG);
    freq = calc_data_frequency(MAG.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['MAG Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(3,1,1); hold all; ...
        try plot(MAG.t,MAG.MagX ,'DisplayName','Mag'); end; ...
        try plot(MAG.t,MAG.OfsX ,'DisplayName','Ofs'); end; ...
        try plot(MAG.t,MAG.MOfsX,'DisplayName','MOfs'); end; ...
        ylabel('X'); legend('-DynamicLegend');
    subplot(3,1,2); hold all; ...
        try plot(MAG.t,MAG.MagY ); end; ...
        try plot(MAG.t,MAG.OfsY ); end; ...
        try plot(MAG.t,MAG.MOfsY); end; ...
        ylabel('Y');
    subplot(3,1,3); hold all; ...
        try plot(MAG.t,MAG.MagZ ); end; ...
        try plot(MAG.t,MAG.OfsZ ); end; ...
        try plot(MAG.t,MAG.MOfsZ); end; ...
        ylabel('Z'); xlabel('Time [ s ]');
end
%% MAG2 - Magnetometer Data
if exist('MAG2','var') && (plot_all || plot_MAG2);
    freq = calc_data_frequency(MAG2.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['MAG2 Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(3,1,1); hold all; ...
        try plot(MAG2.t,MAG2.MagX ,'DisplayName','Mag'); end; ...
        try plot(MAG2.t,MAG2.OfsX ,'DisplayName','Ofs'); end; ...
        try plot(MAG2.t,MAG2.MOfsX,'DisplayName','MOfs'); end; ...
        ylabel('X'); legend('-DynamicLegend');
    subplot(3,1,2); hold all; ...
        try plot(MAG2.t,MAG2.MagY ); end; ...
        try plot(MAG2.t,MAG2.OfsY ); end; ...
        try plot(MAG2.t,MAG2.MOfsY); end; ...
        ylabel('Y');
    subplot(3,1,3); hold all; ...
        try plot(MAG2.t,MAG2.MagZ ); end; ...
        try plot(MAG2.t,MAG2.OfsZ ); end; ...
        try plot(MAG2.t,MAG2.MOfsZ); end; ...
        ylabel('Z'); xlabel('Time [ s ]');
end
%% MODE - Needs work
%% MOTB - Needs work
%% MSG  - System Messages
if exist('MSG','var');
    fprintf('== MESSAGES ==\n');
    for ii = 1:length(MSG.Message)
        try fprintf('%6.2f s - ',MSG.t(ii)); end; % Older log types don't have a time stamp for MSG
        fprintf('%s\n',MSG.Message{ii});
    end
    fprintf('\n');
    
    %% Could check this first to see if we're a plane, tracker, copter or rover
    % // @Param: SYSID_SW_TYPE
    % // @DisplayName: Software Type
    % // @Description: This is used by the ground station to recognise the software type (eg ArduPlane vs ArduCopter)
    % // @Values: 0:ArduPlane,4:AntennaTracker,10:Copter,20:Rover
    % // @User: Advanced
    % GSCALAR(software_type,  "SYSID_SW_TYPE",   Parameters::k_software_type),
end
%% NTUN - Navigational Tuning Data
if exist('NTUN','var') && (plot_all || plot_NTUN);
    freq = calc_data_frequency(NTUN.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['NTUN Data - ',num2str(freq,'%.0f'),' Hz']);
    
    try % Works for a quad
        subplot(3,2,1); hold all; plot(NTUN.t,NTUN.DPosX); plot(NTUN.t,NTUN.PosX); ylabel('X Position [ m ]');
        subplot(3,2,2); hold all; plot(NTUN.t,NTUN.DPosY); plot(NTUN.t,NTUN.PosY); ylabel('Y Position [ m ]'); legend('Commanded','Actual');
        subplot(3,2,3); hold all; plot(NTUN.t,NTUN.DVelX); plot(NTUN.t,NTUN.VelX); ylabel('X Velocity [ m/s ]');
        subplot(3,2,4); hold all; plot(NTUN.t,NTUN.DVelY); plot(NTUN.t,NTUN.VelY); ylabel('Y Velocity [ m/s ]');
        subplot(3,2,5); hold all; plot(NTUN.DPosX ,NTUN.DPosY); plot(NTUN.PosX  ,NTUN.PosY); axis equal; xlabel('X [ m ]'); ylabel('Y [ m ]');
        subplot(3,2,6); hold all; plot(NTUN.t,NTUN.DAccX); plot(NTUN.t,NTUN.DAccY); ylabel('Acceleration [ m/s^2 ]'); xlabel('Time [ s ]'); legend('AccX_c','AccY_c');
    catch % Will fail and resort to a plane
        subplot(2,2,1); hold all; plot(NTUN.t,NTUN.WpDist); ylabel('Waypoint Distance [ m ]');
        subplot(2,2,2); hold all; plot(NTUN.t,NTUN.TargBrg); plot(NTUN.t,NTUN.NavBrg); ylabel('Bearing [ deg ]'); legend('Target','Nav','location','best');
        subplot(2,2,3); hold all; plot(NTUN.t,NTUN.Alt/0.3048); xlabel(''); ylabel('Alt [ ft ]');
        subplot(2,2,4); hold all; plot(NTUN.t,NTUN.GSpdCM/100); plot(NTUN.t,NTUN.Arspd); ylabel('Speed [ m/s ]'); xlabel('Time [ s ]'); legend('V_{GND}','V_{AIR}','location','best');
    end
end
%% ORGN - Needs work
%% PARM - Not needed
% Can possibly use this to work out if it's a plane or a copter
%% PIDA - Needs work
% Altitude PID control??
%% PIDP - Needs work
% PID control contributions for pitch maybe??
if 0
    figure(); hold all
    plot(PIDP.t,PIDP.Des);
    plot(PIDP.t,PIDP.P);
    plot(PIDP.t,PIDP.I);
    plot(PIDP.t,PIDP.D);
    plot(PIDP.t,PIDP.FF);
    plot(PIDP.t,PIDP.AFF);
    legend('Des','P','I','D','FF','AFF');
end
%% PIDR - Needs work
% PIDs for roll
%% PIDY - Needs work
% PIDs for yaw
%% PM   - Performance Monitoring
if exist('PM','var') && (plot_all || plot_PM);
    freq = calc_data_frequency(PM.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['PM Data - ',num2str(freq,'%.1f'),' Hz']);
    subplot(3,2,1); hold all; plot(PM.t,PM.NLon); ylabel('Long Loops [ - ]');
    subplot(3,2,2); hold all; plot(PM.t,PM.NLoop); ylabel('N. Loops [ - ]');
    subplot(3,2,3); hold all; plot(PM.t,PM.MaxT); ylabel('Max Loop Time [ ? ]');
    subplot(3,2,4); hold all; plot(PM.t,PM.PMT); ylabel('PMT [ ? ]');
    subplot(3,2,5); hold all; plot(PM.t,PM.I2CErr); ylabel('I2C Errors [ - ]');
    subplot(3,2,6); hold all; plot(PM.t,PM.INSErr); ylabel('INS Errors [ - ]');
end
%% POS  - Needs work
if exist('POS','var') && (plot_all || plot_POS);
    freq = calc_data_frequency(POS.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['POS Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(1,2,1); hold all; plot(POS.Lng/1e7,POS.Lat/1e7); xlabel('Longitude [ deg ]'); ylabel('Latitude [ deg ]'); axis equal;
    subplot(2,2,2); hold all; plot(POS.t,POS.Alt); ylabel('Altitude ASL [ m ]');
    subplot(2,2,4); hold all; plot(POS.t,POS.RelAlt); ylabel('Relative Altitude [ m ]'); xlabel('Time [ s ]');
end
%% POWR - System Power Data
if exist('POWR','var') && (plot_all || plot_POWR);
    freq = calc_data_frequency(POWR.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['POWR Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(2,1,1); hold all; ...
        plot(POWR.t,POWR.Vcc); plot(POWR.t,POWR.VServo); ...
        legend('V_{cc}','V_{Servo}'); ylabel('Voltage [ V ]');
    subplot(2,1,2); hold all; plot(POWR.t,POWR.Flags); ylabel('Flags [ ? ]'); xlabel('Time [ s ]');
end
%% RAD  - Radio Data
if exist('RAD','var') && (plot_all || plot_RAD);
    freq = calc_data_frequency(RAD.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['RAD Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(3,1,1); hold all; plot(RAD.t,RAD.RSSI); plot(RAD.t,RAD.RemRSSI);...
        plot(RAD.t,RAD.Noise); plot(RAD.t,RAD.RemNoise); ...
        legend('RSSI','RemRSSI','Noise','RemNoise'); ylabel('Level');
    subplot(3,1,2); hold all; plot(RAD.t,RAD.TxBuf); ylabel('TxBuf');
    subplot(3,1,3); hold all; plot(RAD.t,RAD.RxErrors); plot(RAD.t,RAD.Fixed);  ylabel('Errors'); xlabel('Time [ s ]'); legend('RxErrors','Fixed');
end
%% RATE - Needs work
%% RCIN - RC In
if exist('RCIN','var') && (plot_all || plot_RCIN);
    freq = calc_data_frequency(RCIN.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['RCIN Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(2,1,1); hold all; plot(RCIN.t,RCIN.C1); plot(RCIN.t,RCIN.C2); plot(RCIN.t,RCIN.C3); plot(RCIN.t,RCIN.C4); ylabel('PWM In'); legend('1 - Aileron','2 - Elevator','3 - Throttle','4 - Rudder'); ylim([900 2000]);
    subplot(2,1,2); hold all; plot(RCIN.t,RCIN.C5); plot(RCIN.t,RCIN.C6); plot(RCIN.t,RCIN.C7); plot(RCIN.t,RCIN.C8); ylabel('PWM In'); legend('5','6','7','8'); ylim([900 2000]); xlabel('Time [ s ]');
end
%% RCOU - RC Out
if exist('RCOU','var') && (plot_all || plot_RCOU);
    freq = calc_data_frequency(RCOU.t);
    figure(gcf+1); clf; hold all; set(gcf,'name',['RCOU Data - ',num2str(freq,'%.0f'),' Hz']);
    subplot(2,1,1); hold all; plot(RCOU.t,RCOU.Ch1); plot(RCOU.t,RCOU.Ch2); plot(RCOU.t,RCOU.Ch3); plot(RCOU.t,RCOU.Ch4); ylabel('PWM Out'); legend('1','2','3','4'); ylim([900 2000]);
    subplot(2,1,2); hold all; plot(RCOU.t,RCOU.Ch5); plot(RCOU.t,RCOU.Ch6); plot(RCOU.t,RCOU.Ch7); plot(RCOU.t,RCOU.Ch8); ylabel('PWM Out'); legend('5','6','7','8'); ylim([900 2000]); xlabel('Time [ s ]');
end
%% STRT - Needs work
%% UBX1 - Needs work
%% UBX2 - Needs work
%% UBX3 - Needs work
%% VIBE Plot
% See http://copter.ardupilot.com/wiki/common-measuring-vibration/
if exist('VIBE','var') && (plot_all || plot_VIBE);
    freq = calc_data_frequency(VIBE.t);
    figure(gcf+1);clf; hold all; set(gcf,'name',['VIBE - ',num2str(freq,'%.0f'),' Hz']);
    subplot(2,1,1); hold all; ...
        plot(VIBE.t,VIBE.VibeX);...
        plot(VIBE.t,VIBE.VibeY);...
        plot(VIBE.t,VIBE.VibeZ);...
        ylabel('Vibration [ m/s ]'); legend('X','Y','Z');
    subplot(2,1,2); hold all; ...
        plot(VIBE.t,VIBE.Clip0);...
        plot(VIBE.t,VIBE.Clip1);...
        plot(VIBE.t,VIBE.Clip2);...
        ylabel('Clips [ - ]'); xlabel('Time [ s ]');
    
end

%% ==== Comparisons
%% Altitude
figure(100); clf; hold all; set(gcf,'name','Altitude Estimates Comparison');
try plot(BARO.t,BARO.Alt, 'DisplayName','BARO'); end
try plot(GPS.t,GPS.RAlt, 'DisplayName','GPS'); end
try plot(EKF1.t,-EKF1.PD, 'DisplayName','EKF'); end
try plot(CTUN.t,CTUN.Alt,':', 'DisplayName','Estimated'); end
% plot(CTUN.t,CTUN.SAlt); % can add this later if I ever use one
xlabel('Time [ s ]'); ylabel('Altitude [ m ]');
legend('-DynamicLegend');
%% Roll
figure(gcf+1); clf; hold all; set(gcf,'name','Roll Estimates Comparison');
try plot(ATT.t,ATT.Roll, 'DisplayName','ATT'); end
try plot(AHR2.t,AHR2.Roll, 'DisplayName','AHR2'); end
try plot(EKF1.t,EKF1.Roll, 'DisplayName','EKF'); end
xlabel('Time [ s ]'); ylabel('Roll [ deg ]');
legend('-DynamicLegend');
%% Pitch
legend_string = {};
figure(gcf+1); clf; hold all; set(gcf,'name','Pitch Estimates Comparison');
try plot(ATT.t,ATT.Pitch); legend_string{end+1} = 'ATT'; end
try plot(AHR2.t,AHR2.Pitch); legend_string{end+1} = 'AHR2'; end
try plot(EKF1.t,EKF1.Pitch); legend_string{end+1} = 'EKF'; end
xlabel('Time [ s ]'); ylabel('Pitch [ deg ]');
legend(legend_string);
%% Yaw
legend_string = {};
figure(gcf+1); clf; hold all; set(gcf,'name','Yaw Estimates Comparison');
subplot(2,1,1); hold all; ...
    try plot(ATT.t ,unwrap_360(ATT.Yaw) ); legend_string{end+1} = 'ATT'; end; ...
    try plot(AHR2.t,unwrap_360(AHR2.Yaw)); legend_string{end+1} = 'AHR2'; end; ...
    try plot(EKF1.t,unwrap_360(EKF1.Yaw)); legend_string{end+1} = 'EKF'; end; ...
    legend(legend_string); ylabel('Yaw [ deg ]');
subplot(2,1,2); hold all; ...
    try plot(ATT.t,unwrap_360(ATT.Yaw)-interp1(AHR2.t,unwrap_360(AHR2.Yaw),ATT.t)); end; ...
    try plot(ATT.t,unwrap_360(ATT.Yaw)-interp1(EKF1.t,unwrap_360(EKF1.Yaw),ATT.t)); end; ...
    legend('ATT - AHR2','ATT - EKF1'); ylabel('Residual [ deg ]'); xlabel('Time [ s ]');

%% Accelerations
figure(gcf+1); clf; hold all; set(gcf,'name','Acceleration Comparison'); % maybe
subplot(3,1,1); hold all; title('Accelerations'); ...
    try plot(IMU2.t,IMU2.AccX, 'DisplayName','IMU2'); end; ...
    try plot(IMU.t,IMU.AccX, 'DisplayName','IMU'); end; ...
    ylabel('Acc\_X [ m/s^2 ]'); ...
    legend('-DynamicLegend','location','northEast');
subplot(3,1,2); hold all; ...
    try plot(IMU2.t,IMU2.AccY); end; ...
    try plot(IMU.t,IMU.AccY); end; ...
    ylabel('Acc\_Y [ m/s^2 ]');
subplot(3,1,3); hold all; ...
    try plot(IMU2.t,IMU2.AccZ); end; ...
    try plot(IMU.t,IMU.AccZ); end; ...
    ylabel('Acc\_Z [ m/s^2 ]');
%% Rates
figure(gcf+1); clf; hold all; set(gcf,'name','Rate Estimate Comparison'); % maybe
subplot(3,2,1); hold all; title('Rates'); ...
    try plot(RATE.t,RATE.R/100, 'DisplayName','RATE'); end; ...
    try plot(IMU.t,IMU.GyrX*180/pi, 'DisplayName','IMU'); end; ...
    try plot(IMU2.t,IMU2.GyrX*180/pi, 'DisplayName','IMU2'); end; ...
    ylabel('Roll Rate [ deg/s ]'); ...
    legend('-DynamicLegend','location','northEast');
subplot(3,2,3); hold all; ...
    try plot(RATE.t,RATE.P/100); end; ...
    try plot(IMU.t,IMU.GyrY*180/pi); end; ...
    try plot(IMU2.t,IMU2.GyrY*180/pi); end; ...
    ylabel('Pitch Rate [ deg/s ]');
subplot(3,2,5); hold all; ...
    try plot(RATE.t,RATE.Y/100); end; ...
    try plot(IMU.t,IMU.GyrZ*180/pi); end; ...
    try plot(IMU2.t,IMU2.GyrZ*180/pi); end; ...
    ylabel('Yaw Rate [ deg/s ]'); xlabel('Time [ s ]');
% Biases
subplot(3,2,2); hold all; title('EKF Gyro Biases (maybe???)'); ...
    try plot(EKF1.t,EKF1.GX*180/pi); end; ...
    ylabel('Rate.R - GyrX [ deg/s ]');
subplot(3,2,4); hold all; ...
    try plot(EKF1.t,EKF1.GY*180/pi); end; ...
    ylabel('Rate.P - GyrY [ deg/s ]');
subplot(3,2,6); hold all; ...
    try plot(EKF1.t,EKF1.GZ*180/pi); end; ...
    ylabel('Rate.Y - GyrZ [ deg/s ]'); xlabel('Time [ s ]');
%%
try % Being lazy, need to fix
    figure(gcf+1); clf; hold all; set(gcf,'name','Rate Residuals');
    subplot(3,1,1); hold all; ...
        plot(RATE.t,interp1(IMU.t,IMU.GyrX*180/pi,RATE.t)-RATE.R/100);...
        plot(RATE.t,interp1(IMU2.t,IMU2.GyrX*180/pi,RATE.t)-RATE.R/100);...
        ylabel('RateX\_(Measured - Estimate) [ deg/s ]'); legend('IMU','IMU2');
    subplot(3,1,2); hold all; ...
        plot(RATE.t,interp1(IMU.t,IMU.GyrY*180/pi,RATE.t)-RATE.P/100);...
        plot(RATE.t,interp1(IMU2.t,IMU2.GyrY*180/pi,RATE.t)-RATE.P/100);...
        ylabel('RateT\_(Measured - Estimate) [ deg/s ]');
    subplot(3,1,3); hold all; ...
        plot(RATE.t,interp1(IMU.t,IMU.GyrZ*180/pi,RATE.t)-RATE.Y/100);...
        plot(RATE.t,interp1(IMU2.t,IMU2.GyrZ*180/pi,RATE.t)-RATE.Y/100);...
        ylabel('RateZ\_(Measured - Estimate) [ deg/s ]'); xlabel('Time [ s ]');
    
    %% Magnetometer Data
    figure(gcf+1); clf; hold all; set(gcf,'name','MAG Comparison Data');
    subplot(3,2,1); hold all;...
        plot(MAG.t,MAG.MagX, 'DisplayName','MAG'); ...
        plot(MAG2.t,MAG2.MagX, 'DisplayName','MAG2'); ...
        ylabel('X'); legend('-DynamicLegend');
    subplot(3,2,3); hold all;...
        plot(MAG.t,MAG.MagY); ...
        plot(MAG2.t,MAG2.MagY); ...
        ylabel('Y');
    subplot(3,2,5); hold all;...
        plot(MAG.t,MAG.MagZ); ...
        plot(MAG2.t,MAG2.MagZ); ...
        ylabel('Z'); xlabel('Time [ s ]');
    % Difference
    subplot(3,2,2); hold all;...
        plot(MAG2.t,MAG2.MagX-interp1(MAG.t,MAG.MagX,MAG2.t), 'DisplayName','MAG2 - MAG'); ...
        ylabel('X'); legend('-DynamicLegend'); % will add MAG3-MAG when I have 3 magnetometers
    subplot(3,2,4); hold all;...
        plot(MAG2.t,MAG2.MagY-interp1(MAG.t,MAG.MagY,MAG2.t)); ...
        ylabel('Y');
    subplot(3,2,6); hold all;...
        plot(MAG2.t,MAG2.MagZ-interp1(MAG.t,MAG.MagZ,MAG2.t)); ...
        ylabel('Z'); xlabel('Time [ s ]');
end
%% ==== Set axes
if ~exist('xlims','var'); xlims = 0; end;
if length(xlims) == 2; fprintf('\nApplying x-axis limits\n'); end
if grid_on; fprintf('Turning on grids\n'); end

% Find all the open figures
figures = findall(0,'type','figure');

% Loop through each of the figures
for ii = 1:length(figures)
    % Find all the subfigures for that figure
    subfigures = get(figures(ii),'Children');
    
    % Loop through each of the subfigures
    for jj = 1:length(subfigures)
        % Get the xlabel
        a = get(subfigures(jj),'xlabel'); x_label = get(a,'string');
        
        % Turn on grid if requested
        if grid_on
            set(subfigures(jj),'GridLineStyle',':');
            grid(subfigures(jj),'on');
        end
        
        % If the xlabel is empty or << Time [ s ] >> set the axis (if
        % requested)
        if length(xlims) == 2;
            if strcmp(x_label,'Time [ s ]') || isempty(x_label)
                % For some reason the legend stuffs up when the x-limits
                % are changed in this way.  Therefore we're going to save
                % the legend string
                legend_string = get(legend(subfigures(jj)),'String');
                
                set(subfigures(jj),'xlim',xlims);
                
                % Re-create the legend
                if ~isempty(legend_string)
                    legend(legend(subfigures(jj)),legend_string);
                end
            end
        end
    end
end

%% Finish everything up
close(1); % Closes figure 1 which gets created at the start
return

%% Visualisation of the flight
h = Aero.Animation;
h.FramesPerSecond = 10;
h.TimeScaling = 1;

idx2 = h.createBody('pa24-250_blue.ac','Ac3d');

show_time = [340 380];
locs = find(ATT.t>show_time(1) & ATT.t<show_time(2));

fltdata.time = ATT.t(locs);
fltdata.X = zeros(size(ATT.t(locs)));
fltdata.Y = zeros(size(ATT.t(locs)));
fltdata.Z = zeros(size(ATT.t(locs)));
fltdata.phi = ATT.Roll(locs)/57.7;
fltdata.theta = ATT.Pitch(locs)/57.7;
fltdata.psi = ATT.Yaw(locs)/57.7;
% load fltdata

h.Bodies{1}.TimeseriesReadFcn = @CustomReadBodyTSData;
h.Bodies{1}.TimeSeriesSource = fltdata;
h.Bodies{1}.TimeSeriesSourceType = 'Custom';

h.show();
h.play();
