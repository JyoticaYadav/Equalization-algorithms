function Plotting(y, u, v)
    range_plot = 475:500;
    figure
    subplot(2,2,1)
    plot(range_plot, u(200,475:500));           % Plot of input values from n =475:500
    title("Input Signal");
    
    subplot(2,2,2)
    plot(range_plot, v(200,475:500));           % Plot of noisy signal from n =475:500
    title("Signal added with noise");
    
    subplot(2,2,3)                              % Plot of input values along with the signal added with noise
    plot(range_plot, u(200,475:500));           
    hold on;
    plot(range_plot, v(200,475:500));
    title("Comparison of the input and the samples after adding the channel noise");
    legend('Input values','Signal added with noise')
    
    subplot(2,2,4)                              % Plot of output values obtained after equalization
    plot(range_plot,y(200, range_plot));                  
    title("Output obtained from equalizer");
    
end
        






