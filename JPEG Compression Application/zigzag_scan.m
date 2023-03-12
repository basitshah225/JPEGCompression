function [vectorCellArray] = zigzag_scan(cellArray)
%zigzag_scan: rearrange 8 by 8 blocks into a 1 by 64 vecor based the jpeg
%standard zigzag scan model

% e.g if a = [1 2 3     zigzag scan of a = [1 2 4 7 5 3 6 8 9]
%             4 5 6
%             7 8 9]
%rearranging the image component matrices like this allows all non-zero
%elements to be encountered as fast as possible which allows for better
%compression in the next step (run length encoding). This function takes a
%cell array of 3, 2 dimensional matrices and zigzag scans each matrix and
%outputs a cell array containing 3 vectors(a matrix with only one
%dimension).
             

    %this counter is used to add the zigzag scanned vectors to their
    %respective image component
    counter = 1;
    
    %create zero filled vectors which are the length of all the elements in
    %their respective image components
    yVector = zeros(1, numel(cellArray{1}));
    cbVector = zeros(1, numel(cellArray{2}));
    crVector = zeros(1, numel(cellArray{3}));
    
    %create cell array to store the 3 vectors
    vectorCellArray = {yVector, cbVector, crVector};
    
    %this count determines which image component is being scanned and which
    %vector is being added to. Code inside for loop is used to take an 8 by
    %8 block and output a zigzaz scanned 1 by 64 vector.
    for count = 1:3
        for row = 1:8:size(cellArray{count}, 1)
            for column = 1:8:size(cellArray{count}, 2)
                block = cellArray{count}(row:row+7, column:column+7); %get 8 by 8 block
                ind = reshape(1:numel(block), size(block)); %create array of same size as block
                ind = fliplr(ind); %flip array left to right
                ind = spdiags(ind); %get nonzero diagonals and create sparse band and diagonal matrices
                ind = fliplr(ind); %flip array left to right
                ind(:,1:2:end) = flipud(ind(:,1:2:end)); %flip certain rows in array up to down
                ind(ind==0) = []; %remove any zeros and complete zigzag scan of block
                vectorCellArray{count}(1, counter:counter+63) = block(ind); %add zigzag scanned vector to respective vector array
                counter = counter + 64; %increment counter by 64 for next zigzag scanned block
            end
        end
        counter = 1; %reset counter to 1 for next image component
    end
    
end

