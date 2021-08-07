function [y1,y2] = adapt_filt(x)

    % stima y1
    loc_med = colfilt(x, [5 5], 'sliding', @mean);
    loc_std = colfilt(x, [5 5], 'sliding', @std);
    
    Cx = loc_std ./ loc_med;
    Cu = 1/(2*sqrt(2));
    mask = (Cu.^2./Cx.^2) < 1;
    Wl = ((1-(Cu.^2./Cx.^2))./(1+Cu.^2));
    
    y1 = (x.*Wl + loc_med.*(1-Wl)).*(mask) + (1-mask).*loc_med;
   
    % stima y2
    loc_med = colfilt(x, [15 15], 'sliding', @mean);
    loc_std = colfilt(x, [15 15], 'sliding', @std);
    
    Cx = loc_std ./ loc_med;
    Cu = 1/(2*sqrt(2));
    mask = (Cu.^2./Cx.^2) < 1;
    Wl = ((1-(Cu.^2./Cx.^2))./(1+Cu.^2));
    
    y2 = (y1.*Wl + loc_med.*(1-Wl)).*(mask) + (1-mask).*loc_med;
    
end