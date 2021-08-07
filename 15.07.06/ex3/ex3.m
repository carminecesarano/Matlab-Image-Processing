close all; clear all; clc;
x = double(imread('fmri.gif'));
noisy = double(imread('fmri_noisy.jpg'));

% Filtraggio nel dominio Wavelet
y = filtra(noisy);
MSE = mean2((y-x).^2)

% Visualizzazione
figure;
subplot(131); imshow(x,[]); title('Originale');
subplot(132); imshow(noisy,[]); title('Noisy');
subplot(133); imshow(y,[]); title('Filtrata');


function y = filtra(x)
    
    [M N] = size(x);

    % Trasformata Wavelet 5 livelli
    lev = 5;  xw = fwt2d(x,lev);
    LL = xw(1:M/(2^lev),1:N/(2^lev));
        
    % Stima deviazione standard rumore
    lev = 1; xw1 = fwt2d(x,1);   
    HH = xw1(M/2+1:M,N/2+1:N);
    sigma = median(abs(HH(:)))/0.6475;
    
    % Thresholding (in modulo) dei coefficienti Wavelet
    T = sigma*sqrt(2*log(M*N));
    xw(abs(xw)<T) = 0;
    
    % Thresholding solo banda dettaglio (ricopio la banda base originale)
    lev = 5;
    xw(1:M/(2^lev),1:N/(2^lev)) = LL;
    
    % Antitrasformata
    y = iwt2d(xw,lev);
end