close all; clear all; clc;
x = double(imread('tetto.png'));

% Derivate direzionali
h1 = [0 -1 0; 0 1 0; 0 0 0];
h2 = [0 0 0; -1 1 0; 0 0 0];
h3 = [-1 0 0; 0 1 0; 0 0 0];
h4 = [0 0 0; 0 1 0; 0 0 -1];
V = imfilter(x,h1,'replicate');
H = imfilter(x,h2,'replicate');
D1 = imfilter(x,h3,'replicate');
D2 = imfilter(x,h4,'replicate');

% Quadrati delle derivate
Q(:,:,1) = colfilt(V.^2,[5 5],'sliding',@sum);
Q(:,:,2) = colfilt(H.^2,[5 5],'sliding',@sum);
Q(:,:,3) = colfilt(D1.^2,[5 5],'sliding',@sum);
Q(:,:,3) = colfilt(D2.^2,[5 5],'sliding',@sum);

% KeyPoints
Qmin = min(Q,[],3);
Qmax = colfilt(Qmin,[3 3],'sliding',@max);

SP = (Qmin == Qmax) & (Qmin>500);

figure;
subplot(121); imshow(x,[]); title('Originale');
subplot(122); imshow(SP); title('Keypoint');
