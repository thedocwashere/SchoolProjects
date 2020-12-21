function [vector_e] = generateVectorE(cell_v,num_voltage)
%generateVectorE function generates the E vector from MNA Algorithm. It
%takes number of voltage sources and voltage cell as inputs and returns 
%the E vector.

%Preallocating the E vector.
vector_e = zeros(num_voltage,1);

%Checking for if the circuit has any voltage sources.If not the function 
%returns zero vector.
if num_voltage > 0
    for i = 1:num_voltage
        %Taking the absolute value of the voltage value. Because it can be
        %negative at netlist if the node voltage of NodeNumber@ThirdColumn 
        %is smaller than NodeNumber@SecondColumn.
        vector_e(i) = abs(double(cell_v{4}(i)));
    end
end

end