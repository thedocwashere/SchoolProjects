function [matrix_G] = generateMatrixG(cell_r,num_node)
%generateMatrixG function generates the G matrix from MNA Algorithm. It
%takes number of nodes and resistor cell as inputs and returns the G
%matrix.

%Preallocating the G matrix.
matrix_G = zeros(num_node);

%Checking for if the circuit has any resistors. If not the function returns
%zero matrix.
if ~isempty(cell_r)
    %Calculating the number of resistors by measuring the size of
    %voltage cell array
    [~,num_res] = size(cell_r{1});
    
    %Creating each of the diagonal entries of G matrix by MNA Algorithm.
    for i = 1:num_node
        sum_of_conductance = 0;
        
        %Checking all resistors to see which ones connected to node i.
        for j = 1:num_res
            if cell_r{2}(j) == i || cell_r{3}(j) == i
                res_value = double(cell_r{4}(j));
                sum_of_conductance = sum_of_conductance + 1/res_value ;
            end
        end
        %Calculating the (i,i) entry of matrix G.
        matrix_G(i,i)=sum_of_conductance;
    end
    
    %Creating the off-diagonal entries of G matrix by MNA Algorithm.
    for k = 1:num_res
        %Checking if the resistor connected to ground or not. If not it
        %contributes to the off-diagonal entries.
        if cell_r{2}(k) ~= 0 
            %Determining the node numbers which the resistor connected.
            row = cell_r{2}(k);
            column = cell_r{3}(k);
            
            res_value = double(cell_r{4}(k));
            
            %Calculating the contribution to off-diagonal entries.
            matrix_G(row,column) = matrix_G(row,column)- 1/res_value;
            matrix_G(column,row) = matrix_G(column,row)- 1/res_value;
        end
    end
end

end