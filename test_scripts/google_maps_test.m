% Google maps test
close all
clear all
clc


file = 'write_off_flight.mat';

file = '6.mat';

% clean_PX4_file('6.mat');

% Load file
load(file);

% Plot Course

figure(); hold all; ...
    plot(GPS.Lng/1e7,GPS.Lat/1e7,'w','lineWidth',3);...
    plot(GPS.Lng/1e7,GPS.Lat/1e7,'b','lineWidth',1);...
    


    plot(GPS.Lng(2)/1e7,GPS.Lat(2)/1e7,'o');...
    plot(GPS.Lng(end)/1e7,GPS.Lat(end)/1e7,'o');...
%     xlabel('Longitude [ deg ]'); ylabel('Latitude [ deg ]'); axis equal;...
set(gca,'XTickLabel',''); set(gca,'YTickLabel','');...
plot_google_map('MapType','hybrid','Refresh',1);

return

%% Base code supplied in documentation
lat = [48.8708 51.5188 41.9260 40.4312 52.523 37.982]; 
lon = [2.4131 -0.1300 12.4951 -3.6788 13.415 23.715]; 
plot(lon,lat,'.r','MarkerSize',20) 
plot_google_map
return
