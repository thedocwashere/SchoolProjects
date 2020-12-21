function [matrix_B] = generateMatrixB(cell_v,num_node,num_voltage)
%generateMatrixG function generates the B matrix from MNA Algorithm. It
%takes number of nodes, number of voltage sources and voltage cell as inputs
%and returns the B matrix.

%Preallocating the B matrix.
matrix_B = zeros(num_node,num_voltage);

%Checking for if the circuit has any voltage sources.If not the function 
%returns zero matrix.
if num_voltage > 0
    %Iterating for every voltage source
    for source_num = 1:num_voltage
        %Determining the node numbers which the voltage source connected.
        big_node = cell_v{3}(source_num);
        small_node = cell_v{2}(source_num);
        
        %Checking if the voltage source grounded or not.
        if cell_v{2}(source_num) ~= 0
            
            %If the value of voltage source is positive it means that node
            %voltage of bigger node is bigger than node voltage of smaller
            %node. It is checking the value and designing the B matrix
            %accordingly with the help of MNA Algorithm.
            if cell_v{4}(source_num) > 0
                matrix_B(big_node,source_num) = 1;
                matrix_B(small_node,source_num) = -1;
            elseif cell_v{4}(source_num) < 0
                matrix_B(big_node,source_num) = -1;
                matrix_B(small_node,source_num) = 1;
            end
        %If the voltage source grounded it only contributes one number to
        %B matrix.
        elseif cell_v{2}(source_num) == 0 
            %If the value of voltage source is positive this number is 1.
            if cell_v{4}(source_num) > 0
                matrix_B(big_node,source_num) = 1;
            %If the value of voltage source is negative this number is -1.
            elseif cell_v{4}(source_num) < 0
                matrix_B(big_node,source_num) = -1;
            end

        end
    end
end
end