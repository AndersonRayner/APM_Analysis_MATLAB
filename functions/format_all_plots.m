function format_all_plots(xlims,grid_on)
% Set all the plots to have the same time scale and optionally turns on a
% grid
fprintf('\n');
if ~exist('xlims','var'); xlims = 0; end;
if ~exist('grid_on','var'); grid_on = 0; end;
if length(xlims) == 2; fprintf('\nApplying x-axis limits\n'); end
if grid_on; fprintf('Turning on grids\n'); end

% Find all the open figures
figures = findall(0,'type','figure');

% Loop through each of the figures
for ii = 1:length(figures)
    % Find all the subfigures for that figure
    subfigures = get(figures(ii),'Children');
    
    % Loop through each of the subfigures
    for jj = 1:length(subfigures)
        % Turn on grid if requested
        if grid_on
            set(subfigures(jj),'GridLineStyle',':');
            grid(subfigures(jj),'on');
        end
             
        % If the xlabel is empty or << Time [ s ] >> set the axis (if requested)
        % Get the xlabel
        % fprintf('Formatting Figure %d, Subfigure %d\n',ii,jj);
        % a = get(get(subfigures(jj),'XLabel'));
        % x_label = get(a,'string');
        
        % Check xlabel and set if required
        if length(xlims) == 2;
            % if strcmp(x_label,'Time [ s ]') || isempty(x_label)
                % For some reason the legend stuffs up when the x-limits
                % are changed in this way.  Therefore we're going to save
                % the legend string
                
                try legend_string = get(legend(subfigures(jj)),'String'); catch; legend_string = []; end
                try set(subfigures(jj),'xlim',xlims); end
                
                % Re-create the legend
                if ~isempty(legend_string)
                    legend(legend(subfigures(jj)),legend_string);
                end
            % end
        end
    end
end