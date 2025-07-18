clear;
clc;


path_directory_ref='reference-white'; 
original_files_ref=dir(path_directory_ref); 
original_files_ref([1 2],:) = []; 

path_directory_Rainbow1='colors-1'; 
original_files_Rainbow1=dir(path_directory_Rainbow1); 
original_files_Rainbow1([1 2],:) = []; 

path_directory_Rainbow2='colors-2'; 
original_files_Rainbow2=dir(path_directory_Rainbow2); 
original_files_Rainbow2([1 2],:) = []; 

path_directory_UEF='uef-logo'; 
original_files_UEF=dir(path_directory_UEF); 
original_files_UEF([1 2],:) = []; 

path_directory_Acrylic1='art-drawing'; 
original_files_Acrylic1=dir(path_directory_Acrylic1); 
original_files_Acrylic1([1 2],:) = [];



for k=1:length(original_files_Rainbow1)
    thisfile_ref = fullfile(original_files_ref(k).folder,original_files_ref(k).name) ;
    thisfile_Rainbow1 = fullfile(original_files_Rainbow1(k).folder,original_files_Rainbow1(k).name) ;
    thisfile_Rainbow2 = fullfile(original_files_Rainbow2(k).folder,original_files_Rainbow2(k).name) ;
    thisfile_UEF = fullfile(original_files_UEF(k).folder,original_files_UEF(k).name) ;
    thisfile_Acrylic1 = fullfile(original_files_Acrylic1(k).folder,original_files_Acrylic1(k).name) ;
    T_ref = double(imread(thisfile_ref,'tif'));
    T_Rainbow1 = double(imread(thisfile_Rainbow1,'tif'));
    T_Rainbow2 = double(imread(thisfile_Rainbow2,'tif'));
    T_UEF = double(imread(thisfile_UEF,'tif'));
    T_Acrylic1 = double(imread(thisfile_Acrylic1,'tif'));
    T_Colored1(:,:,k) = T_Rainbow1./T_ref;
    T_Colored2(:,:,k) = T_Rainbow2./T_ref;
    T_Metameric(:,:,k) = T_UEF./T_ref;
    T_photo1(:,:,k) = T_Acrylic1./T_ref;
    T_white(:,:,k) = T_ref./max(T_ref); % white background is normalized to its maximium 
end
 figure()
image = T_photo1(:,:,40); % Assuming T_Colored1 is your image data
imshow(image);
title(['Spectral Reflectance of Painting Sample at Wavelength lambda = ', num2str(840), 'nm']);

% Get the size of the image
[height, width, ~] = size(image);

% Add gradient scale to the horizontal axis
x_grad = linspace(1, width, width); % Create a linear gradient for x-axis
%text(x_grad, ones(1, width) * (height + 20), num2str((1:width)'), ...
    %'Color', 'white', 'FontSize', 8, 'HorizontalAlignment', 'center');

% Add gradient scale to the vertical axis
y_grad = linspace(1, height, height); % Create a linear gradient for y-axis
%text(ones(1, height) * (width + 20), y_grad, num2str((height:-1:1)'), ...
    %'Color', 'white', 'FontSize', 8, 'HorizontalAlignment', 'left');

% Adjust the axes to fit the labels
axis on;


A1 = cat(3,T_Colored1(:,:,21),T_Colored1(:,:,11),T_Colored1(:,:,1));
A2 = cat(3,T_Colored2(:,:,21),T_Colored2(:,:,11),T_Colored2(:,:,1));
A3= cat(3,T_Metameric(:,:,21),T_Metameric(:,:,11),T_Metameric(:,:,1));
A4= cat(3,T_photo1(:,:,21),T_photo1(:,:,11),T_photo1(:,:,1));
A5= cat(3,T_white(:,:,21),T_white(:,:,11),T_white(:,:,1));

figure()
subplot(2,3,1)
imshow(A1)
title('Color Checker Sample 1')
subplot(2,3,2)
imshow(A2)
title('Color Checker Sample 2')
subplot(2,3,3)
imshow(A3)
title('Metameric Sample')
subplot(2,3,4)
imshow(A4)
title('Painting Sample')
subplot(2,3,5)
imshow(A5)
title('White sheet')
sgtitle('RGB images at wavelengths R = 650 nm, G = 550 nm, and B = 450 nm')

%%
figure()
subplot(2,3,1)
imagesc(A1)
hold on;

% Prompt the user to select five points
[x, y] = ginput(5);

% Mark the selected points with red crosses
plot(x, y, 'rx', 'MarkerSize', 10, 'LineWidth', 2);

% Release the hold on the figure
hold off;
title('Color Checker Sample 1')

% Figure out the reflectance of the selected points

x1 = round(x);
y1 = round(y);

wl = 450:10:950;


for i = 1:length(x)
    subplot(2,3,i+1)
    Reflectance = squeeze(T_white(y1(i),x1(i),:));
    plot(wl,(Reflectance))
    xlabel('Wavelength(nm)'); ylabel('Reflectance')
    title(['Pixel',' ', '(',num2str(x1(i)),',',num2str(y1(i)),')'])
end

%% 
figure()
subplot(2,3,1)
imagesc(A2)
hold on;

% Prompt the user to select five points
[x, y] = ginput(5);

% Mark the selected points with red crosses
plot(x, y, 'rx', 'MarkerSize', 10, 'LineWidth', 2)

% Release the hold on the figure
hold off;
title('Color Checker Sample 2')

% Figure out the reflectance of the selected points

x2 = round(x);
y2 = round(y);

wl = 450:10:950;


for i = 1:length(x)
    subplot(2,3,i+1)
    Reflectance = squeeze(T_Colored2(y2(i),x2(i),:));
    plot(wl,Reflectance)
    xlabel('Wavelength(nm)'); ylabel('Reflectance')
    title(['Pixel',' ', '(',num2str(x2(i)),',',num2str(y2(i)),')'])
end

%%
figure()
subplot(2,3,1)
imagesc(A3)
hold on;

% Prompt the user to select five points
[x, y] = ginput(5);

% Mark the selected points with red crosses
plot(x, y, 'rx', 'MarkerSize', 10, 'LineWidth', 2)

% Release the hold on the figure
hold off;
title('Metameric Sample')

% Figure out the reflectance of the selected points

x3 = round(x);
y3 = round(y);

wl = 450:10:950;


for i = 1:length(x)
    subplot(2,3,i+1)
    Reflectance = squeeze(T_Metameric(y3(i),x3(i),:));
    plot(wl,Reflectance)
    xlabel('Wavelength(nm)'); ylabel('Reflectance')
    title(['Pixel',' ', '(',num2str(x3(i)),',',num2str(y3(i)),')'])
end

%%
figure()
subplot(2,3,1)
imagesc(A4)
hold on;

% Prompt the user to select five points
[x, y] = ginput(5);

% Mark the selected points with red crosses
plot(x, y, 'rx', 'MarkerSize', 10, 'LineWidth', 2)

% Release the hold on the figure
hold off;
title('Painting Sample')

% Figure out the reflectance of the selected points

x4 = round(x);
y4 = round(y);

wl = 450:10:950;


for i = 1:length(x)
    subplot(2,3,i+1)
    Reflectance = squeeze(T_photo1(y4(i),x4(i),:));
    plot(wl,Reflectance)
    xlabel('Wavelength(nm)'); ylabel('Reflectance')
    title(['Pixel',' ', '(',num2str(x4(i)),',',num2str(y4(i)),')'])
end

%% White

figure()
subplot(2,3,1)
imagesc(A5)
hold on;

% Prompt the user to select five points
[x, y] = ginput(5);

% Mark the selected points with red crosses
plot(x, y, 'rx', 'MarkerSize', 10, 'LineWidth', 2)

% Release the hold on the figure
hold off;
title('White paper')

% Figure out the reflectance of the selected points

x5 = round(x);
y5 = round(y);

wl = 450:10:950;


for i = 1:length(x)
    subplot(2,3,i+1)
    Reflectance = squeeze(T_white(y5(i),x5(i),:));
    plot(wl,Reflectance)
    xlabel('Wavelength(nm)'); ylabel('Reflectance')
    title(['Pixel',' ', '(',num2str(x5(i)),',',num2str(y5(i)),')'])
end
