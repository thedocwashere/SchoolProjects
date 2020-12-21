function [circuit_cell] = getFileContent(file_name)
%This function reads the content of a file and returns these content as a
%cell array. It takes the file name as input. 

%Opening the file that is representing the circuit with reading permission
fid = fopen(file_name, "r");
    if fid == -1
        disp("The file couldn't be opened.");
    %Getting the file content as a cell array
    else 
        circuit_cell = textscan(fid,"%s %d %d %f");
        %Closing the file and checking if the file successfully closed
        close_result = fclose(fid);
        if close_result == 0
            disp("The file closed successfully.");
        else 
            disp("The file couldn't be closed.");
        end
    end
end