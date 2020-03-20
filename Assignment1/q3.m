face = rgb2gray(imread('F1.jpg'));
sz = size(face);
faces = rgb2gray(imread('Faces.jpg'));
c = normxcorr2(face, faces);
[ypeak, xpeak] = find(c==max(c(:)));

y = ypeak-size(face,1)+1;
x = xpeak-size(face,2)+1;

imshow(faces);
imrect(gca, [x, y, sz(2), sz(1)]);
