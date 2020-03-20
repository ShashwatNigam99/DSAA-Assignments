clc;
clear;
close all;
q_mtx =     [16 11 10 16 24 40 51 61;
            12 12 14 19 26 58 60 55;
            14 13 16 24 40 57 69 56;
            14 17 22 29 51 87 80 62;
            18 22 37 56 68 109 103 77;
            24 35 55 64 81 104 113 92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103 99];

img = double(imread('LAKE.TIF'));

s1 = img(420:427,45:52);
s2 = img(427:434,298:305);
s3 = img(30:37,230:237);

dct_mat_basis = create_mat_dct(8);

dct_img1 = myDCT(s1,dct_mat_basis);
dct_img2 = myDCT(s2,dct_mat_basis);
dct_img3 = myDCT(s3,dct_mat_basis);

qdct_img1 = myDCT_quantization(dct_img1,q_mtx,2);
qdct_img2 = myDCT_quantization(dct_img2,q_mtx,2);
qdct_img3 = myDCT_quantization(dct_img3,q_mtx,2);

dqdct_img1 = myDCT_dequantization(qdct_img1,q_mtx,2);
dqdct_img2 = myDCT_dequantization(qdct_img2,q_mtx,2);
dqdct_img3 = myDCT_dequantization(qdct_img3,q_mtx,2);

rec1 = myIDCT(dqdct_img1,dct_mat_basis);
rec2 = myIDCT(dqdct_img2,dct_mat_basis);
rec3 = myIDCT(dqdct_img3,dct_mat_basis);

figure
subplot(3,4,1);
imshow(uint8(s1));
title("Original image 420,45");
subplot(3,4,2);
imshow(dct_img1,[]);
title("dct image 420,45");
subplot(3,4,3);
imshow(qdct_img1,[]);
title("quantized dct image 420,45");
subplot(3,4,4);
imshow(uint8(rec1));
title("Reconstructed image 420,45");

subplot(3,4,5);
imshow(uint8(s2));
title("Original image 427,298");
subplot(3,4,6);
imshow(dct_img2,[]);
title("dct image 427,298");
subplot(3,4,7);
imshow(qdct_img2,[]);
title("quantized dct image 427,298");
subplot(3,4,8);
imshow(uint8(rec2));
title("Reconstructed image 427,298");

subplot(3,4,9);
imshow(uint8(s3));
title("Original image 30,230");
subplot(3,4,10);
imshow(dct_img3,[]);
title("dct image 30,230");
subplot(3,4,11);
imshow(qdct_img3,[]);
title("quantized dct image 30,230");
subplot(3,4,12);
imshow(uint8(rec3));
title("Reconstructed image 30,230");



func2 = @(block) myDCT_quantization(myDCT(block.data,dct_mat_basis),q_mtx,2);
func5 = @(block) myDCT_quantization(myDCT(block.data,dct_mat_basis),q_mtx,5);
func10 = @(block) myDCT_quantization(myDCT(block.data,dct_mat_basis),q_mtx,10);
dct_img2 = blockproc(img,[8 8],func2);
dct_img5 = blockproc(img,[8 8],func5);
dct_img10 = blockproc(img,[8 8],func10);
figure
subplot(1,3,1)
imshow(dct_img2,[])
subplot(1,3,2)
imshow(dct_img5,[])
subplot(1,3,3)
imshow(dct_img10,[])

ifunc2 = @(block) myIDCT(myDCT_dequantization(block.data,q_mtx,2),dct_mat_basis);
ifunc5 = @(block) myIDCT(myDCT_dequantization(block.data,q_mtx,5),dct_mat_basis);
ifunc10 = @(block) myIDCT(myDCT_dequantization(block.data,q_mtx,10),dct_mat_basis);
rec_img2 = blockproc(dct_img2,[8 8],ifunc2);
rec_img5 = blockproc(dct_img5,[8 8],ifunc5);
rec_img10 = blockproc(dct_img10,[8 8],ifunc10);
figure
subplot(1,3,1);
imshow(rec_img2,[]);
subplot(1,3,2);
imshow(rec_img5,[]);
subplot(1,3,3);
imshow(rec_img10,[]);

ent2 = my_entropy(rec_img2);
ent5 = my_entropy(rec_img5);
ent10 = my_entropy(rec_img10);

rmse2 = RMSE(rec_img2,img);
rmse5 = RMSE(rec_img5,img);
rmse10 = RMSE(rec_img10,img);


function ent = my_entropy(im)
  p = imhist(uint8(im));
  [r,c] = size(im);
  p = p./(r*c);
%  p = p/sum(p);
  p(p==0) = 1;
  ent = -1*sum(p.*log2(p));
end

function rmse_err = RMSE3(im1,im2)
   n = size(im1,1)*size(im2,2)*size(im3,3);
   rmse_err = sqrt( sum(((im1-im2).^2), 'all')/n);
end

function rmse_err = RMSE(im1,im2)
   rmse_err= sqrt(mean2((im1-im2).^2));
end

function imDCT = myDCT_dequantization(imqDCT,qm,c)
   imDCT = imqDCT.*(qm*c);
end

function imqDCT = myDCT_quantization(imDCT,qm,c)
   imqDCT = round(imDCT./(qm*c));
end

function idct_img = myIDCT(im,F)
  idct_img = F'*im*F;
end

function dct_img = myDCT(im,F)
  dct_img = (F*im)*F';
end

function dct_mat_basis = create_mat_dct(n)
  [u,v] = meshgrid(0:(n-1),0:(n-1));
  dct_mat_basis =   sqrt(2/n)*cos((pi/(2*n))*((2*u+1).*v));
  dct_mat_basis = [dct_mat_basis(1,:)*sqrt(0.5);dct_mat_basis(2:8,:)];
end
