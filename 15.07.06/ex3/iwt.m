function x = iwt(w,lev);
% IWT trasformata wavelet di Haar 1D inversa
% x=iwt(w,lev) inverte la trasformata su nlev livelli dell'ingresso w

ilp = [1/sqrt(2), 1/sqrt(2)];      % filtro LP di sintesi
FL  = length(ilp);                 % lunghezza del filtro
n   = [0:FL-1];
ihp = [(-1).^n].* fliplr(ilp);     % filtro HP di sintesi

N = length(w)/2^(lev-1);
for i=1:lev,    
    ewlp = zeros(1,N); ewlp(1:2:N) = w(1:N/2);     % espansione
    ewlpext = padarray(ewlp',FL-1,'circular');     % estensione ai bordi
    lrec = conv(ilp,ewlpext);                      % filtraggio passa-basso
    ewhp = zeros(1,N); ewhp(1:2:N)=w(N/2+1:N);     % espansione
    ewhpext = padarray(ewhp',FL-1,'circular');     % estensione ai bordi
    hrec = conv(ihp,ewhpext);                      % filtraggio passa-alto
    xrec = lrec + hrec;                            % ricostruzione
    xrec = xrec(2*FL-2:2*FL-2+N-1);
    w(1:N) = xrec;                                 % aggiorna w
    N = N*2;
end
x = w;
