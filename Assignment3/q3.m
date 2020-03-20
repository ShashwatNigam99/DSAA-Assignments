clear;clc;

img = imread('./images/q2_1.png')
img_64 = imresize(img,(64/225))
img_128 = imresize(img,(128/225))
img_256 = imresize(img,(256/225))

pad_img64 = pad_image(img_64)
pad_img128 = pad_image(img_128)
pad_img256 = pad_image(img_256)

fft_og = log(abs(fft2(img_64)))
fft_pad_img64 = log(abs(fft2(pad_img64)))
fft_pad_img128 = log(abs(fft2(pad_img128)))
fft_pad_img256 = log(abs(fft2(pad_img256)))

figure

subplot(2,2,1)
imshow(fft_og,[])
title('64')

subplot(2,2,2)
imshow(fft_pad_img64,[])
title('128')

subplot(2,2,3)
imshow(fft_pad_img128,[])
title('256')

subplot(2,2,4)
imshow(fft_pad_img256,[])
title('512')



function padded = pad_image(img)
  padded = [img zeros(size(img,1))]
  padded = [padded;zeros(size(img,1),2*size(img,1))]
end
