clear all; close all; clc;
x = double(imread('cells.jpg'))/255;

[M,N] = size(x);
R = x(:,:,1);

% Clustering su 3 classi
[idx,centroidi] = kmeans(R(:),3);
[~, label] = sort(centroidi);
mask = zeros(size(R));
mask(idx==label(1)) = 1;

% Filtraggio media artitmetica
h = fspecial('average',3);
mask1 = imfilter(mask,h); 

% Opening
se = strel('disk',4,4);
mask2 = imopen(mask1,se);

% Thresholding
mask3 = mask2 > 0.12;

% Dilazione
mask4 = imdilate(mask3, strel('disk',1,4));

% Detection
y = mask4.*x;

% Conteggio
bwconncomp(mask4)

% Visualizzazione
figure; 
subplot(231); imshow(R,[]); title('banda R');
subplot(232); imshow(mask); title('Clustering');
subplot(233); imshow(mask1); title('Blurring');
subplot(234); imshow(mask2); title('Opening');
subplot(235); imshow(mask3); title('Thresholding');
subplot(236); imshow(mask4); title('Dilate');
figure;
subplot(121); imshow(x,[]); title('Immagine');
subplot(122); imshow(y,[]); title('Detection capocchie');