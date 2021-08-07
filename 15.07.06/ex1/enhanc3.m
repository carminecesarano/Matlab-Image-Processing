function y = enhanc2(x,sigma)

% Full Scale Histogram Scretch
m = min(x(:));
M = max(x(:));
fshs = 255.*(x-m)/(M-m);

% Filtro Gaussiano
sigma = 0.8;
h = fspecial('gaussian',[3 3],sigma);
LPF = imfilter(fshs,h,'symmetric');       % passa basso

HPF = fshs-LPF;  % passa alto

% Sharpening
y = fshs + HPF;


end