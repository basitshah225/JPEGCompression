%This is the main file for the Jpeg compressor. To use the compressor
%simply click the green arrow labelled run on the top of the application
%and select an image file. To change the quality of the compression scroll
%down to the "user editable section". Changing anything outside of the
%"user editable section" will result in the program not working unless you
%understand and know how to code. the user editable section is here if you
%want to use the compressor without the graphical user interface.

%user editable section-----------------------------------------------------

%Below is the quantization matrix used in compression. all the values in
%the matrix can be changed to either increase or decrease the quality of
%compression. changing a value to 0 will result in an error and the program
%will not work. Deleting a value and not replacing it with another will
%also result in an error and the program not working.

%Jpeg standard quantization matrix
quantizationMatrix = [16 11 10 16 24 40 51 61
                      12 12 14 19 26 58 60 55
                      14 13 16 24 40 57 69 56
                      14 17 22 29 51 87 80 62
                      18 22 37 56 68 109 103 77
                      24 35 55 64 81 104 113 92
                      49 64 78 87 103 121 120 101
                      72 92 95 98 112 100 103 99];
 
                    


%end of user editable section----------------------------------------------                  
%changing anything below here will result in the program not working.

%select image which you want compressed using file explorer
imageData = load_image();

%ready image for compression
channels = preprocessing(imageData);

%performs lossy part of jpeg compression on image
compressedImage = lossy_compression(channels, quantizationMatrix);

% %zigzag scans compressed image components
% scannedVectors = zigzag_scan(compressedImage);
% 
% %run length encodes zigzag scanned vectors
% rleVectors = run_length_encoding(scannedVectors);
% 
% %huffman encodes the image components to complete the compression process
% finalImage = huffman_encode(rleVectors);

%decompresses image after lossy compression
newImage = decompress(compressedImage, quantizationMatrix);

%displays original image, new image and both images side to side for
%comparison
display_images(imageData, newImage);

%outputs bar graph comparing size of the original image and final image and
%details compression in command window
% compare_size(imageData, finalImage);




        
        
        
        
        