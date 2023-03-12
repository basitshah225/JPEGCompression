function display_images(originalImage, compressedImage)
%display_images: displays the original image and the compressed image after
%decompression.

%This function trims the decopmressed image to the same size as the
%dimensions of the original image and then displays the  :
%original image and compressed image in seperate figure windows.
%original image and compressed image in the same figure window

    %get rows and columns of original and compressed image
    rowOriginal = size(originalImage, 1);
    colOriginal = size(originalImage, 2);
    rowNew = size(compressedImage, 1);
    colNew = size(compressedImage, 2);
    
    %if compressedImage has been padded then trim the padded rows
    if (rowOriginal ~= rowNew) 
        compressedImage(rowOriginal:end, :, :) = [];
    end
    
    %if compressed image has been padded trim padded columns
    if (colOriginal ~= colNew)
        compressedImage(:, colOriginal:end, :) = [];
    end
    
    %display both images seperately and together for comparison
    figure, imshow(originalImage), title('original image');
    figure, imshow(compressedImage), title('compressed image');
    figure, subplot(1,2,1), imshow(originalImage), title('original image');
            subplot(1,2,2), imshow(compressedImage), title('compressed image');

end

