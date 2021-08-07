function y = filter(x)

X = fft2(x);

a = [abs(X(1,2)),angle(X(1,2)),abs(X(1,3)),angle(X(1,3)),abs(X(2,3)),angle(X(2,3)),abs(X(3,3)),angle(X(3,3))];

% Vettore binario
c = a>0;

% Conversione in decimale
y = bi2de(c,2);
