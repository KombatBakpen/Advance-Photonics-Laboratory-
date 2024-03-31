clear; close; clc

file_names = {'p-43degree-001.csv', 'p-47degree-001.csv', 'p-54degree-001.csv'};
colors = {'b', 'g', 'r'};
LED_names = {'Blue', 'Green', 'Red'};

figure('Name', 'Spectrum');
num_subplots = length(file_names);

for i = 1:num_subplots
    data = readtable(file_names{i});

    wavelength = data.('Wavelength');

    intensity = data.('Intensity');
    intensity = intensity / max(intensity);
    
    % Find peak location
    [max_intensity, idx] = max(intensity);
    peak_wavelength = wavelength(idx);
    half_max_intensity = max_intensity / 2;
    
    % Find the indices corresponding to the peak region
    left_idx = find(wavelength <= peak_wavelength - 20, 1, 'last');
    right_idx = find(wavelength >= peak_wavelength + 20, 1);
    
   
    subplot(1, num_subplots, i);
    plot(wavelength(left_idx:right_idx), intensity(left_idx:right_idx), colors{i});
    xlabel('Wavelength[nm]'); 
    title(sprintf('%s LED', LED_names{i}));
    grid on;
    
    % Calculate FWHM
    left_idx_FWHM = find(intensity(left_idx:idx) <= half_max_intensity, 1, 'last') + left_idx - 1;
    right_idx_FWHM = find(intensity(idx:right_idx) <= half_max_intensity, 1) + idx - 1;
    FWHM = wavelength(right_idx_FWHM) - wavelength(left_idx_FWHM);
    
    % Plot FWHM lines
    hold on;
    plot([wavelength(left_idx_FWHM) wavelength(right_idx_FWHM)], [half_max_intensity half_max_intensity], 'k', 'LineWidth', 1.5);
   
    
    % Set x-axis limits
    xlim([wavelength(left_idx), wavelength(right_idx)]);
    
    % Set y-axis limits to show the entire range of normalized intensity
    ylim([0, 1.1]);
    
    % Add legend
    legend('Spectrum', sprintf('FWHM: %.2f nm', FWHM),'Location','NorthOutside');
end
