function [IR_xx,IR_yx] = calc_I_sd(IR)
%CALC_I_SD Calculates second order partial derivates of IR
[m,n] = size(IR);
IR_xx = zeros(m,n);
IR_yx = zeros(m,n);
padded_I = zeros(m+2,n+2);
padded_I(2:m+1,2:n+1)=IR;
for x=2:m+1
    for y=2:n+1
        i = x-1;
        j = y-1;
        IR_xx(i,j) = padded_I(x+1,y) -2*padded_I(x,y) + padded_I(x-1,y);
        IR_yx(i,j) = (padded_I(x+1,y+1)-padded_I(x+1,y-1)-padded_I(x-1,y+1)+padded_I(x-1,y-1))/4;
    end
end
end

