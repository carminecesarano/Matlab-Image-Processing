 function [p,med] = exKmeans(c,k,med)
    N = size(c,1);
    h = size(c,2);
    %cmin = min(c(:)); cdin = max(c(:))-cmin;
    %med_old = zeros([k,h]);
    %med = cdin.*(rand([k,h]))+cmin;
    if nargin<3
        perm = randperm(N);
        med = c(perm(1:k),:);
    end;
    med_old = med+10;
    
    while ( norm(med_old(:)-med(:)) > (10^(-3))*norm(med_old(:)) )
        med_old = med;
        d = zeros(N,k);
        for index = 1:k,
           d(:,index) = (sum((c - repmat(med(index,:),N,1)).^2,2));
        end;
        
        [dmin p] = min(d,[],2);
        
        for index = 1:k,
            list = find(p==index);
            if numel(list)>0,
                claster  = c(list,:);
                med(index,:) = mean(claster,1);
            else
                med(index,:) = c(ceil(N*rand()),:);
            end
        end;
        
    end;


