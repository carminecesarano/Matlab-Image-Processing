function y = QU2(x,b)
    
    % Utilizzo b bit per quantizzare l'immagine, quindi rimuovo (8-b) bit
    % meno significativi
    
    % Contrast Stretch
    xmax = max(x(:));
    xmin = min(x(:));
    x_FSHS = 255*round((x-xmin)./(xmax-xmin));
   
    xq = zeros(size(x_FSHS));
    for i=1:b
       bitplane = bitget(x_FSHS,i); 
       bitset(xq,i,bitplane);
    end
    
    % Rimozione Bit-Plane
    for i=1:(8-b),
        x_FSHS = bitset(x_FSHS, i, 0);
    end
    
    % Ripristino dinamica
    y = (xq*(xmax-xmin)/255)+xmin;
       
end



