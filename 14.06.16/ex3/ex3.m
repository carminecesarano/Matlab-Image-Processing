close all; clear all; clc;
fid = fopen('Lena.y','rb');
x = fread(fid,[512 512],'uchar');
x = x';
fclose(fid);

% Compressione
Y = coder(x);
y = decoder(Y);

% Visualizzazione
figure;
subplot(121); imshow(x,[0 255]); title('Trasmissione');
subplot(122); imshow(y,[0 255]), title('Ricezione');