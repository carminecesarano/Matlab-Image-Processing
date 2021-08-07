function W = fwt2d(X,lev)
% FWT2d trasformata wavelet 2D diretta
% W = fwt2d(X,lev) realizza la trasformata su lev livelli dell'ingresso X 
 
W = X; 
[M,N]=size(W); 
for l=1:lev,
    for i=1:M                    % filtraggio lungo le righe
       riga=W(i,1:N);            % riga da trasformare
       [wtriga]=fwt(riga,1);     % WT monodimensionale con lev=1
       W(i,1:N)=wtriga;          % posizionamento
    end
    for j=1:N,                   % filtraggio lungo le colonne
       riga = W(1:M,j);          % colonna da trasformare
       [wtriga] = fwt(riga',1);
       W(1:M,j) = wtriga';       % posizionamento
    end;
    M = M/2;                     % dimezza le dimensioni
    N = N/2;                     % per il passo successivo
end; 
