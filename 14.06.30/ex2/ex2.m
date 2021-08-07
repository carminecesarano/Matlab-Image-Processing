close all; clear all; clc;
x = double(imread('test.bmp'));

% Edge detection
y1 = edge(x,'canny',0.6,4);
y2 = edge(x,'roberts');

% Gradiente morfologico
x1 = imfilter(x,fspecial('average',7));
x1 = x1<30;
se = strel('disk',1);
x2 = imdilate(x1,se);
x3 = imerode(x1,se);
grad = (x2-x3);
grad = grad>0.1*(max(grad(:)));


% Visualizzazione
figure; 
subplot(221); imshow(x,[]); title('Originale');
subplot(222); imshow(y1); title('Canny');
subplot(223); imshow(y2); title('Roberts');
subplot(224); imshow(grad); title('Gradiente morfologico');