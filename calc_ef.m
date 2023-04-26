function [Ef] = calc_ef(d_array,IL,IR,IL_x,IR_x, IL_y, IR_y)
%CALC_EF calcultes Ef as described Eq. 3.
%
Ef = 0;
[m,n] = size(d_array);
for x=1:m
    for y=1:n
        d = d_array(x,y);
        shifted_x = x + d;
        if (shifted_x > m) || (shifted_x < 1)
            shifted_x = min(max(shifted_x, 1), m);
        end
        brightness = (IL(x,y)- IR(shifted_x,y))^2;
        grad_x = (IL_x(x,y)- IR_x(shifted_x,y))^2;
        grad_y = (IL_y(x,y)- IR_y(shifted_x,y))^2;
        Ef = Ef + brightness + grad_x + grad_y;
    end
end

end

