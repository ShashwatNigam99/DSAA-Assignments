A=imread('bird.jpg');
sz = size(A);
scale_factor = 2;
final_sz = sz*scale_factor;

IR = ceil([1:final_sz(1)]./(scale_factor));
IC = ceil([1:final_sz(2)]./(scale_factor));

Temp1= A(:,:,1);
Temp2= A(:,:,2);
Temp3= A(:,:,3);

Red = Temp1(IR,:);
Red = Red(:,IC);
Green = Temp2(IR,:);
Green = Green(:,IC);
Blue = Temp3(IR,:);
Blue = Blue(:,IC);

Output=zeros([Row,Col,3]);
Output(:,:,1)=Red;
Output(:,:,2)=Green;
Output(:,:,3)=Blue;

Output = uint8(Output);

imshow(Output);
