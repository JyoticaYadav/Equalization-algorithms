function u = Gen_trans_sym(number_of_Symbols)
    u = randi([0,1], 1, number_of_Symbols);         % Random array of transmitted symbols generated for integers between 0 and 1 
    equation = @(i)(2*i-1);                         % Equation to convert 0 and 1 into -1 and 1

    for iterations = 1:number_of_Symbols            % Perfoming data manupulation on each entry
        u(iterations) = equation(u(iterations)); 
    end
end