function [matrix_A,vector_z] = generateMatrices(cell_v, cell_i, cell_r,num_node)
%generateMatrices function generate the A matrix and z vector which are
%taken from MNA Algorithm. Function takes voltage,resistor and current
%cell arrays and number of nodes as inputs and returns the matrix_A and vector_z.

%Calculating the number of voltage sources by measuring the size of
%voltage cell array by looking its second dimension because the first cell
%is a row vector, if it isn't empty. If it is empty it means that circuit 
%has no voltage source and therefore num_voltage is 0.
if isempty(cell_v)
    num_voltage = 0;
else
    [~,num_voltage] = size(cell_v{1});
end

%Generating the G matrix from MNA Algorithm by a function.
matrix_G = generateMatrixG(cell_r,num_node);

%Generating the B matrix from MNA Algorithm by a function.
matrix_B = generateMatrixB(cell_v,num_node,num_voltage);

%Generating the C matrix from MNA Algorithm which is only transpose of
%matrix_B.
matrix_C = transpose(matrix_B);

%Generating the D matrix from MNA Algorithm which is a
%(num_voltage x num_voltage) zero matrix.
matrix_D = zeros(num_voltage);

%Combining the 4 matrices which were generated above.
matrix_A = [matrix_G, matrix_B ; matrix_C , matrix_D];


%Generating the I vector from MNA Algorithm by a function.
vector_i = generateVectorI(cell_i,num_node);

%Generating the E vector from MNA Algorithm by a function.
vector_e = generateVectorE(cell_v,num_voltage);

%Combining the 2 vectors which were generated above.
vector_z = [vector_i ; vector_e];

end