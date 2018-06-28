clc;
clear all;
close all;
 
Iterations = 200;                 % Number of Iterations
number_of_Symbols= 500;           % Number of Transmitted symbols
h = [0.2194, 1.000, 0.2194];      % Channel Coefficients
noise_power = 0.001;              % Defined noise power
 
u = randn(Iterations, number_of_Symbols);            % Initializations for u and v
v = randn(Iterations, number_of_Symbols + length(h)-1);     
% Length of the convolutional sum is N+M-1 where N and M is the length of the %individual sequences                                                            
                                                                
N = 7;                            % Desired response is N shifted version of u
tap_weights = 11;                 % Number of tap weights defined
step_size = 0.0550;           % Step size defined
lambda = 0.5;                     % Parameter for RLS algorithm
a = 0.05;                         % Parameter for NLMS algorithm

figure()
for i=1:Iterations
   		u(i,:) = Gen_trans_sym(number_of_Symbols);   % Creating an array of transmitted symbols [1,-1]
   		v(i,:) = Gen_v(h, noise_power, u(i,:));      % Generating the sequence vn
    	% Least Mean Square (LMS) equalization algorithm
        [y_LMS(i,:), e_LMS(i,:)]= LMS_algorithm(step_size, tap_weights, number_of_Symbols, u(i,:), v(i,:), N); 
   		        
        plot(abs(e_LMS(i,:)))                  
        % Plotting the absolute value of error for each iteration                
   		hold on;
end
title("Convergence plot of error in LMS algorithm with step size 0.0550");

figure()
for i=1:Iterations
   		u(i,:) = Gen_trans_sym(number_of_Symbols);   % Creating an array of transmitted symbols [1,-1]
   		v(i,:) = Gen_v(h, noise_power, u(i,:));      % Generating the sequence vn
    	% Least Mean Square (LMS) equalization algorithm
        [y_NLMS(i,:), e_NLMS(i,:)]= NLMS_algorithm(step_size, tap_weights, number_of_Symbols, u(i,:), v(i,:), a, N);
                
        plot(abs(e_NLMS(i,:)))                    
        % Plotting the absolute value of error for each iteration                
   		hold on;
end
title("Convergence plot of error in NLMS algorithm with step size 0.0550");

figure()
for i=1:Iterations
   		u(i,:) = Gen_trans_sym(number_of_Symbols);   % Creating an array of transmitted symbols [1,-1]
   		v(i,:) = Gen_v(h, noise_power, u(i,:));      % Generating the sequence vn
    	% Least Mean Square (LMS) equalization algorithm
        [y_RLS(i,:), e_RLS(i,:)]= RLS_algorithm(tap_weights, u(i,:), v(i,:), lambda, number_of_Symbols, N);
                
        plot(abs(e_RLS(i,:)))                    
        % Plotting the absolute value of error for each iteration                
   		hold on;
end
title("Convergence plot of error in RLS algorithm with lambda 0.5");

y_LMS_mean = mean(y_LMS);                       
% Calculating the mean of output obtained after 200 iterations
e_LMS_mean = mean(e_LMS);                       
% Calculating the mean of the error generated after 200 iterations

y_NLMS_mean = mean(y_NLMS);    
e_NLMS_mean = mean(e_NLMS); 

y_RLS_mean = mean(y_RLS);    
e_RLS_mean = mean(e_RLS); 

figure
plot(e_LMS_mean);                               % Plotting the mean error in LMS  
title("Average value of error in LMS algorithm with step size 0.0550");

figure
plot(e_NLMS_mean);                              % Plotting the mean error in NLMS 
title("Average value of error in NLMS algorithm with step size 0.0550");

figure
plot(e_RLS_mean);                               % Plotting the mean error in RLS
title("Average value of error in RLS algorithm with step size 0.5");
 
Plotting(y_LMS, u, v);              % Plots for LMS algorithm
Plotting(y_NLMS, u, v);             % Plots for LMS algorithm
Plotting(y_RLS, u, v);              % Plots for LMS algorithm