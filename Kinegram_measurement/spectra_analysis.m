clear; close; clc

% Define file names and colors
file_names = {'p-22degree-001.csv', 'p-43degree-001.csv', 'p-47degree-001.csv', 'p-54degree-001.csv'};
colors = {'b', 'b', 'g', 'r'};
LED_names = {'White', 'Blue', 'Green', 'Red'};

figure('Name', 'Spectrum');

for i = 1:length(file_names)
    % Read data
    data = readtable(file_names{i});
    wavelength = data.('Wavelength');
    intensity = data.('Intensity');
    
    % Plot spectrum
    subplot(2,2,i);
    plot(wavelength, intensity, colors{i});
    xlabel('Wavelength [nm]'); ylabel('Intensity [W/m^2]');
    title(sprintf('Spectrum of %s LED', LED_names{i})); 
    grid on;
    
    % Calculate peak intensity and wavelength
    [peak_intensity, idx] = max(intensity);
    peak_wavelength = wavelength(idx);
    
    % Plot peak
    hold on;
    plot(peak_wavelength, peak_intensity, 'ro');
    
    % Add legend
    legend('Spectrum', sprintf('Peak: %.2f nm, %.2f W/m^2', peak_wavelength, peak_intensity),'Location','NorthOutside');
end
