 function [finalCompressedImage] = huffman_encode(cellArray)
%huffman_encode: huffman encodes the 3 seperated image components

%Final step in the lossless encoding part of jpeg compression. Huffman
%encoding further compresses an image by encoding data using symbols. The
%symbols are stored in a dictionary which is created using the
%probabilities of certain elements appearing in the input stream. element
%which have a higher probability of appearing are encoded using symbols
%which use up the least amount of space, where as elements which are very
%infrequent are coded using remaining symbols which take up more space. The
%symbols themselves also use up less space than the original data. This
%function takes the run length encoded vectors as an input and outputs the
%huffman encoded vectors using the function huffmanenco which is part of
%the communications toolbox for matlab.
    
    %create empty arrays for each image component
    yEncoded = [];
    cbEncoded = [];
    crEncoded = [];
    
    %create cell array which will store the encoded vectors
    finalCompressedImage = {yEncoded, cbEncoded, crEncoded};
    
    %count determines which image component is being encoded
    for count = 1:3
        symbols = unique(cellArray{count}); %generate symbols based on how many unique elements there are
        counts = hist(cellArray{count}, symbols); %returns vector of number of times each unique element occurs
        frequency = counts ./ sum(counts); %determines the frequency of each unique element occuring in the vector
        dictionary = huffmandict(symbols, frequency); %generates a dictionary based on unique elements and their frequency
        encoded = huffmanenco(cellArray{count}, dictionary); %huffman encodes vector using the created dictionary
        finalCompressedImage{count} = encoded; %adds encoded vector to respective image component in cell array
    end

end

