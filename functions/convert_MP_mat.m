function convert_MP_mat(file)
% A function for converting the matrix based .mat files produced
% by MissionPlanner into the struct based .mat files I use here.

if ~nargin
close all
clear all
clc

file = './data/3dr_aero.bin-315526.mat';
convert_MP_mat(file)

end

%% Load data
data = load(file);

%% Process data
% Can use the << Seen >> field to know which data to operate on
for ii = 1:length(data.Seen)
    fprintf('Converting %s\n',data.Seen{ii});
    
    eval(sprintf('labels = data.%s_label;',data.Seen{ii}));
    for jj = 1:length(labels)
        eval(sprintf('%s.%s = data.%s(:,%d);',data.Seen{ii},labels{jj},data.Seen{ii},jj)); 
    end
end

%% Save the data
save_list = [];
for ii = 1:length(data.Seen)
        save_list = [save_list,'''',data.Seen{ii},''','];
end
eval(['save(''',file(1:end-4),'-new.mat'',',save_list(1:end-1),');']);

%% Clean the data
clean_PX4_file([file(1:end-4),'-new.mat']);

%% Load new data
load([file(1:end-4),'-new.mat']);

return
end



