function y = codec(x,K,L)

    % DCT custom
    xdct = blkproc(x,[K L],@dctcustom);
    
    % Quantizzazione uniforme
    xmax = max(xdct(:));  xmin = min(xdct(:));
    delta = 16;
    xq = delta*(round(xdct/delta));
    
    % Antitrasformata
    y = blkproc(xq,[K L],@idct2);
    
end

function y = dctcustom(x)
    
    % Conservati solo 8 coefficienti più grandi in modulo
    xdct = dct2(x);
    [~,index] = sort(abs(xdct(:)));
    y = xdct;
    y(index(1:end-8)) = 0;
    
end