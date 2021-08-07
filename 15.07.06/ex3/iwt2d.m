function Y = iwt2d(W,lev);
% IWT2d trasformata wavelet 2D inversa
% Y = iwt2d(W,lev) inverte la trasformata su lev livelli dell'ingresso W 

[M,N] = size(W);
N = N/2^(lev-1);
M = M/2^(lev-1);
for l=1:lev,
    for i=1:M                    % filtraggio lungo le righe
       riga=W(i,1:N);            % riga da anti-trasformare
       [wtriga]=iwt(riga,1);     % IWT monodimensionale con lev=1
       W(i,1:N)=wtriga;          % posizionamento
    end
    for j=1:N,                   % filtraggio lungo le colonne
       riga = W(1:M,j);          % colonna da anti-trasformare
       [wtriga] = iwt(riga',1);
       W(1:M,j) = wtriga';       % posizionamento
    end;
    M = M*2;                     % raddoppia le dimensioni
    N = N*2;                     % per il passo successivo
end; 
Y = W;