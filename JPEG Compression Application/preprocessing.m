function [channels] = preprocessing(picture)
%preprocessing: takes image data and prepares it for jpeg compression.

%image is padded to correct size for jpeg compression and is then split
%into its luminance and chrominance components. The chrominance components
%are then downsampled using vision.ChromaResampler object which is part of
%the computer vision toolbox for matlab. Finally the seperate image
%components are stored in a cell array for futher compression. Takes a 3
%dimensional matrix as input and outputs a cell array of 2 dimensional
%matrices
    
    %pads image to correct size
    picture = image_padding(picture);
    
    %converts from rgb colourspace to YCbCr (luminance and chrominance
    %components
%     picture = rgb2ycbcr(picture);
    r = picture(:,:,1);
    g = picture(:,:,2);
    b = picture(:,:,3);

    y = round(0.299 * r + 0.587 * g + 0.114 * b);
    cb = round(-0.1687 * r - 0.3313 * g + 0.5 * b + 128);
    cr = round(0.5 * r - 0.4187 * g - 0.0813 * b + 128);
    %stores each component in it's own array
%     y = picture(:,:,1);
%     cb = picture(:,:,2);
%     cr = picture(:,:,3);
    
    %downsamples chrominance components
%     downSampler = vision.ChromaResampler; %format = '4:4:4 to 4:2:2'
%     [cb, cr] = downSampler(cb, cr);
    
    %stores components in cell array
    channels = {y, cb, cr};
    
end

