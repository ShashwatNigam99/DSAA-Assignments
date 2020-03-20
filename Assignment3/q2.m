clear
clc
img1 = imread('./images/q2_1.png')
img2 = imread('./images/q2_2.jpeg')
img2 = rgb2gray(img2)
img1 = imresize(img1,(256/225))
img2 = imresize(img2,(256/225))
fft_img1 = fft2(img1)
fft_img2 = fft2(img2)
fft_mult = fft_img1.*fft_img2
ifft_img_mult = ifft2(fft_mult)
conv_img = conv2(img1,img2)%511
conv_img_center = conv2(img1,img2,'same')

figure
subplot(1,2,1)
imshow(conv_img_center,[])
title('Center portion of f*h')
subplot(1,2,2)
imshow(ifft_img_mult,[])
title('iDFT of FH')

diff_matrix = ifft_img_mult - conv_img_center
sq_diff = diff_matrix.^2
avg_sq_diff = sum(sq_diff, 'all')/(256*256)

pad_img1 = padarray(img1,[255 255],0,'post')
pad_img2 = padarray(img2,[255 255],0,'post')
% pad_img1 = [pad_img1 zeros(510,1)]
% pad_img1 = [pad_img1; zeros(511,1)']
% pad_img2 = [pad_img2 zeros(510,1)]
% pad_img2 = [pad_img2; zeros(511,1)']

pad_fft_img1 = fft2(pad_img1)
pad_fft_img2 = fft2(pad_img2)

pad_fft_mult = pad_fft_img1.*pad_fft_img2
pad_ifft_img_mult = ifft2(pad_fft_mult)
figure
subplot(1,2,1)
imshow(conv_img,[])
title('convolution 511*511')
subplot(1,2,2)
imshow(pad_ifft_img_mult,[])
title('padded ifft 511*511')
diff_matrix = pad_ifft_img_mult - conv_img
sq_diff = diff_matrix.^2
pad_avg_sq_diff = sum(sq_diff, 'all')/(511*511)
