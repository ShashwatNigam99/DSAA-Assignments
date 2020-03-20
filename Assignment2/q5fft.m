answer = matrix_fft([1 2 3 4; 5 6 7 8; 9 10 11 12; 13 14 15 16])

function matrix = matrix_fft(mat)
  for i = 1:size(mat,2)
    mat(:,i) = rec_fft(mat(:,i));
  end
  for i = 1:size(mat,1)
    p = rec_fft(mat(i,:)');
    mat(i,:) = p';
  end
   matrix = mat;
end

function y = rec_fft(x)
  n = size(x,1);
  if n==1
    y=x;
    return;
  end
  z = exp((2*pi*i)/n);
  zz=1;
  y = zeros(n,1);
  even = x(1:2:end);
  odd = x(2:2:end);
  yeven = rec_fft(even);
  yodd = rec_fft(odd);

  for k=0:(floor(n/2)-1)
    y(k+1) = yeven(k+1) +zz*yodd(k+1);
    y(k+floor(n/2)+1) = yeven(k+1)-zz*yodd(k+1);
    zz = zz*z;
  end
end
