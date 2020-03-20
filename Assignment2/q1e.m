og  = imread('inp2.png')
length = size(og,1)
fft_shifted = fftshift(fft2(og))
window_size = 35
fft_shifted_p1 = fft_shifted(1:(length/2-window_size),:)
fft_shifted_p2 = fft_shifted((length/2-window_size)+1:(length/2+window_size)-1,:)
fft_shifted_p3 = fft_shifted((length/2+window_size:end),:)

fft_shifted_p3 = fft_shifted_p3.*(abs(fft_shifted_p3)<30000)
fft_shifted_p1 = fft_shifted_p1.*(abs(fft_shifted_p1)<30000)
% fft_shifted_p3 = fft_shifted_p3.*0
% fft_shifted_p1 = fft_shifted_p1.*0

final = cat(1,fft_shifted_p1,fft_shifted_p2,fft_shifted_p3)

final_img = uint8(abs(ifft2(fftshift(final))))
