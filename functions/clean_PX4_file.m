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

load(PX4_file);

list_of_variables = who;
list_of_variables = list_of_variables(~strcmp(list_of_variables,'PX4_file')); % Remove PX4_file out of the list

%% Remove ID, size and format fields
for ii = 1:length(list_of_variables)
    try
        eval([list_of_variables{ii} ' = rmfield(',list_of_variables{ii},',''ID'');']);
        eval([list_of_variables{ii} ' = rmfield(',list_of_variables{ii},',''size'');']);
        eval([list_of_variables{ii} ' = rmfield(',list_of_variables{ii},',''format'');']);
    catch
        fprintf('ID, size and format fields already removed from %s\n',list_of_variables{ii});
    end
end

%% Create a time vector in seconds
for ii = 1:length(list_of_variables)
    eval(['if isfield(',list_of_variables{ii},',''TimeUS''); ',list_of_variables{ii},'.t = ',list_of_variables{ii},'.TimeUS/1e6; end;']); % For when time is in us
    eval(['if isfield(',list_of_variables{ii},',''TimeMS''); ',list_of_variables{ii},'.t = ',list_of_variables{ii},'.TimeMS/1e3; end;']); % for when time is in ms
end

%% Remove 0 Lat and Lng fields (set to NaN)
for ii = 1:length(list_of_variables)
    eval(['if isfield(',list_of_variables{ii},',''Lat''); ',list_of_variables{ii},'.Lat(',list_of_variables{ii},'.Lat == 0) = nan; end;']);
    eval(['if isfield(',list_of_variables{ii},',''Lng''); ',list_of_variables{ii},'.Lng(',list_of_variables{ii},'.Lng == 0) = nan; end;']);
end

%% Remove high (>5) HDOP Lat and Lng fields (set to NaN)
% undecided if a good idea

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

return
