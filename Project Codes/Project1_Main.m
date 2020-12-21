%Taking the file name as a string from user.
file_name = input("Please enter the file name of the file with its file extension (.txt, etc.) which represents the circuit: ","s");

%Calling the CircuitAnalysis function which calculates the node voltages.
%Assigning its return value to result matrix.
[result] = CircuitAnalysis(file_name);

%Printing the node voltage values in order.
for i = 1:length(result)  
fprintf("Node voltage of node %d is %.2f Volt. \n", i,result(i))
end
