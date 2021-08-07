clear all; close all; clc;

fid = fopen('lena_rumorosa.raw','rb');
x = fread(fid,[256 256],'float');
x = x';
fclose(fid);

[y1,y2] = adapt_filt(x);

% Visualizzazione
figure; 
subplot(131); imshow(x,[0 255]); title('rumorosa');
subplot(132); imshow(y1,[0 255]); title('stima 1');
subplot(133); imshow(y2,[0 255]); title('stima 2');

% PSNR
fid = fopen('lena.raw','rb');
xo = fread(fid,[256 256],'uint8');
xo = xo';
fclose(fid);

MSE1 = mean2((y1-xo).^2);
PSNR1 = 10*log10(255^2/MSE1)
MSE2 = mean2((y2-xo).^2);
PSNR2 = 10*log10(255^2/MSE2)


