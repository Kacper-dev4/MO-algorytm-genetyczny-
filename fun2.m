function [out] = fun2(x)

dlu = length(x);
d = zeros(dlu,1);
    for i=1:dlu
        d(x(i)) = d(x(i)) + 1;
        
    end

out = sum(d(d>1));

end

