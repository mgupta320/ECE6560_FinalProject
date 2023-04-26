function [d_array,E] = calc_disp(IL, IR,lambda, delta_t, num_iter)
%CALC_DISP Summary of this function goes here

[m,n] = size(IL);

d_array = zeros(m, n); %initialize d as all zeros
E = zeros(1, num_iter);

[IL_x, IL_y] = calc_I_fd(IL);
[IR_x, IR_y] = calc_I_fd(IR);
[IR_xx,IR_yx] = calc_I_sd(IR);

for iter=1:num_iter
    new_d_array = zeros(m,n);
    for x=2:(m-1)
        for y=2:(n-1)
            d = d_array(x,y);
            phi = calc_phi(x,y,d, IL, IR, IL_x, IR_x, IR_xx, IL_y, IR_y, IR_yx);
            rho = calc_rho(x,y,d_array);
            new_d = delta_t*(1-lambda)*phi + delta_t*lambda*rho+d;
            new_d = round(new_d);
            shifted_x = x + new_d;
            if shifted_x > m
                new_d = m - x;
            elseif shifted_x < 1
                new_d = x - 1;
            end
            new_d_array(x,y) = new_d;
        end
    end
    d_array = new_d_array;
    Ef = calc_ef(d_array, IL, IR, IL_x,IR_x,IL_y,IR_y);
    Ep = calc_ep(d_array);
    curr_E = 1/2*(1-lambda)*Ef + 1/2*lambda*Ep;
    E(iter) = curr_E;
    if mod(iter,10) == 0
        fprintf("Iteration %d: E = %.3e \n", iter, curr_E);
    end
end



end

