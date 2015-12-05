function output = unwrap_180(input)
% Unwraps data that has been wrapped between 0 and 180.

if ~nargin
    close all
    clear all
    clc
    
    file = 'bwb_flight.tlog.mat';
    
    load(file);
    
    input = direction_mavlink_wind_t(:,2);
    figure(1); clf; hold all;
    plot(input);
end

 
for ii = 2:length(input)
    if (input(ii)-input(ii-1))>135
%         plot(ii,input(ii),'or');
        input(ii:end) = input(ii:end)-180;  
        
    elseif (input(ii)-input(ii-1))<-135
%         plot(ii,input(ii),'xr');
        input(ii:end) = input(ii:end)+180;
    end
end

output = input;

if ~nargin
    plot(input);
    legend('old','fixed');
end

return
end