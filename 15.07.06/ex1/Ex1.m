x = double(imread('Einstein.tif'));

% Istogramma luminanze
h = hist(x(:),0:255);
figure(1); subplot(121); bar(h); title('istogramma');

% Enhancement 1 (Equalizzazione dell'istogramma)
y1 = enhanc1(x);

% Enhancement 2 (FSHS + Sharpening)
y2 = enhanc2(x,0.8);    % nel dominio frequenziale
y3 = enhanc3(x,0.8);    % nel dominio spaziale

% Visualizzazione
figure(2);
subplot(221); imshow(x,[0 255]); title('originale');
subplot(222); imshow(y1,[0 255]); title('enhancement 1');
subplot(223); imshow(y2,[0 255]); title('enhancement spazio');
subplot(224); imshow(y3,[0 255]); title('enhancement frequenza');

