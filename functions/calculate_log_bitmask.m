% Calculate log bitmask
% data from defines.h.  Hopefully this doesn't change that often.
close all
clear all
clc

%% calculate a log bitmask
bitmask( 1) = 1; % #define MASK_LOG_ATTITUDE_FAST          (1<<0)
bitmask( 2) = 0; % #define MASK_LOG_ATTITUDE_MED           (1<<1)
bitmask( 3) = 1; % #define MASK_LOG_GPS                    (1<<2)
bitmask( 4) = 1; % #define MASK_LOG_PM                     (1<<3)
bitmask( 5) = 1; % #define MASK_LOG_CTUN                   (1<<4)
bitmask( 6) = 1; % #define MASK_LOG_NTUN                   (1<<5)
bitmask( 7) = 1; % #define MASK_LOG_RCIN                   (1<<6)
bitmask( 8) = 1; % #define MASK_LOG_IMU                    (1<<7)
bitmask( 9) = 1; % #define MASK_LOG_CMD                    (1<<8)
bitmask(10) = 1; % #define MASK_LOG_CURRENT                (1<<9)
bitmask(11) = 1; % #define MASK_LOG_RCOUT                  (1<<10)
bitmask(12) = 0; % #define MASK_LOG_OPTFLOW                (1<<11)
bitmask(13) = 0; % #define MASK_LOG_PID                    (1<<12)
bitmask(14) = 1; % #define MASK_LOG_COMPASS                (1<<13)
bitmask(15) = 1; % #define MASK_LOG_INAV                   (1<<14) // deprecated
bitmask(16) = 0; % #define MASK_LOG_CAMERA                 (1<<15)
bitmask(17) = 1; % #define MASK_LOG_WHEN_DISARMED          (1UL<<16)
bitmask(18) = 1; % #define MASK_LOG_MOTBATT                (1UL<<17)
bitmask(19) = 1; % #define MASK_LOG_IMU_FAST               (1UL<<18)
bitmask(20) = 1; % #define MASK_LOG_IMU_RAW                (1UL<<19)
bitmask(21) = 0; % #define MASK_LOG_ANY                    0xFFFF

bitmask = fliplr(bitmask);
bitmask = num2str(bitmask');

fprintf('calculated LOG_BITMASK = %d\n\n',bin2dec(bitmask'));


%% De-bitmask a log
bitmask = 1009661;  % Bitmask to work out what fields were being logged.

data = [{'MASK_LOG_ATTITUDE_FAST'},...      (1<<0)
    {'MASK_LOG_ATTITUDE_MED'},...           (1<<1)
    {'MASK_LOG_GPS'},...                    (1<<2)
    {'MASK_LOG_PM'},...                     (1<<3)
    {'MASK_LOG_CTUN'},...                   (1<<4)
    {'MASK_LOG_NTUN'},...                   (1<<5)
    {'MASK_LOG_RCIN'},...                   (1<<6)
    {'MASK_LOG_IMU'},...                    (1<<7)
    {'MASK_LOG_CMD'},...                    (1<<8)
    {'MASK_LOG_CURRENT'},...                (1<<9)
    {'MASK_LOG_RCOUT'},...                  (1<<10)
    {'MASK_LOG_OPTFLOW'},...                (1<<11)
    {'MASK_LOG_PID'},...                    (1<<12)
    {'MASK_LOG_COMPASS'},...                (1<<13)
    {'MASK_LOG_INAV'},...                   (1<<14) // deprecated
    {'MASK_LOG_CAMERA'},...                 (1<<15)
    {'MASK_LOG_WHEN_DISARMED'},...          (1UL<<16)
    {'MASK_LOG_MOTBATT'},...                (1UL<<17)
    {'MASK_LOG_IMU_FAST'},...               (1UL<<18)
    {'MASK_LOG_IMU_RAW'}...                 (1UL<<19)
    ] ;
    
% Convert bitmask from dec to bin
log_bitmask = dec2bin(bitmask);

% Print results
fprintf('Logging\n')
for ii = 1:length(log_bitmask)
   if strcmp(log_bitmask(end+1-ii),'1');
       fprintf('\t%s\n',data{ii});
   end
end

return
