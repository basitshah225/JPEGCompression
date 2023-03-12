function compare_size(originalImage, compressedImage)
%compare_size: produce a bar graph and a number comparing image size before
%and after compression

%depending on the quantization matrix used for compression it can be very
%hard to notice any differences between the original and compressed image.
%This function displays simple visual and numerical information on the
%screen to show compression levels even if the visual difference between
%the images is almost imperceptible. It calculates the number of elements
%in binary form for the original and fully compressed image and then
%compares the two numbers. At first the huffman encoded vectors may seem
%larger than the pre huffman encoded vectors in size. But the huffman encoded
%vectors are actually encoded using fewer bits than the pre encoded
%vectors. This is why it is necessary to convert the images to binary from
%to get the true size of the images. This functino takes two images as
%inputs.

    %convert original image to binary form and then get number of elements
    %to determine size
    originalSize = dec2bin(originalImage);
    originalSize = numel(originalSize);
    
    %convert each individual huffman encoded image component to binary 
    compressedY = dec2bin(compressedImage{1});
    compressedCb = dec2bin(compressedImage{2});
    compressedCr = dec2bin(compressedImage{3});
    
    %get number of elements in each image component after compression
    compressedY = numel(compressedY);
    compressedCb = numel(compressedCb);
    compressedCr = numel(compressedCr);
    
    %get total number of elements in image after compression
    compressedSize = compressedY + compressedCb + compressedCr;
    
    %draw bar graph of image against size
    figure;
    x = categorical({'original', 'compressed'});
    x = reordercats(x, {'original', 'compressed'});
    y = [ originalSize compressedSize];
    bar(x, y);
    title('Size Difference Between Images');
    xlabel('Image');
    ylabel('Size in binary');
    
    %calculate level of compression
    compression = round(originalSize / compressedSize, 1);
    compression = mat2str(compression);
    
    %display a message box to the user informing them of the compression
    %level of the image.
    string = ['compressed image is ', compression, 'x smaller than original image.'];
    f = msgbox(string);
    
end

