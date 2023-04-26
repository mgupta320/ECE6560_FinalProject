function [phi] = calc_phi(x,y,d, IL, IR, IL_x, IR_x, IR_xx, IL_y, IR_y, IR_yx)
%CALC_PHI Calculates phi as detailed in Eq. 21.
[m, n] = size(IL);
shifted_x = x + d;
if (shifted_x > m) || (shifted_x < 1)
    shifted_x = min(max(shifted_x, 1), m);
end

brightness = (IL(x,y)- IR(shifted_x,y)) * IR_x(shifted_x,y);
grad_x = (IL_x(x,y)- IR_x(shifted_x,y)) * IR_xx(shifted_x,y);
grad_y = (IL_y(x,y)- IR_y(shifted_x,y)) * IR_yx(shifted_x,y);

phi = brightness + grad_x + grad_y;
end

