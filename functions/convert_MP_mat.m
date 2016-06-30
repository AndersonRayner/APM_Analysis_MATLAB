function convert_MP_mat(file)
% A function for converting the matrix based .mat files produced
% by MissionPlanner into the struct based .mat files I use here.

if ~nargin
close all
clear all
clc

% Search the current directory for .mat files
search_folder = 'D:\SkyDrive\recent_flights\';
files = dir([search_folder,'*.mat']);
for ii = 1:length(files)
    convert_MP_mat([search_folder,files(ii).name])
end
return
end

%% Load data
data = load(file);

%% Check if already a converted file
% Look for the seen variable, not used in the converted .mat files
if ~isfield(data,'Seen')
    fprintf('Already converted %s\n',file);
    return;
else
    fprintf('Converting        %s\n',file);
end
%% Process data
% Can use the << Seen >> field to know which data to operate on
for ii = 1:length(data.Seen)
    fprintf('\tConverting %s\n',data.Seen{ii});
    
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
% Calculate new file name
new_file = [file(1:strfind(file,'.BIN')+3),'.mat'];
if length(new_file) == 4;
    new_file = [file(1:strfind(file,'.bin')+3),'.mat'];
end
eval(['save(''',new_file,'''',',',save_list(1:end-1),');']);

%% Clean the data
clean_PX4_file(new_file);
load(new_file);  % Need to load the changes to see the fixes of cleaning the files

%% Save a picture of the flight
if exist('GPS','var')
    % Find first valid data point
    start_loc = find(abs(GPS.Lng)>0,1,'first');
    end_loc   = find(abs(GPS.Lng)>0,1,'last');
    
    figure(1); clf; hold all;
    plot(GPS.Lng,GPS.Lat,'k','lineWidth',4);...
        plot(GPS.Lng,GPS.Lat,'w');...
        plot(GPS.Lng(start_loc),GPS.Lat(start_loc),'go');...
        plot(GPS.Lng(end_loc),GPS.Lat(end_loc),'ro');...
        ylabel('Latitude [ deg ]'); xlabel('Longitude [ deg ]');
    % Fix the axes for when only operating in a very small area
    xlims = xlim; ylims = ylim;
    if (max(xlims)-min(xlims)<0.001 && max(ylims)-min(ylims)<0.001)
        xlim( mean(xlims)+[-0.0005, +0.0005 ]);
        ylim( mean(ylims)+[-0.0005, +0.0005 ]);
    end
    % Finish the plot and add google maps data
    axis equal;
    plot_google_map('MapType','hybrid','Refresh',1)
    
    set(gcf,'PaperPositionMode','auto'); 
    saveas(gcf,[new_file(1:end-4),'.png']);
end

%% Remove original .mat file
% Good for commenting out when debugging
% delete(file);

%% Return
return

end



