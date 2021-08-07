clear all; close all; clc;
x1 = double(imread('impronta1.tif'));
x2 = double(imread('impronta2.tif'));

% DFT
y1 = nlfilter(x1,[9 9],@custom);
y2 = nlfilter(x2,[9 9],@custom);

% Istogramma
h1 = hist(y1(:),0:255);
h2 = hist(y2(:),0:255);
dev1 = std(h1);
dev2 = std(h2);

% Visualizzazione
figure; 
subplot(121); imshow(x1,[]); title('Impronta 1');
subplot(122); imshow(x2,[]); title('Impronta 2');