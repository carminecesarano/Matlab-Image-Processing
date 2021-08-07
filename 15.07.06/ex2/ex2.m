close all; clear all; clc;
x = double(imread('libro.jpg'));
figure(1);  subplot(231); imshow(x,[]); title('Originale');

% Varianza 8x8
var = blkproc(x,[8 8],@std2).^2;

% Soglie
s1 = var(floor(0.25*length(sort(var(:),'descend'))));
s2 = var(floor(0.05*length(sort(var(:),'descend'))));

% Trasformata DCT custom
figure(1);
for K=1:5
    y(:,:,K) = blkproc(x,[8 8],@dct_custom,s1,s1,K);
    MSE(K) = mean2((y-x).^2);
    subplot(2,3,K+1); imshow(y(:,:,K),[]); 
end

% Plot MSE
figure; plot(1:5,MSE,'-*'); xlabel('K'); ylabel('MSE');

function y = dct_custom(x,s1,s2,K)

    [M N] = size(x);
    
    xdct = dct2(x);
    s = std2(x).^2;
    
    y = zeros(size(x));
    if (s<=s1) 
       y(1,1) = xdct(1,1);
    elseif (s1<s<s2)
       mask = fliplr(triu(ones(M),M-K));
       y = xdct.*mask;
    else
       y = xdct;
    end
    
    y = idct2(y);
end

