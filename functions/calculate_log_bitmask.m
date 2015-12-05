% Calculate log bitmask
% From defines.h
close all
clear all
clc


bitmask( 1) = 1; % #define MASK_LOG_ATTITUDE_FAST          (1<<0)
bitmask( 2) = 0; % #define MASK_LOG_ATTITUDE_MED           (1<<1)
bitmask( 3) = 1; % #define MASK_LOG_GPS                    (1<<2)
bitmask( 4) = 1; % #define MASK_LOG_PM                     (1<<3)
bitmask( 5) = 1; % #define MASK_LOG_CTUN                   (1<<4)
bitmask( 6) = 1; % #define MASK_LOG_NTUN                   (1<<5)
bitmask( 7) = 0; % #define MASK_LOG_RCIN                   (1<<6)
bitmask( 8) = 1; % #define MASK_LOG_IMU                    (1<<7)
bitmask( 9) = 1; % #define MASK_LOG_CMD                    (1<<8)
bitmask(10) = 1; % #define MASK_LOG_CURRENT                (1<<9)
bitmask(11) = 0; % #define MASK_LOG_RCOUT                  (1<<10)
bitmask(12) = 0; % #define MASK_LOG_OPTFLOW                (1<<11)
bitmask(13) = 0; % #define MASK_LOG_PID                    (1<<12)
bitmask(14) = 1; % #define MASK_LOG_COMPASS                (1<<13)
bitmask(15) = 1; % #define MASK_LOG_INAV                   (1<<14) // deprecated
bitmask(16) = 0; % #define MASK_LOG_CAMERA                 (1<<15)
bitmask(17) = 1; % #define MASK_LOG_WHEN_DISARMED          (1UL<<16)
bitmask(18) = 1; % #define MASK_LOG_MOTBATT                (1UL<<17)
bitmask(19) = 1; % #define MASK_LOG_IMU_FAST               (1UL<<18)
bitmask(20) = 0; % #define MASK_LOG_IMU_RAW                (1UL<<19)
bitmask(21) = 0; % #define MASK_LOG_ANY                    0xFFFF

bitmask = num2str((bitmask'));
bin2dec(bitmask')


% De-bitmask a log
bitmask = 176125
dec2bin(bitmask)

