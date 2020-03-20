clear;
clc;
close all;
image_data = []

% Making all images as columns and putting it into a single matrix
for i = 0:7
  for j = 0:64
    if(j<10)
      file = ['./dataset/00',num2str(i),'_00',num2str(j),'.jpg'];
    else
      file = ['./dataset/00',num2str(i),'_0',num2str(j),'.jpg'];
    end
    x = reshape(imread(file),[256*256*3,1]);
    image_data = [image_data,x];
  end
end
%Subtracting the mean image from all image columns
mean_sub_image_data = bsxfun(@minus, double(image_data), mean(image_data,2));
% Calculate the eigenvectors of A'A and use it to calculate eigenvectors of AA'
cov_matrix = mean_sub_image_data' * mean_sub_image_data;
[V,eig_values] = eig(cov_matrix);
eig_vectors = mean_sub_image_data * V;
[sorted_eig_values,sorted_indices] = sort(diag(eig_values));
% already in sorted order given by eig function

% taking out 35, 100 and 500 most important eigenvectors acc to eigenvalues
pc_eig_vectors = eig_vectors(:,end-34:end);
% pc_eig_vectors_100 = eig_vectors(:,end-99:end);
% pc_eig_vectors_500 = eig_vectors(:,end-499:end);

figure

test = double(reshape(imread('./dataset/000_000.jpg'),[256*256*3,1]));
test = test-mean(image_data,2);
x = linsolve(pc_eig_vectors,double(test));
recons1 = reshape(pc_eig_vectors*x+mean(image_data,2),[256,256,3]);
subplot(2,4,1)
imshow(imread('./dataset/000_000.jpg'),[]);
subplot(2,4,5)
imshow(uint8(recons1),[]);

test = double(reshape(imread('./dataset/002_000.jpg'),[256*256*3,1]));
test = test-mean(image_data,2);
x = linsolve(pc_eig_vectors,double(test));
recons2 = reshape(pc_eig_vectors*x+mean(image_data,2),[256,256,3]);
subplot(2,4,2)
imshow(imread('./dataset/002_000.jpg'),[]);
subplot(2,4,6)
imshow(uint8(recons2),[])

test = double(reshape(imread('./dataset/005_000.jpg'),[256*256*3,1]));
test = test-mean(image_data,2);
x = linsolve(pc_eig_vectors,double(test));
recons3 = reshape(pc_eig_vectors*x+mean(image_data,2),[256,256,3]);
subplot(2,4,3)
imshow(imread('./dataset/005_000.jpg'),[]);
subplot(2,4,7)
imshow(uint8(recons3),[])

test = double(reshape(imread('./dataset/007_000.jpg'),[256*256*3,1]));
test = test-mean(image_data,2);
x = linsolve(pc_eig_vectors,double(test));
recons4 = reshape(pc_eig_vectors*x+mean(image_data,2),[256,256,3]);
subplot(2,4,4)
imshow(imread('./dataset/007_000.jpg'),[]);
subplot(2,4,8)
imshow(uint8(recons4),[])

% %this is for 100 and 500 eigenvectors

% x_500 = linsolve(pc_eig_vectors_500,double(test));
% recons_500 = reshape(pc_eig_vectors_500*x_500+mean(image_data,2),[256,256,3]);
% figure
% imshow(uint8(recons_500),[])
%
% x_100 = linsolve(pc_eig_vectors_100,double(test));
% recons_100 = reshape(pc_eig_vectors_100*x_100+mean(image_data,2),[256,256,3]);
% figure
% imshow(uint8(recons_100),[])

% projecting all image data on three principal components
pc1 = eig_vectors(:,end);
pc2 = eig_vectors(:,end-1);
pc3 = eig_vectors(:,end-2);
proj_pc1 = mean_sub_image_data'*pc1;
proj_pc2 = mean_sub_image_data'*pc2;
proj_pc3 = mean_sub_image_data'*pc3;

figure
scatter(proj_pc1,zeros(520,1));

figure
scatter(proj_pc1,proj_pc2);

figure
scatter3(proj_pc1,proj_pc2,proj_pc3);
