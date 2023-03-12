function [imageData] = load_image()
%load_image: opens the file explorer and prompts user to select an image
%file and read the image

%calls the built in matlab function imgetfile which opens file explorer
%so user can select an image file of various types. Saves path, filename
%and extension as a character array in variable called filename.
%It then calls another built in matlab function imread which reads the data
%of the image returns the image data.
    
    %supported file types
    compatibleFiles = [".bmp" ".jpeg" ".jpg" ".png" ".jfif" ".jp2" ".pcx" ".pnm" ".ppm" ".ras" ".tiff" ".tif"];
    
    %select image file
    [filename, noFileChosen] = imgetfile;
    
    %determine file name and type
    [~, ~, extension] = fileparts(filename);
    fileType = convertCharsToStrings(extension);
    
    %determine if user selected file is compatible
    isCompatible = ismember(fileType, compatibleFiles);
    
    if noFileChosen == true
        error('You did not choose a file')
    elseif isCompatible == false
        error('Current file type is not supported only jpg/jpeg, jfif, jp2, tiff/tif, png, bmp, pnm, ppm, pcx and ras are supported');
    else
        %save image data
        imageData = imread(filename);
    end
    
end