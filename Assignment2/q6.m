og = imread('cameraman.tif')
% normalization factor taken accordinf to size of image
double_fft = uint8(abs(fft2(fft2(imread('cameraman.tif')))*(1/256)*(1/256)))
double_conj_fft = uint8(abs(fft2(conj(fft2(imread('cameraman.tif')))))*(1/256)*(1/256))

tf = isequal(double_conj_fft,og)
% shows 1 which means they are equal
