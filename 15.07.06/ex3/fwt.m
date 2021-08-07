function w = fwt(x,lev);
% FWT trasformata wavelet di Haar 1D diretta
% w=fwt(x,lev) realizza la trasformata su lev livelli dell'ingresso x

lpf = [1/sqrt(2), 1/sqrt(2)];      % coefficienti h filtro Haar
%lpf = [1+sqrt(3) 3+sqrt(3) 3-sqrt(3) 1-sqrt(3)]/(4*sqrt(2));
FL  = length(lpf) ;                % lunghezza del filtro
n   = [0:FL-1];
hpf = [(-1).^n].* fliplr(lpf);     % coefficienti g filtro Haar
lpf = fliplr(lpf);                 % filtro LP di analisi
hpf = fliplr(hpf);                 % filtro HP di sintesi

for i=1:lev,
    N  = length(x);                         % lunghezza del segnale
    xext = padarray(x',FL-1,'circular');    % estensione periodica ai bordi
    l = conv(xext,lpf);                     % filtraggio passabasso
    ldec = l(FL+1:2:N+FL-1);                % decimazione
    h = conv(xext,hpf);                     % filtraggio passaalto
    hdec = h(FL+1:2:N+FL-1);                % decimazione
    w(1:N) = [ldec,hdec];                   % coefficienti wavelet
    x = w(1:N/2);
end
