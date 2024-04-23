% Spectrophotometry lab data analysis || Written by Bakpen Kombat 
clc; close; clear all; 

%% Task 1: Determine Unkown concentration 
% Load data from CSV files

data0 = readtable('con_0.csv');  
Data0_5 = readtable('con_0.5.csv');
Data1 = readtable('con_1.csv');
Data1_5 = readtable('con_1.5.csv');
Data2 = readtable('con_2.csv');
DataUnknown = readtable('con_unknown.csv');


targetWavelength = 300;
findAbsAtWavelength = @(data) interp1(data.Wavelength, data.Absorbance, targetWavelength, 'linear', 'extrap');

% Extract absorbance at 630 nm from each dataset
abs0 = findAbsAtWavelength(data0);
abs0_5 = findAbsAtWavelength(Data0_5);
abs1 = findAbsAtWavelength(Data1);
abs1_5 = findAbsAtWavelength(Data1_5);
abs2 = findAbsAtWavelength(Data2);
absUnknown = findAbsAtWavelength(DataUnknown);

% Concentrations used for known samples (excluding unknown)
concentrations = [0, 0.5, 1, 1.5, 2];
absorbances = [abs0, abs0_5, abs1, abs1_5, abs2];

% Linear regression to find best fit line
coefficients = polyfit(concentrations, absorbances, 1);
slope = coefficients(1);
intercept = coefficients(2);

concentrationUnknown = (absUnknown - intercept) / slope;

figure; hold on;
plot(concentrations, absorbances, 'bo', 'DisplayName', 'Known Concentrations'); % blue points for known concentrations
plot(concentrations, slope*concentrations + intercept, 'k--', 'DisplayName', 'Best Fit Line'); % black dashed line for best fit

% Highlight the unknown absorbance and draw horizontal line to the fit line
plot(concentrationUnknown, absUnknown, 'r*', 'MarkerSize', 10, 'DisplayName', 'Unknown Concentratiob');
plot([0, concentrationUnknown], [absUnknown, absUnknown], 'r');  % Horizontal red line
plot([concentrationUnknown, concentrationUnknown], [0, absUnknown], 'r');  

xlabel('Concentration');
ylabel('Absorbance at 300nm');
title('Absorbance vs concentration');
legend show;
grid on;

% Annotate the plot with the calculated concentration
text(concentrationUnknown + 0.1, absUnknown, sprintf('Estimated Concentration: %.2f', concentrationUnknown), 'Color', 'red', 'FontSize', 12);
text(concentrationUnknown, -0.05, sprintf('%.2f', concentrationUnknown), 'Color', 'red', 'FontSize', 12, 'HorizontalAlignment', 'center');

%% Task 2: Finding material for UV-protection
iles = {'normal_glass.csv', 'pmma.csv', 'polyc.csv', 'quartz.csv'};
colors = ['b', 'g', 'r', 'm']; % blue, green, red, magenta
labels = {'Normal Glass', 'PMMA', 'Polycarbonate', 'Quartz'};

figure;

% Loop over each file
for i = 1:length(files)
    data = readtable(files{i});
    
    wavelength = data.wavelength;
    transmittance = data.transmittance;
    
    % Plot data
    plot(wavelength, transmittance, 'Color', colors(i), 'DisplayName', labels{i});
    hold on; 
end

% Add graph title and axis labels
title('Wavelength vs Transmittance for Different Materials');
xlabel('Wavelength');
ylabel('Transmittance');


legend('show');
grid on;
hold off;

%% Task 3: Recognizing type of plastic
files = {'normal_glass.csv', 'pmma.csv', 'polyc.csv', 'quartz.csv'};
colors = ['b', 'g', 'r', 'm']; % blue, green, red, magenta
labels = {'Normal Glass', 'PMMA', 'Polycarbonate', 'Quartz'};

figure;

% Loop over each file
for i = 1:length(files)
    data = readtable(files{i});
    
    wavelength = data.wavelength;
    transmittance = data.transmittance;
    
    % Plot data
    plot(wavelength, transmittance, 'Color', colors(i), 'DisplayName', labels{i});
    hold on; 
end

% Add graph title and axis labels
title('Wavelength vs Transmittance for Different Materials');
xlabel('Wavelength');
ylabel('Transmittance');


legend('show');
grid on;
hold off;

%% Laser safety glass protection 
data = readmatrix('lglass.csv');
wavelength = data(:,1);
transmittance = data(:,2);

figure;
plot(wavelength, transmittance); 
title('Wavelength vs Transmittance');
xlabel('Wavelength');
ylabel('Transmittance');
grid on;  
