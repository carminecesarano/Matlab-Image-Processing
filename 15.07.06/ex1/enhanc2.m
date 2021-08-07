function y = enhanc2(x,sigma)

m = min(x(:));
M = max(x(:));

fshs = 255*(x-m)/(M-m);

% Griglia
[M,N] = size(fshs);
n = -1/2:1/N:1/2-1/N;
m = -1/2:1/M:1/2-1/M;
[l,k] = meshgrid(n,m);

% DFT
FSHS = fftshift(fft2(fshs));

% Gaussian High-Pass Filter 
D = sqrt(l.^2+k.^2);
H = exp(-D.^2/(2*sigma^2));

% Filtraggio
HPF = FSHS.*(1-H);
hpf = real(ifft2(ifftshift(HPF)));

% Sharpening
y = fshs+hpf;

end

