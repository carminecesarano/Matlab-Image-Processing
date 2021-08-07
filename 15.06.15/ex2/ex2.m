close all; clear all; clc;
x = double(imread('test.png'));
mask = double(imread('maschera.png'));

% Componente verde
G = x(:,:,2);

% Filtraggio
h = [0 1/4 0; 1/4 -1 1/4; 0 1/4 0];
F = imfilter(G,h,'symmetric');

% Varianze per blocchi 8x8
Vo = blkproc(F,[8 8],@varianza,1);
Vi = blkproc(F,[8 8],@varianza,2);
D = Vo-Vi;
figure;
subplot(141); imshow(Vo,[]); title('Varianze originali');
subplot(142); imshow(Vi,[]); title('Varianze interp');
subplot(143); imshow(D,[]); title('Vo-Vi'); 

% Filtraggio 
h = fspecial('average',7);
Dsmooth = imfilter(D,h,'same');
subplot(144); imshow(Dsmooth,[]); title('Smoothing');

% Statistica di decisione
S = imresize(Dsmooth,size(G));

% Maschera di rivelazione (Thresholding)
M = S>-8;

% Visualizzazione
figure; 
subplot(231); imshow(x/255,[]); title('Originale');
subplot(232); imshow(mask,[]); title('Maschera ideale');
subplot(233); imshow(S,[]); title('Statistica di decisione');
subplot(234); imshow(M,[]); title('Maschera di decisione');

function y = varianza(x,par)
    mask_o = [1 0 1 0 1 0 1 0;
              0 1 0 1 0 1 0 1
              1 0 1 0 1 0 1 0
              0 1 0 1 0 1 0 1
              1 0 1 0 1 0 1 0
              0 1 0 1 0 1 0 1
              1 0 1 0 1 0 1 0
              0 1 0 1 0 1 0 1];
    mask_i = 1-mask_o;
    
    if (par==1)
        y = std2(x.*mask_o).^2;
    else
        y = std2(x.*mask_i).^2;
    end
end



