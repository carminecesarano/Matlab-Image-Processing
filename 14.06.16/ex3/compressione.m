function y = compressione(x)

    xdct = dct2(x);
    y = zeros(size(x));
    y(1,1) = xdct(1,1);

end