%% Reset
clear all;
close all;
%% Load and preprocess data
% Images found from this dataset: https://vision.middlebury.edu/stereo/data/scenes2006/
file1 = "images/baby1.png";
file2 = "images/baby2.png";
gt_file = "images/baby  _gt.png";
I1 = imread(file1);
I2 = imread(file2);
GT = imread(gt_file);

% Convert to grayscale.
% Rectified 2D, greyscale images IL and IR which are equal size mxn
IL = double(rgb2gray(I1));
IR = double(rgb2gray(I2));
%% Setup Params

lambda = 0.01; %weight data fidelity muhc higher than smoothness
delta_t = .1; % make time step much smaller than limit of 1/(4*lambda)
num_iter = 100; % number of iterations running update scheme
 
%% Run Update Scheme

[d_array, E] = calc_disp(IL, IR, lambda, delta_t, num_iter);

%% Display disparity and energy plot
figure;
plot(E);
title("Energy of d vs. Iterations")
xlabel("Iterations");
ylabel("E(d)");
grid on;

figure;
imshowpair(d_array, GT, 'montage', 'scaling', 'independent');

%% Calculate Sim Score

d_img = rescale(d_array, 0, 255);
ground = rescale(GT, 0, 255);
err = 1- ssim(d_img, ground);
