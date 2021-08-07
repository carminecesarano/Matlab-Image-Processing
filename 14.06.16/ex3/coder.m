function Y = coder(x)

    
    % Trasformata DCT (conservo solo la componente DC)
    mask = zeros(8); mask(1,1) = 1;
    fun = @(x) dct2(x).*mask;
    
    x_dct = blkproc(x,[8 8],fun);
    [M N] = size(x_dct);
    
    % Stima basata sul valore DC precedente
    err = x_dct(1:M,9:N) - x_dct(1:M,1:N-8);
    err = [x_dct(1:M,1:8), err];
    
    % Quantizzazione uniforme dell'errore
    delta = 2;
    err = delta*round(err./delta);

    % Trasmission dell'errore quantizzato sul canale
    Y = err;        

end

