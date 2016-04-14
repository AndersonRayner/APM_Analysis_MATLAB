function output = nanmean(input)

output = mean(input(~isnan(input)));

return
end