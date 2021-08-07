close all; clear all; clc;
x = double(imread('testo.jpg'));

% Thresholding
T = 0.3*(max(x(:)));
xb1 = x<T;
% Thinning
se = [0 1 0; 1 1 1; 0 1 0];
xt1 = imerode(xb1,se);

% Filtraggio
M = ones(3)/9;
xf = imfilter(x,M,'replicate');

% Thresholding post average
T = 0.4*(max(xf(:)));
xb2 = xf<T;
% Thinning post average
se = [0 1 0; 1 1 1; 0 1 0];
xt2 = imerode(xb2,se);


% Visualizzazione
figure; 
subplot(231); imshow(x,[]); title('Originale');
subplot(232); imshow(xb1,[]); title('Thresholding');
subplot(233); imshow(xt1,[]); title('Thinning');
subplot(234); imshow(xf,[]); title('Filtrata');
subplot(235); imshow(xb2); title('Thresholding filt');
subplot(236); imshow(xt2); title('Thinning filt')