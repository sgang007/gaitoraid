function [seasonal_comp] = extract_seasonal_component()    
x = csvread ('Generated_datasets/ts_data_x.csv');
T = length(x);
t = 1:T;

% Taking only row 2 of the data set for tests.
row = x(2, :);

deg = 2;
[p, s, mu] = polyfit (t, row, deg);
trend = polyval (p, t, [], mu);

data_detrend = row - trend

Pxx = periodogram(data_detrend);
% Setting periodicity as peak value
period = find (Pxx == max(Pxx));

%creating seasonal indexes
seasonal_indexes = cell(period, 1);
for i = 1:period
    seasonal_indexes{i,1} = i:period:T;
end

% Finds the mean seasonal component in each of the sets.
seasonal_comp = cellfun(@(x) mean(data_detrend(x)),seasonal_indexes);

% Put smoothed values back into a vector of length N
quot = floor(T/period); 
rem = mod(T,period); 
seasonal_comp = [repmat(seasonal_comp, quot, 1);seasonal_comp(1:rem)];

% Center the seasonal estimate (additive)
sBar = mean(seasonal_comp); % for centering
seasonal_comp = seasonal_comp - sBar;

csvwrite('seasonal_component.csv', seasonal_comp');
% 
% figure;
% plot(seasonal_comp);
% title 'Stable Seasonal Component';