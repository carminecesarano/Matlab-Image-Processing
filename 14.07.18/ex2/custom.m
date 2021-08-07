function y = custom(x)

 x = fft2(x);

 % Vettore
 a = [real(x(1,2)),imag(x(1,2)),real(x(1,3)),imag(x(1,3)),
     real(x(2,3)),imag(x(2,3)),real(x(3,3)),imag(x(3,3))];

 % Vettore binario
 c = zeros(size(a));
 for i=1:8
    if (a(i)>0),
        c(i) = 1;
    else 
        c(i) = 0;
    end
 end
 
 y = 0;
 
 % Conversione in decimale
 for i=1:8
     y = y + c(i)*2^i;
 end

end