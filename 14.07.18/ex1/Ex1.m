clear all; close all; clc;
x = imread('star_noisy.png');
x = double(rgb2gray(x));
xo = imread('star.jpg');
xo = double(rgb2gray(xo));

% DFT
X = fftshift(fft2(x));

% Griglia
[M,N] = size(x);
n = -1/2:1/N:1/2-1/N;
m = -1/2:1/M:1/2-1/M;
[l,k] = meshgrid(n,m);

% Filtro
D0 = 0.018;
D = sqrt((l-0.1).^2+(k+0.1).^2);
H = (D<D0);
D = sqrt((l+0.1).^2+(k-0.1).^2);
H = H+(D<D0);
D = sqrt((l+0.2).^2+(k+0.2).^2);
H = H+(D<D0);
D = sqrt((l-0.2).^2+(k-0.2).^2);
H = H+(D<D0);
D = sqrt((l+0.3).^2+(k+0.1).^2);
H = H+(D<D0);
D = sqrt((l-0.3).^2+(k-0.1).^2);
H = H+(D<D0);
D = sqrt((l+0.1).^2+(k+0.3).^2);
H = H+(D<D0);
D = sqrt((l-0.1).^2+(k-0.3).^2);
H = H+(D<D0);
D = sqrt((l+0.4).^2+(k+0.4).^2);
H = H+(D<D0);
D = sqrt((l-0.4).^2+(k-0.4).^2);
H = H+(D<D0);

% Filtraggio
Y = X.*(1-H);
y = real(ifft2(ifftshift(Y)));

% Visualizzazione
%figure;
subplot(131); imshow(x,[]); title('rumorosa');
subplot(132); imshow(y,[]); title('filtrata');
subplot(133); imshow(xo,[]); title('originale');
figure;
subplot(121); imshow(log(1+abs(Y)),[]); title('dft filtrata');
subplot(122); mesh(l,k,log(1+abs(Y))); title('mesh dft');
