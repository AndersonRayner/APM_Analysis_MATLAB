function convert_PX4_log(log_file)
%% Test script using Python Script
if ~nargin
    close all
    clear all
    clc
    
    convert_PX4_log('17.bin');
    return
end

%% Make the CSV
make_string = ['python sdlog2_dump.py "',log_file,'" -f "data.csv" -t"TIME" -d"," -n""'];

fprintf('Writing the CSV file.  This could take a bit of time.\n'); tic;
% system('python sdlog2_dump.py "17.bin" -f "data.csv" -t"TIME" -d"," -n""');
system(make_string);
fprintf('\tConverted .bin to .csv in %.2f s\n',toc);

%% Import the data
% use import data to work out formatSpec
fprintf('Importing data\n'); tic;
a = importdata('.\data.csv');

formatSpec = '';
for ii = 1:length(a.textdata)
    formatSpec = [formatSpec,'%s'];
end
formatSpec = [formatSpec,'%[^\n\r]'];

% Other stuff (doesn't change)
filename = '.\data.csv';
delimiter = ',';
startRow = 1;

% use textscan to get the data
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);
fprintf('\tImport data took %.2f s\n',toc);

%% Convert data to something useful
% first entry in each cell contains the name of the function
fprintf('Converting to something useful\n'); tic;
save_string = '';
for ii = 4:length(dataArray)-1 % don't need the PARMs, last one is a dud
    
    % Calculate log entry name
    log_name = dataArray{ii}(1); log_name = log_name{1};
    log_name = strrep(log_name, '_', '.');
    
    % Check if used by working out average nans
    data = str2double(dataArray{ii}(2:end));
    if mean(isnan(data)) < 0.1
        
        % Make variable
        % fprintf('%s\n',log_name);
        s = sprintf('%s = data;',log_name);
        eval(s);
        
        % String of variables to save
        save_string = [save_string,',',log_name];
    end
end
fprintf('\tConversion took took %.2f s\n',toc);

%% Save the file
save('test.mat',save_string(2:end));
keyboard
return
