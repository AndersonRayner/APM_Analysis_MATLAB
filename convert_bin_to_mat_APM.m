% Conversion of APM binary to something I can use in MATLAB
% Really, really slow :(.  Doesn't pre-allocate, though apparently that
% makes things faster anyways...
%
% test run time of 196 s
function convert_bin_to_mat_APM(file)
addpath('./functions/');

if ~nargin
    close all
    clear all
    clc
    
%     file = './data/1.BIN'; convert_bin_to_mat_APM(file);
%     file = './data/2.BIN'; convert_bin_to_mat_APM(file);
%     file = './data/3dr_aero.bin'; convert_bin_to_mat_APM(file);
%     file = './data/4.BIN'; convert_bin_to_mat_APM(file);
%     file = './data/5.BIN'; convert_bin_to_mat_APM(file);
%     file = './data/6.BIN'; convert_bin_to_mat_APM(file);
%     file = './data/7.BIN'; convert_bin_to_mat_APM(file);
%     file = './data/8.BIN'; convert_bin_to_mat_APM(file);
%     file = './data/27.BIN'; convert_bin_to_mat_APM(file);
%     file = './data/airspeed_test.BIN'; convert_bin_to_mat_APM(file);
%     file = './data/bwb_flight.bin'; convert_bin_to_mat_APM(file);
%     file = './data/lost_wing_flight.bin'; convert_bin_to_mat_APM(file);
%     file = './data/marulan_quad_flight.BIN'; convert_bin_to_mat_APM(file);
%     file = './data/write_off_flight.bin'; convert_bin_to_mat_APM(file);
%  file = './data/kai.bin'; convert_bin_to_mat_APM(file);
% file = './data/IRIS_1.bin'; convert_bin_to_mat_APM(file);
% file = './data/IRIS_2.bin'; convert_bin_to_mat_APM(file);
% file = './data/IRIS_3.bin'; convert_bin_to_mat_APM(file);
file = './data/17.bin'; convert_bin_to_mat_APM(file);
    
    return
end

tic

fid = fopen(file);
fprintf('Reading file %s\n========================\n\n',file);

% Find length of file
fseek(fid,0,'eof');
length_of_file = ftell(fid);
fseek(fid,0,'bof');

% Settings for bytes or something
new_line = [163,149]';

% initialise some stuff
list_of_ids = [];
used_ID = [];
list_of_names = {};
progress_multiplier = 0.0;

% Get first three characters, tells us what to do
while (ftell(fid)+50)<(length_of_file)  % ~feof(fid) - goes to 50 from the end incase of incomplete file.
    xx = fread(fid,2);
    if isequal(xx,new_line)
        % have to decide what it is
        xx = fread(fid,1);
        switch xx
            case 128 % new FMT data
                % Get ID
                ID = fread(fid,1);
                % Get siz(e)
                siz = fread(fid,1);
                % Get nam(e) (up to four characters or a ',')
                nam = '';
                xx = fread(fid,1,'*char');
                while ~isequal(xx,0) && length(nam)~=4
                    nam(1,end+1) = xx;
                    xx = fread(fid,1,'*char');
                end
                
                while isequal(xx,0); xx = fread(fid,1,'*char'); end; % Feed zeros
                
                % Get format
                form = '';
                while ~isequal(xx,0)
                    form(1,end+1) = xx;
                    xx = fread(fid,1,'*char');
                end
                
                while isequal(xx,0); xx = fread(fid,1,'*char'); end; % Feed zeros
                
                % Get names
                % ignore if the variable already exists
                if ~exist(nam,'var')
                    for ii = 1:length(form)
                        field = '';
                        while ~isequal(xx,',') && ~isequal(xx,0)
                            field(1,end+1) = xx;
                            xx = fread(fid,1,'*char');
                        end
                        xx = fread(fid,1,'*char');
                        % make the struct - this will need to change with the data type
                        try
                            if max(form(ii) == 'nNZ') % String
                                eval([nam '.' field ' = cell(0,0);']);
                            else % Numbers
                                eval([nam '.' field ' =  nan(0,0);']);
                            end
                            
                        catch
                            keyboard
                        end
                    end
                    
                    % Add ID, size and format to struct
                    eval([nam '.ID     = ' num2str(ID)   ';']);
                    eval([nam '.size   = ' num2str(siz)  ';']);
                    eval([nam '.format = ''' form ''';']);
                    
                    list_of_ids(end+1,1) = ID;
                    used_ID(end+1,1) = 0;
                    list_of_names{end+1,1} = nam;
                 %   fprintf('Added a new data type!\n');
                    
                else
                    fprintf('Already know file type - ignoring\n');
                    if ftell(fid)>0.5*length_of_file
                        fprintf('This probably means something is wrong at the end of the file\n');
                        fprintf('\tI''m just going to stop here\n');
                        fseek(fid,0,'eof');
                    end
                end
                % Feed remaining zeros
                while isequal(xx,0); xx = fread(fid,1,'*char'); end; % Feed zeros
                
                % Fix position in file
                fseek(fid,-1,'cof');
                
                
                
            otherwise % All other data types
                % use the ID numbers to match up where it goes
                loc = find(list_of_ids == xx);
                
                used_ID(loc) = 1;
                
                if isempty(loc)
                    warning('Something is going wrong');
                    fprintf('Can''t find anything with ID %d, skipping to next line\n',xx);
                    keyboard
                else
                    % Work out what we need to find
                    eval(['n_fields = length(',list_of_names{loc},'.format);']);
                    eval(['formats = ',list_of_names{loc},'.format;']);
                    eval(['fields = fieldnames(',list_of_names{loc},');']);
                    eval(['n_bytes_remaining = ',list_of_names{loc},'.size - 3;']); % accounts for the three to give new line and ID the message
                    
                    for ii = 1:n_fields
                        switch formats(ii)
                            % Format characters in the format string for binary log messages
                            % Data from
                            % ardupilot/libraries/DataFlash/LogStructure.h
                            % - Line 670
                            %   b   : int8_t
                            case 'b'
                                data = num2str(fread(fid,1,'int8')); if isempty(data); data = nan; end;
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 1;
                                %   B   : uint8_t
                            case 'B'
                                data = num2str(fread(fid,1,'uint8')); if isempty(data); data = nan; end;
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 1;
                                %   h   : int16_t
                            case 'h'
                                data = num2str(fread(fid,1,'int16')); if isempty(data); data = nan; end;
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 2;
                                %   H   : uint16_t
                            case 'H'
                                data = num2str(fread(fid,1,'uint16')); if isempty(data); data = nan; end;
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 2;
                                %   i   : int32_t
                            case 'i'
                                data = num2str(fread(fid,1,'int32')); if isempty(data); data = nan; end;
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 4;
                                %   I   : uint32_t
                            case 'I'
                                data = num2str(fread(fid,1,'uint32')); if isempty(data); data = nan; end;
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 4;
                                %   f   : float
                            case 'f'
                                data = num2str(fread(fid,1,'float')); if isempty(data); data = nan; end;
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 4;
                                %   d   : double
                            case 'd'
                                data = num2str(fread(fid,1,'double')); if isempty(data); data = nan; end;
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 8;
                                %   n   : char[4]
                            case 'n'
                                data = num2str(fread(fid,4,'*char'));
                                string = strcat(list_of_names{loc},'.',fields{ii},'{end+1,1} = ''',data',''';');
                                eval(string);
                                n_bytes_remaining = n_bytes_remaining - 4;
                                %   N   : char[16]
                            case 'N'
                                data = num2str(fread(fid,16,'*char'));
                                n_bytes_remaining = n_bytes_remaining - 16;
                                string = strcat(list_of_names{loc},'.',fields{ii},'{end+1,1} = ''',data',''';');
                                eval(string);
                                %   Z   : char[64]
                            case 'Z'
                                data = num2str(fread(fid,64,'*char'))';
                                n_bytes_remaining = n_bytes_remaining - 64;
                                string = strcat(list_of_names{loc},'.',fields{ii},'{end+1,1} = ''',data,''';');
                                eval(string);
                                %   c   : int16_t * 100
                            case 'c'
                                data = num2str(fread(fid,1,'int16')/100);
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 2;
                                %   C   : uint16_t * 100
                            case 'C'
                                data = num2str(fread(fid,1,'uint16')/100);
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 2;
                                %   e   : int32_t * 100
                            case 'e'
                                data = num2str(fread(fid,1,'int32')/100); if isempty(data); data = nan; end;
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 4;
                                %   E   : uint32_t * 100
                            case 'E'
                                data = num2str(fread(fid,1,'uint32')/100); if isempty(data); data = nan; end;
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 4;
                                %   L   : int32_t latitude/longitude
                            case 'L'
                                data = num2str(fread(fid,1,'int32')); if isempty(data); data = nan; end;
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 4;
                                %   M   : uint8_t flight mode
                            case 'M'
                                data = num2str(fread(fid,1,'uint8')); if isempty(data); data = nan; end;
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 1;
                                %   q   : int64_t
                            case 'q'
                                data = num2str(fread(fid,1,'int64')); if isempty(data); data = nan; end;
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 8;
                                %   Q   : uint64_t
                            case 'Q'
                                data = num2str(fread(fid,1,'uint64')); if isempty(data); data = nan; end;
                                eval([ list_of_names{loc},'.',fields{ii},'(end+1,1) = ',data,';']);
                                n_bytes_remaining = n_bytes_remaining - 8;
                                
                                
                            otherwise
                                fprintf('format of %s\n',formats(ii));
                                warning('I don''t know :(');
                                keyboard
                        end
                        
                        
                    end
                    
                    % Check to see all bytes read
                    if n_bytes_remaining ~= 0
                        warning('Byte total doesn''t equal 0');
                        keyboard
                        % feed as many bytes as required
                        xx = fread(fid,max(n_bytes_remaining,0),'*char');
                        fprintf('remaining data is <<%s>>\n',xx);
                        n_bytes_remaining = 0;
                    end
                    
                    if ftell(fid) > length_of_file*progress_multiplier
                        fprintf('%3.0f %% done at %7.2fs\n',progress_multiplier*100,toc);
                        progress_multiplier = progress_multiplier + 0.01;
                    end
                end
%                 fprintf('Data block ending %8d of %8d read\n',ftell(fid),length_of_file);
        end
        
    elseif feof(fid)
        % end of file so just let it finish
        
    else
        start_found = 0;
        fprintf('\tI''m lost...');
        while ~start_found
            xx = fread(fid,1);
            if isequal(xx,new_line(1));
                xx = fread(fid,1);
                if isequal(xx,new_line(2))
                    start_found = 1;
                    % jump back two spots so can be found properly above
                    fseek(fid,-2,'cof');
                end
            end
            
            if feof(fid)
                start_found = 1;
            end
        end
                fprintf('Found my spot!');
    end
    
end

% Save data
save_list = [];
for ii = 1:length(list_of_names)
    if used_ID(ii)
        save_list = [save_list,'''',list_of_names{ii},''','];
    end
end
eval(['save(''',file(1:end-4),'.mat'',',save_list(1:end-1),');']);

fclose(fid);

% Clean the file
clean_PX4_file([file(1:end-4),'.mat']);

% Finished!
fprintf('Finished Import!\n');
toc

return
% end
