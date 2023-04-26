function [rho] = calc_rho(x, y, d_array)
%CALC_RHO Calculates rho as detailed in Eq. 22.
%   rho = d(+Delta{x})+d(-Delta{x}) + d(+Delta{y})+d(-Delta{y}) - 4d
d = d_array(x,y);
dpdx = d_array(x+1,y);
dmdx = d_array(x-1,y);
dpdy = d_array(x,y+1);
dmdy = d_array(x,y-1);
rho = dpdx + dmdx + dpdy + dmdy - 4*d; 
end

