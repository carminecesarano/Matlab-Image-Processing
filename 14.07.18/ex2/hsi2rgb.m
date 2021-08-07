function y = hsi2rgb(x);

% estrazione componenti
H = x(:,:,1)*2*pi;
S = x(:,:,2);
I = x(:,:,3);

% inizializzazione
R = zeros(size(x,1), size(x,2));
G = zeros(size(x,1), size(x,2));
B = zeros(size(x,1), size(x,2));

% settore RG
idx = find((0 <= H) & (H < 2*pi/3));
B(idx) = I(idx).*(1-S(idx));
R(idx) = I(idx).*(1+S(idx).*cos(H(idx))./cos(pi/3-H(idx)));
G(idx) = 3*I(idx) - (R(idx) + B(idx));

% settore GB
idx = find((2*pi/3 <= H) & (H < 4*pi/3));
R(idx) = I(idx).*(1-S(idx));
G(idx) = I(idx).*(1+S(idx).*cos(H(idx)-2*pi/3)./cos(pi-H(idx)));
B(idx) = 3*I(idx) - (R(idx) + G(idx));

% settore BR
idx = find((4*pi/3 <= H) & (H <= 2*pi));
G(idx) = I(idx).*(1-S(idx));
B(idx) = I(idx).*(1+S(idx).*cos(H(idx)-4*pi/3)./cos(5*pi/3-H(idx)));
R(idx) = 3*I(idx) - (G(idx) + B(idx));

% ricostruzione immagine RGB
y = cat(3,R,G,B);