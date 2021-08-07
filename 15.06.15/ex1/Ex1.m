clear all; close all; clc;
x = double(imread('ponte.gif'));

% Istogramma
n = hist(x(:),0:255);
figure(1); 
subplot(121); bar(n); title('istogramma');

% 1. Filtro mediano
med = colfilt(x,[3 3],'sliding',@median);

% 2. Equalizzazione Istogramma
eq = histeq(uint8(med));
n = hist(eq(:),0:255);
figure(1); subplot(122); 
bar(n); title('istogramma equalizzato');

% Visualizzazione
figure(2);
subplot(131); imshow(x,[0 255]); title('originale');
subplot(132); imshow(med,[0 255]); title('1. Filtro mediano');
subplot(133); imshow(eq,[0 255]); title('2. Equalizzazione istogramma');

