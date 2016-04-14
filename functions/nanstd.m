function output = nanstd(input)

output = std(input(~isnan(input)));

return
end