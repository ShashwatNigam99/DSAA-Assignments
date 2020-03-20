function final_image= RESIZENNLOOP(filename,scale)
    image = imread(filename, 'jpg');
    scale_factor = scale;
    x = size(image)
    final_image = zeros(x(1)*scale_factor,x(2)*scale_factor,3);
    final_size = size(final_image)
    for m = 1:3
      for i= 1:final_size(1)
        for j= 1:final_size(2)
           final_image(i,j,m) = image(ceil(i/scale_factor),ceil(j/scale_factor),m);
        end
      end
    end
    final_image = uint8(final_image);
    imshow(final_image);
    imwrite(final_image,'output.jpg');
end
