function [node_voltage] = CircuitAnalysis(file_name)
%CircuitAnalysis function calculates the node voltage values of given
%circuit. It takes the file name which contains the netlist of the circuit
%and returns the node_voltage matrix.


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

%Calling the generateMatrices function and assign its returning values to
%matrix_A and vector_z.
[matrix_A,vector_z] = generateMatrices(cell_v, cell_i, cell_r,num_node);

%Solving the equation Ax=z from MNA Algorithm. A\z is used instead of
%inv(A)*z. Because MATLAB suggested this operation a lot. 
solution = (matrix_A)\vector_z;

%Preallocating the node voltage matrix.
node_voltage = zeros(num_node,1);

%Taking the first part of solution which has node voltages in it.
for n= 1:num_node
    node_voltage(n) = solution(n);
end

end