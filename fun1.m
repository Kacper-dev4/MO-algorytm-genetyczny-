function [out] = fun1(x)

dlu = length(x);
d1 = zeros(dlu/2,1);
d2 = d1;

    for i=1:dlu/2
        d1(x(i)) = d1(x(i)) + 1; 
        d2(x(i+dlu/2)) = d2(x(i+dlu/2)) + 1;    
    end
 
out = sum(d1(d1>1)) + sum(d2(d2>1));

end

