function [voltage_cell,current_cell,resistor_cell] = createElementCells(circuit_cell)
%createElementCells function takes a cell array as an input which contains
%information about circuit elements and it divides these elements into
%3 classes (voltage, current, and resistor) and creates three cell arrays,these arrays
%store information about these three classes. The function returs these three cell arrays.

%Creating 3 new cell arrays for each class. Afterwards the code will fill
%the cells. But by creating empty cell arrays first, the program functions
%properly even if there aren't any voltage sources etc.
voltage_cell={};
current_cell={};
resistor_cell={};

%Measures the size of circuit cell i.e learn how many elements does this
%circuit has by looking at the first dimension of first cell.
[num,~] = size(circuit_cell{1});

%Initializing the number of elements, v corresponds to independent voltage source,
%c to independent current source, r to resistor.
v=0;c=0;r=0;

%The first column in the circuit cell specifies the type of element with a letter V,I or R. 
%This code block checks every element and with the help of this initial
%letters it divides them into three classes.
for i = 1:num
    
    if startsWith(circuit_cell{1}(i),"V")
       %Incrementing the number of voltage source
       v = v+1;
       %Passing information to voltage cell for voltage sources.
       for j = 1:4
       voltage_cell{j}(v)= circuit_cell{j}(i);
       end
       
    elseif startsWith(circuit_cell{1}(i),"I")
       %Incrementing the number of current source
       c = c+1;
       %Passing information to current cell for current sources.
       for j = 1:4
       current_cell{j}(c)= circuit_cell{j}(i);
       end
       
    elseif startsWith(circuit_cell{1}(i),"R")
       %Incrementing the number of resistors.
       r=r+1; 
       %Passing information to resistor cell for resistors.
       for j = 1:4
       resistor_cell{j}(r)= circuit_cell{j}(i);
       end
    end
end