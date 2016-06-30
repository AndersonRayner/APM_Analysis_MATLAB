function freq = calc_data_frequency(time_data)
% Function for calculating frequency of data
if length(time_data) < 5
   freq = -1;
    return
end

freq = gradient(time_data);
mean_freq = nanmean(freq);
std_freq = nanstd(freq)*0.05;

locs = (freq < mean_freq+std_freq & freq > mean_freq-std_freq);
counter = 0;
while max(locs) == 0
    % if this happens, it means that I don't have a big enough range above.
    std_freq = std_freq*2;
    locs = (freq < mean_freq+std_freq & freq > mean_freq-std_freq);
    counter = counter + 1;
    if counter > 10
        % Didn't converge...
        fprintf('Didn''t converge in calc_data_frequency.m\n');
%         keyboard
        freq = -1;
        return
    end
end

freq = 1/mean(freq(locs));

return
end
