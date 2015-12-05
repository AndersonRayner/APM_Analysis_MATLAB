function output = unwrap_360(input)
% close all
% clear all
% clc
% 
% file = 'marulan_quad_flight.mat';
% load(file);
% 
% input = ATT.Yaw(1:end);
% figure(1); clf; hold all;
% plot(input);


for ii = 2:length(input)
    if (input(ii)-input(ii-1))>270
        input(ii:end) = input(ii:end)-360;  
    elseif (input(ii)-input(ii-1))<-270
        input(ii:end) = input(ii:end)+360;
    end
end

output = input;
% plot(input);
% legend('old','fixed');

return
end