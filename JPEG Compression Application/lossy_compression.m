function [transformedChannels] = lossy_compression(cellArray, quantizationMatrix)
%lossy_compression: performs a few steps which leads to lossy compression
%of the image as original image data can not be recreated exactly during
%decompression

%Breaks each component of a YCbCr image up into 8 by 8 blocks which are
%then processed to achieve lossy compression. each 8 by 8 block is
%processed using the 2d discrete cosine transform function dct2, which is
%part of the image processing toolbox for matlab, and then each transformed
%block is quantized using the quantization matrix set in Jpeg_compressor.m
%takes a cell array of 2 dimensional matrices and a quantization matrix and
%outputs a cell array of 2 dimensional matrices.
    
    %create 0 filled arrays of the same size as their corresponding image
    %components
    yTransformed = zeros(size(cellArray{1}));
    cbTransformed = zeros(size(cellArray{2}));
    crTransformed = zeros(size(cellArray{3}));

    %count determines which zero filled array created above will be altered
    %during the loops
    count = 1;
    
    %loop through each column and row for each of the 3 image components
    %forming 8 by 8 blocks and processing.
    for Current_channel = cellArray
        for Row = 1:8:size(Current_channel{:}, 1)
            for Column = 1:8:size(Current_channel{:}, 2)
                block = Current_channel{:}(Row:Row+7, Column:Column+7); %create 8 by 8 block
                block = block - 128;
                block = dct2(block); %2d discrete cosine transform block
                block = round(block ./ quantizationMatrix); %quantize block
                if count == 1
                    yTransformed(Row:Row+7, Column:Column+7) = block ; %add block to array
                elseif count == 2
                    cbTransformed(Row:Row+7, Column:Column+7) = block ; %add block to array
                else
                    crTransformed(Row:Row+7, Column:Column+7) = block; %add block to array
                end
            end
        end
        count = count + 1; %increment count
    end
    
    %cell array of processed image components
    transformedChannels = {yTransformed, cbTransformed, crTransformed};

end

