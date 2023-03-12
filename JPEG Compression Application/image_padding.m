function paddedImageData = image_padding(picture)
%image_padding: Pads image so that it has correct dimensions for jpeg
%compression

%Image must be divisible by 8 in both horizonal and vertical dimensions for
%jpeg compression. If the image dimensions are not correct this function
%takes the last line of pixels for both the horizontal and vertical
%dimensions of the image and increases the image size by padding the image
%with them. the chrominance components of the image are halved in the
%horizontal during chrominance downsampling so must somtimes be padded
%twice to make sure it is still divisible by 8 after being halved. takes an
%rgb image and outputs the rgb image with extra rows and columns if
%required.

    %get vertical and horizontal dimensions of image
    numRows = size(picture, 1);
    numCols = size(picture, 2);
    
    %get last line of image in both vertical and horizontal dimensions
    lastRow = picture(end, :, :);
    lastCol = picture(:, end, :);
    
    %check if divisible by 8 in vertical dimension. If not, calculate how
    %many rows are required to make it divisible by 8
    if mod(numRows, 8) ~= 0
        reqRows = 8 - (mod(numRows, 8)); 
        picture(end+1:end+reqRows, :, :) = repmat(lastRow, reqRows, 1, 1); %pad bottom of image
        lastCol = picture(:, end, :);
    end
    
    %check if divisible by 8 in horizontal dimension. If not, calculate how
    %many rows are required to make it divisible by 8
    if mod(numCols, 8) ~= 0
        reqCols = 8 - (mod(numCols, 8));
        picture(:, end+1:end+reqCols, :) = repmat(lastCol, 1, reqCols, 1); %pad the right side of image
        lastCol = picture(:, end, :);
        numCols = size(picture, 2); %update number of columns since it is checked again
    end
    
    %2nd check to see if image is still divisible by 8 in the horizontal
    %after chrominance downsampling.
    if mod((numCols/2), 8) ~= 0
        picture(:, end+1:end+8, :) = repmat(lastCol, 1, 8, 1);
    end
    
    %save the padded image data which is then used during jpeg compression
    paddedImageData = picture;
end

