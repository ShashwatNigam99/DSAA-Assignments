function final_image = RESIZEBLLOOP(filename,scale)
    og_image = imread(filename,'jpg');
    sz = size(og_image)
    final_sz = sz*scale
    final_sz(3) = 3

    final_image = zeros(final_sz(1),final_sz(2),final_sz(3));

    for p = 1:3
      for i = 1:sz(1)
        for j = 1:sz(2)
          final_image[1+(i-1)*scale,1+(j-1)*scale] = og_image(i,j)
        end
      end
    end

    for p = 1:3
      for i = 1:scale:sz(1)
        for j = 1:sz(2)
          if(mod((j-1),scale)~=0)
            b = (uint8(j/scale))*(scale-1) + 1;
            final_image(i,j) = ( final_image(i,b)*(b+scale-j) + final_image(i,b+scale)*(j-b) )/scale
        end
      end
    end

    for p = 1:3
      for i = 1:sz(1)
        for j = 1:scale:sz(2)
          if(mod((i-1),scale)~=0)
            b = (uint8(i/scale))*(scale-1) + 1;
            final_image(i,j) = ( final_image(b,j)*(b+scale-i) + final_image(b+scale,j)*(i-b) )/scale
        end
      end
    end

end
