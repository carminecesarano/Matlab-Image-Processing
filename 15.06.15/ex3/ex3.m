close all; clear all; clc;
x = double(imread('coins_and_keys.png'));

% Clustering binario
[idx,centroidi] = kmeans(x(:),2);
[~,index] = min(centroidi);
mask = zeros(size(x));
mask(idx==index) = 1;

% Closing per rimuovere il rumore
se = strel('disk',4,4);
mask1 = imclose(mask,se);

% Erosione (Money mask)
se = strel('disk',35,8);
mask2 = imopen(mask1,se);

% Key mask erosione
mask3 = mask1-mask2;
se = strel('rectangle',[2 6]);
mask4 = imerode(mask3,se);

% Visualizzazione
figure; 
subplot(231); imshow(x,[]); title('Originale');
subplot(232); imshow(mask,[]); title('Clustering binario');
subplot(233); imshow(mask1,[]); title('Closing');
subplot(234); imshow(mask2,[]); title('Money mask (Erosione)');
subplot(235); imshow(mask3,[]); title('Key mask')
subplot(236); imshow(mask4,[]); title('Key mask (Erosione)');
