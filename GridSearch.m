%% Reset
clear all;
close all;
%% Load and preprocess data
% Images found from this dataset: https://vision.middlebury.edu/stereo/data/scenes2006/
file1 = "images/baby1.png";
file2 = "images/baby2.png";
gt_file = "images/baby_gt.png";
I1 = imread(file1);
I2 = imread(file2);
GT = imread(gt_file);
ground = rescale(GT, 0, 255);

% Convert to grayscale.
% Rectified 2D, greyscale images IL and IR which are equal size mxn
IL = double(rgb2gray(I1));
IR = double(rgb2gray(I2));
%% Setup Params

lambdas = [0.9, 0.99, 0.999]; %weight data fidelity muhc higher than smoothness
dt_mults = [0.3, 0.2, 0.1]; % make time step much smaller than limit of 2.5
num_iter = 100; % number of iterations running update scheme
results = zeros(9,3);
energy_plots = zeros(9, num_iter);
 
%% Run Grid Search
i = 1;
for l=1:3
    for t=1:3
        lambda = lambdas(l);
        delta_t = dt_mults(t) * 1/(4*lambda);
        fprintf("Checking Lambda = %f, delta_t = %f \n", lambda, delta_t);
        [d_array, E] = calc_disp(IL, IR, lambda, delta_t, num_iter);
        
        energy_plots(i, :) = E;
        
        d_img = rescale(d_array, 0, 255);
        err = 1- ssim(d_img, ground);
        
        results(i,:)= [lambda, delta_t, err];
        i=i+1;
    end
end
        
        
%% Plot
figure;
scatter3(results(:,1),results(:,2),results(:,3));
title("Grid search for optimal params");
xlabel("Lambda");
ylabel("Delta t");
zlabel("Error");

figure;
plot(energy_plots);