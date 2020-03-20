clear;
clc;
close all;

img = imread('./images/cameraman.jpg');

img = rgb2gray(img);
img_dbl = imresize(img,2);
img_tpl = imresize(img,3);


img3 = padarray(img, [3, 3],0, 'both');
img_dbl3 = padarray(img_dbl,[3 3],0,'both');
img_tpl3 = padarray(img_tpl,[3 3],0,'both');

img5 = padarray(img, [5, 5],0, 'both');
img_dbl5 = padarray(img_dbl,[5 5],0,'both');
img_tpl5 = padarray(img_tpl,[5 5],0,'both');

times_normal = zeros(1,3);
times_eff = zeros(1,3);

tic
normal3 = simple_func(7, img3);
times_normal(1) = toc;
tic
normal3 = simple_func(7, img_dbl3);
times_normal(2) = toc;
tic
normal3 = simple_func(7, img_tpl3);
times_normal(3) = toc;

tic
eff3 = efficient_func(7, img3);
times_eff(1) = toc;
tic
eff3 = efficient_func(7, img_dbl3);
times_eff(2) = toc;
tic
eff3 = efficient_func(7, img_tpl3);
times_eff(3) = toc;

figure
plot(times_normal,'--o');
hold on;
plot(times_eff,'--+');

times_normal = zeros(1,3);
times_eff = zeros(1,3);

tic
normal5 = simple_func(11, img5);
times_normal(1) = toc;
tic
normal5 = simple_func(11, img_dbl5);
times_normal(2) = toc;
tic
normal5 = simple_func(11, img_tpl5);
times_normal(3) = toc;

tic
eff5 = efficient_func(11, img5);
times_eff(1) = toc;
tic
eff5 = efficient_func(11, img_dbl5);
times_eff(2) = toc;
tic
eff5 = efficient_func(11, img_tpl5);
times_eff(3) = toc;

hold on;
plot(times_normal,'--p');
hold on;
plot(times_eff,'--g');
% normal7 = simple_func(7, img3);
% efficient7 = efficient_func(7, img3);

function final_img = simple_func(k, img)
    final_img = img;
    offset = floor(k/2);
    sz = size(img,1)-offset*2;
    iter =  1 + offset:sz + offset;
    mat = ones(k, k) / (k*k);

    for i = iter
        for j = iter
            final_img(i, j) = sum(double (img(i - offset:i + offset, j - offset:j + offset)) .* mat, 'all');
        end
    end
    % imshow(final_img);
end

function img = efficient_func(k, img)
    offset = floor(k/2);
    sz = size(img,1)-2*offset;
    iter =  1 + offset:sz + offset;
    mat = ones(k, k) / (k*k);
    mat_eff = ones(k, 1) / (k*k);
    for i = iter
        img(i, 1 + offset) = sum(double(img(i - offset:i + offset,1:k )) .* mat, 'all');
    end
    for i = iter
        for j = 2 + offset:sz + offset
            img(i, j) = img(i, j - 1) - sum(double(img(i - offset:i + offset, j - 1  - offset)) .* mat_eff, 'all') + sum(double(img(i - offset:i + offset, j + offset)) .* mat_eff, 'all');
        end
    end
end
