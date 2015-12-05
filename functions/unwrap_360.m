function output = unwrap_360(input)
% Unwraps data that has been wrapped between 0 and 360.

if ~nargin
close all
clear all
clc

file = 'marulan_quad_flight.mat';
load(file);

input = ATT.Yaw(1:end);
figure(1); clf; hold all;
plot(input);
end

for ii = 2:length(input)
    if (input(ii)-input(ii-1))>270
        input(ii:end) = input(ii:end)-360;  
    elseif (input(ii)-input(ii-1))<-270
        input(ii:end) = input(ii:end)+360;
    end
end

output = input;

if ~nargin
    plot(input);
    legend('old','fixed');
end

return
end