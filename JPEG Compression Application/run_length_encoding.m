function [rleVectors] = run_length_encoding(cellArray)
%run_length_encoding: run length encode a vector

%another step for lossless encoding in the jpeg standard. Further
%compresses image by storing data in the form of number of times element
%appears followed by the element.
%e.g.                a = [ 1 1 1 1 1 2 3 3 3 3 5 5 5 ]
%run_length_encoding(a)= [ 5 1 1 2 4 3 3 5]
%1 appears 5 times to first 2 elements in run_length_encoding(a) are 5 and
%1. Vector has been compressed from size 1 by 13 to size 1 by 8. zigzag
%scanning beforehand improves the compression of run length encoding by
%maximising how many 0's appear one after another. This function takes a
%cell array of vectors and outputs a cell array of the run length encoded
%version of those vectors.
    
    %get vector to be encoded
    yVector = cellArray{1};
    yRle = [];
    count = 1;
    
    %loop to iterate through all elements of vector
    for i = 1:length(yVector) - 1
        if (yVector(i) == yVector(i+1)) %check if element is the same as previous
            count = count + 1; %increase count if yes
        else
            yRle = [yRle, count, yVector(i),]; %add to yRle whatever count is and current element
            count = 1; %reset count for every element which isn't the same as previous.
        end
    end
    yRle = [yRle, count, yVector(length(yVector))]; %final run length encoded vector
    
    %same process for run length encoding as above for Cb image component
    cbVector = cellArray{2};
    cbRle = [];
    count2 = 1;
    for i = 1:length(cbVector) - 1
        if (cbVector(i) == cbVector(i+1))
            count2 = count2 + 1;
        else
            cbRle = [cbRle, count2, cbVector(i),];
            count2 = 1;
        end
    end
    cbRle = [cbRle, count2, cbVector(length(cbVector))];
    
    %same process for run length encoding as above for Cr image component
    crVector = cellArray{3};
    crRle = [];
    count3 = 1;
    for i = 1:length(crVector) - 1
        if (crVector(i) == crVector(i+1))
            count3 = count3 + 1;
        else
            crRle = [crRle, count3, crVector(i),];
            count3 = 1;
        end
    end
    crRle = [crRle, count3, crVector(length(crVector))];
    
    %store all run length encoded vectors in a cell array
    rleVectors = {yRle, cbRle, crRle};
        
end
