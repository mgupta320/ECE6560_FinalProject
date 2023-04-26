function [Ep] = calc_ep(d_array)
%CALC_EP calculates Ep as defined in Eq. 4

[m,n] = size(d_array);
[dx, dy] = calc_I_fd(d_array);
Ep = 0;
for x=1:m
    for y=1:n
        Ep = Ep + dx(x,y)^2 + dy(x,y)^2;
    end
end

end

