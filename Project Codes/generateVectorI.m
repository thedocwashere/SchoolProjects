function [vector_i] = generateVectorI(cell_i,num_node)
%generateVectorI function generates the I vector from MNA Algorithm. It
%takes number of nodes and current cell as inputs and returns the I vector.

%Preallocating the I vector.
vector_i = zeros(num_node,1);

%Checking for if the circuit has any current sources.If not the function 
%returns zero vector.
if ~isempty(cell_i)
    %Calculating the number of current sources by measuring the size of
    %current cell array by looking at its second dimension.
    [~,num_curr] = size(cell_i{1});
    
    for i = 1:num_curr
        %Determining the node numbers and types of these nodes which the
        %current source connected.
        current_exit_node = cell_i{2}(i); 
        current_enter_node = cell_i{3}(i); 
        
        %Calculating the total values of entering currents to the
        %particular node.
        vector_i(current_enter_node) = vector_i(current_enter_node) + double(cell_i{4}(i));
        
        %Checking if the current source grounded or not.
        if current_exit_node ~= 0
        %Calculating the total values of exiting currents from the
        %particular node.
        vector_i(current_exit_node) = vector_i(current_exit_node) - double(cell_i{4}(i));
        end
    end
end

end