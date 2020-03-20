function dft = dft_matrix(matrix)
  [r,c] = size(matrix)
  dft = wcalc(r) * matrix * wcalc(c)  
end

function w = wcalc(n)
  x = linspace(0,n-1,n)
  [X,Y] = meshgrid(x,x)
  z = exp((-1*2*pi*i)/n)
  w= (1/n)*(z.^(X.*Y))
end
