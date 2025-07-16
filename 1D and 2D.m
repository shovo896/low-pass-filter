clc; clear; close all;

disp('Running 1D Signal Low-Pass Filter...');

% Generate signal: Low (50 Hz) + High (300 Hz)
fs = 1000;                 
t = 0:1/fs:1-1/fs;
x = sin(2*pi*50*t) + sin(2*pi*300*t);

% Design filter
cutoff = 100;
order = 6;
[b, a] = butter(order, cutoff/(fs/2), 'low');
y_one = filter(b, a, x);

% --- Two Pass (Forward and Reverse Filtering) ---
y_two = filtfilt(b, a, x);  % Zero-phase filtering

% Plot results
figure('Name','1D Signal Filtering');
subplot(3,1,1); plot(t,x); title('Original Signal'); grid on;
subplot(3,1,2); plot(t,y_one); title('One-Pass Low-Pass Filter'); grid on;
subplot(3,1,3); plot(t,y_two); title('Two-Pass (Zero-Phase) Low-Pass Filter'); grid on;

%% ========== 2D IMAGE LOW-PASS FILTERING ==========
disp('Running 2D Image Low-Pass Filter...');

% Load image
img = imread('cameraman.tif'); % Use any grayscale image
gray = im2double(img);

% Gaussian filter setup
hsize = 15;
sigma = 2.0;
g_filter = fspecial('gaussian', hsize, sigma);

% --- One Pass ---
img_one = imfilter(gray, g_filter, 'replicate');

% --- Two Pass (Apply same filter twice)
img_two = imfilter(img_one, g_filter, 'replicate');

% Show results
figure('Name','2D Image Filtering');
subplot(1,3,1); imshow(gray); title('Original Image');
subplot(1,3,2); imshow(img_one); title('One-Pass Gaussian Filter');
subplot(1,3,3); imshow(img_two); title('Two-Pass Gaussian Filter');
