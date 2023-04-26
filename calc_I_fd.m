function [Ix,Iy] = calc_I_fd(I)
%CALC_I_FD Calculates first partial derivates of I
%   In = (I(+delta(n))-I(-delta(n)))/2
[m,n] = size(I);
Ix = zeros(m,n);
Iy = zeros(m,n);
padded_I = zeros(m+2,n+2);
padded_I(2:m+1,2:n+1)=I;
for x=2:m+1
    for y=2:n+1
        i = x-1;
        j = y-1;
        Ix(i,j) = (padded_I(x+1,y)-padded_I(x-1,y))/2;
        Iy(i,j) = (padded_I(x,y+1)-padded_I(x,y-1))/2;
    end
end
end

