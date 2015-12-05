function clean_PX4_file(PX4_file)
% File for cleaning all the weird stuff out of the log files.  Going to be
% a work in progress

if ~nargin
    close all
    clear all
    clc
    
    PX4_file = 'write_off_flight.mat';
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

%% Save the file
% Save data
save_list = [];
for ii = 1:length(list_of_variables)
    save_list = [save_list,'''',list_of_variables{ii},''','];
end

keyboard
% Save the file as the time and date of the first GPS signal if possible,
% otherwise save as original name.

eval(['save(''',PX4_file,''',',save_list(1:end-1),');']);

return
