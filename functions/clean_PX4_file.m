function clean_PX4_file(PX4_file)
% File for cleaning all the weird stuff out of the log files.  Going to be
% a work in progress

if ~nargin
    close all
    clear all
    clc
    
    PX4_file = './../data/27.mat';
    clean_PX4_file(PX4_file);
    
    return
    
end

fprintf('Cleaning %s\n',PX4_file);
load(PX4_file);

list_of_variables = who;
list_of_variables = list_of_variables(~strcmp(list_of_variables,'PX4_file')); % Remove PX4_file out of the list

%% Remove LineNo, ID, size and format fields
for ii = 1:length(list_of_variables)
    try eval([list_of_variables{ii} ' = rmfield(',list_of_variables{ii},',''ID'');']); end
    try eval([list_of_variables{ii} ' = rmfield(',list_of_variables{ii},',''size'');']); end
    try eval([list_of_variables{ii} ' = rmfield(',list_of_variables{ii},',''format'');']); end
    try eval([list_of_variables{ii} ' = rmfield(',list_of_variables{ii},',''LineNo'');']); end
end

%% Create a time vector in seconds
for ii = 1:length(list_of_variables)
    eval(['if isfield(',list_of_variables{ii},',''TimeUS''); ',list_of_variables{ii},'.t = ',list_of_variables{ii},'.TimeUS/1e6; end;']); % For when time is in us
    eval(['if isfield(',list_of_variables{ii},',''TimeMS''); ',list_of_variables{ii},'.t = ',list_of_variables{ii},'.TimeMS/1e3; end;']); % for when time is in ms
    % Print freqency of data
    try; eval(['fprintf(''\tDetected %4s at %3.0f Hz\n'',''',list_of_variables{ii},''',calc_data_frequency(',list_of_variables{ii},'.t));']); end
end

%% Remove 0 Lat and Lng fields (set to NaN)
for ii = 1:length(list_of_variables)
    eval(['if isfield(',list_of_variables{ii},',''Lat''); ',list_of_variables{ii},'.Lat(',list_of_variables{ii},'.Lat == 0) = nan; end;']);
    eval(['if isfield(',list_of_variables{ii},',''Lng''); ',list_of_variables{ii},'.Lng(',list_of_variables{ii},'.Lng == 0) = nan; end;']);
end

%% Remove high (>20) HDOP Lat and Lng fields (set to NaN)
% undecided if a good idea
for ii = 1:length(list_of_variables)
    eval(['if isfield(',list_of_variables{ii},',''HDop''); ',list_of_variables{ii},'.Lat(',list_of_variables{ii},'.HDop > 20) = nan; end;']);
    eval(['if isfield(',list_of_variables{ii},',''HDop''); ',list_of_variables{ii},'.Lng(',list_of_variables{ii},'.HDop > 20) = nan; end;']);
end

%% Clean up the RPM data
for ii = 1:length(list_of_variables)
    temp = list_of_variables{ii};
    eval(['if isfield(',temp,',''rpm1''); ',temp,'.rpm1 = clean_rpm(',temp,'.t,',temp,'.rpm1); end;']);
    eval(['if isfield(',temp,',''rpm2''); ',temp,'.rpm2 = clean_rpm(',temp,'.t,',temp,'.rpm2); end;']);
    eval(['if isfield(',temp,',''rpm3''); ',temp,'.rpm3 = clean_rpm(',temp,'.t,',temp,'.rpm3); end;']);
    eval(['if isfield(',temp,',''rpm4''); ',temp,'.rpm4 = clean_rpm(',temp,'.t,',temp,'.rpm4); end;']);
end
% keyboard
%% Save the file
% Save data
save_list = [];
for ii = 1:length(list_of_variables)
    save_list = [save_list,'''',list_of_variables{ii},''','];
end

% WORK IN PROGRESS
% Save the file as the time and date of the first GPS signal if possible,
% otherwise save as original name.
%     GPS.GMS - Milliseconds since start of GPS week (00:00 Sunday)
%     GPS.GWk - Full GPS weeks since epoch (January 6, 1980)

% Aiming for about 16/11/2015, around 4 pm perhaps (0500 GMT) using
%    GPS.GMS = 115450400;
%    GPS.GWk = 1871;

% Then how do you get it local time? Could try something like datestr(now)
% which is in local time

eval(['save(''',PX4_file,''',',save_list(1:end-1),');']);
fprintf('Done!\n')
return
end

function rpm = clean_rpm(t,rpm)
% Cleans the RPM data up

slope_limit = 50000;
slope = nan(size(rpm));

for ii = 5:length(t)-5
    slope(ii) = (rpm(ii)-rpm(ii-1))/(t(ii)-t(ii-1));
    if abs(slope(ii))>slope_limit
        rpm(ii) = (rpm(ii+1)+rpm(ii-1))/2;
    end
end

return
end
