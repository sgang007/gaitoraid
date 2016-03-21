function dt = extract_stochastic_component()
%STOCHASTICCOMPONENTEXTRACTION finds the stochastic component in the data.
%   This function returns the stochastic component of the data 
%   after removing the trend and seasonality. Currently this method only 
%   takes no argument and takes the data from the file. 
%   But it should take any data set in general.
    
x = csvread ('Generated_datasets/ts_data_x.csv');
T = length(x);
t = 1:T;

% Taking only row 2 of the data set for tests.
row = x(2, :);

figure;
plot(t, row);
hold on;

% fitting a polynomial of degree 2 to the data.
deg = 2;
[p, s, mu] = polyfit (t, row, deg);
trend = polyval (p, t, [], mu);

plot(1:100, trend);
title 'Original values and trend';
hold off;

data_detrend = row - trend;

figure;
plot (t, data_detrend);
title 'Detrended values'

% Use a periodogram to find periodicity
figure;
Pxx = periodogram (data_detrend);
plot (1:length(Pxx), Pxx);
title 'Periodogram for finding periodicity'

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

figure;
plot(seasonal_comp);
title 'Stable Seasonal Component';

% De-seasonalising the series
dt = row - seasonal_comp';

figure;
plot(dt);
title 'Deseasonalized Series';

% Verifying if seasonality still exists
figure;
Pxx = periodogram (dt);
plot (1:length(Pxx), Pxx);
title 'Does seasonality still exist?';

end
