function y = QU1(x,b)

    xmax = max(x(:));
    xmin = min(x(:));

    bit = b;                % Numero di bit
    N = 2^bit;              % Livelli di restituzione
    delta = (xmax-xmin)/N;  % Passo di quantizzazione
    
    y = delta.*(round(x./delta));
    
end