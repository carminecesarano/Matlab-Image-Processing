function y = decoder(Y)

    [M N] = size(Y)
    
    xrec = zeros(M,N);
    xrec(:,1) = Y(:,1);
    
    % Dall'errore quantizzato, sommo i valori DC_cur+DC_old per
    % ricostruire il segnale
    for i=9:N
        xrec(:,i) = Y(:,i) + xrec(:,i-8);
    end
    
    % Antitrasformo il segnale quantizzato
    y = blkproc(xrec,[8 8], @idct2)
        
end