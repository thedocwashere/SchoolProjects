%Taking the file name as a string from user.
file_name = input("Please enter the file name of the file with its file extension (.txt, etc.) which represents the circuit: ","s");

%Calling the getFileContent function and assign its returning value to
%main_cell variable.
main_cell = getFileContent(file_name);

%Calling the createElementCells function and assign its returning values to
%cell variables.
[cell_v,cell_i,cell_r] = createElementCells(main_cell);

%Determining the number of nodes in the circuit by looking at third column 
%of file contents which has bigger node numbers in it. Afterwards it calculates 
%the maximum of these numbers.
num_node = max(main_cell{3});

%Iterating through all resistors to see which resistor is load resistor.
for j = 1:length(cell_r{1})
    if startsWith(cell_r{1}(j),"RL")
        initial_value = cell_r{4}(j);
        
        %Determining the interval of load resistor. If it is bigger than 50
        %Ohms the interval is [resistor-50 resistor+50]. If it is smaller
        %than 50 than the interval is [1,100]
        if (initial_value)-50 >= 0
            all_res_values = [(initial_value-50):(initial_value+50)];
        elseif (initial_value-50) < 0 
            all_res_values = [1:100];   
        end
        
        %Determining the nodes which RL connected.
        node1 = cell_r{2}(j);
        node2 = cell_r{3}(j);
        
        index = 1;
        
        %Preallocating power value vector..
        power_value = zeros(1,100);
        
        %Solving the circuit according to the algorithm for each value of
        %resistor.
        for res = all_res_values(1):all_res_values(end)
            
            %Assigning the resistor value to the cell array in order to
            %solve the circuit.
            cell_r{4}(j) = res; 
            
            %Calling the generateMatrices function and assign its returning values to
            %matrix_A and vector_z.
            [matrix_A,vector_z] = generateMatrices(cell_v, cell_i, cell_r,num_node);
            
            %Solving the equation Ax=z from MNA Algorithm.
            solution = (matrix_A)\vector_z;
            
            %Checking if the resistor grounded or not.
            if node1 ~= 0
                %If not grounded the current is difference of node voltages
                %divided by resistor value.
                current = (solution(node1)-solution(node2))/res;
                
            elseif node1 == 0
                %If it is grounded the current is difference between node
                %voltage of bigger node and 0. Again it is divided by
                %resistor value. 
                current = (0-solution(node2))/res;
            end
            %Calculating the power for corresponding resistor value and
            %storing this value in a power_value vector.
            power_value(index) = res*current^2;
            
            %Incrementing the index value by 1.
            index = index + 1;
        end
    end
end

%Determining the maximum power and its index.
[max_power,ind] = max(power_value);
%Determining the corresponding resistor value.
res_of_max_power = all_res_values(ind); 
%Plotting the resistance/power graphic and marking the maximum value of
%power by red X.
plot(all_res_values,power_value, res_of_max_power,max_power,"rx")

%Putting labels and title to the graphic.
xlabel("Resistor Value (Ohm)");
ylabel("Power Value (Watt)");
title("Power Dissipated in Load Resistance");

