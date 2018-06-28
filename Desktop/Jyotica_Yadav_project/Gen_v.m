function v = Gen_v(h, noise_power, u)
    conj_h = conj(fliplr(h));                       % Generating h*(-n)
    x = conv(h, conj_h);                            % x(n)=h(n)*(h*(-n))

    syms z;
    len = length(x);                                % Calculating the length of the convolutional sum x
    for i = 1:len
        z_elements(i)= x(i)*z^[(i-1)];              % Determining the z transform
    end

    zTransNum = sum(z_elements);                    % Representation of z transform on the command prompt
    roots_zTrans = roots(x);                        % Determining the roots of Z transform

    j=1;
    for i=1:length(roots_zTrans)                    % Determining the roots of Z transform
        if (abs(roots_zTrans(i))< 1)
            roots_Fz(j) = roots_zTrans(i);
            j= j+1;
        end
    end

    coeff_Fz = poly(roots_Fz);                      % Determining fn (coefficients of Fz)
    
    v = conv(coeff_Fz, u)+ noise_power;             % Calculation of vn which is input to the equalizer
end