function [decompressedImage] = decompress(cellArray, Quantization_matrix)
%decompress: performs the inverse steps of lossy compression and chrominance
%downsampling and recombines image to reverse the compression and form a new
%RGB image.

%Image quality is only affected during the lossy part of jpeg compression
%It is enough to decompress the image after lossy compression to see what 
%the final image will look like. This function reverses the steps of 
%lossy_compression.m. It breaks the compressed image into 8 by 8 blocks for
%all 3 image components.Reverses the quantization by multiplying each block
%by the quantization matrix set in Jpeg_compressor.m. Reverses the discrete
%cosine transform by using the function idct2 which is part of the image 
%processing toolbox for matlab. Reverses the chrominance downsampling by
%performing chrominance upsampling, and finally recombines the image 
%components into one 3 dimensional matrix and converts it back into an RGB
%image. The reverse process is not perfect and some visual information is
%lost due to the rounding which occurs during quantization of the 8 by 8
%blocks during compression which leads to artefacts on the image - image
%degredation. takes a cell array of 2 dimensinoal matrices and a
%quantization matrix and outputs the pixel data of a 3 dimensional rgb
%image.
    
    %create zero filled arrays
    yDecompressed = zeros(size(cellArray{1}));
    cbDecompressed = zeros(size(cellArray{2}));
    crDecompressed = zeros(size(cellArray{3}));
    
    %loop through each image component and reverse lossy compression steps
    count = 1;
    for Current_channel = cellArray
        for row = 1:8:size(Current_channel{:}, 1)
            for column = 1:8:size(Current_channel{:}, 2)
                block = Current_channel{:}(row:row+7, column:column+7);
                block = block .* Quantization_matrix; %reverse quantization
                block = idct2(block); %reverse discrete cosine transform
                block = block + 128;
                if count == 1
                    yDecompressed(row:row+7, column:column+7) = block ; %add decompressed block to respective array
                elseif count == 2
                    cbDecompressed(row:row+7, column:column+7) = block ; %add decompressed block to respective array
                else
                    crDecompressed(row:row+7, column:column+7) = block; %add decompressed block to respective array
                end
            end
        end
        count = count + 1; %increment count
    end
    
    %Upsample the chrominance components back to correct resolution
    %downsampling was performed at '4:4:4 to 4:2:2' resampling at '4:2:2 to
    %4:4:4' reverse the downsampling
%     upSample = vision.ChromaResampler('Resampling', '4:2:2 to 4:4:4'); 
%     [cbDecompressed, crDecompressed] = upSample(cbDecompressed, crDecompressed);
    decompressedImage(:,:,1) = yDecompressed;
    decompressedImage(:,:,2) = cbDecompressed;
    decompressedImage(:,:,3) = crDecompressed;
    
%     
%     %recombine image components into 3 dimensional matrix
%     decompressedImage = uint8(zeros(size(yDecompressed,1), size(yDecompressed,2), 3));
%     decompressedImage(:,:,1) = yDecompressed;
%     decompressedImage(:,:,2) = cbDecompressed;
%     decompressedImage(:,:,3) = crDecompressed;
    
    %convert YCbCr image back into an RGB image
    decompressedImage = ycbcr2rgb(decompressedImage);
    
end

