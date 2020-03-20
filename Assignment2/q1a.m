function gaussian_filter = gauss_filter(N,sigma)
   gauss = @(x) exp((-1*x^2)/(2*sigma^2));
   x = arrayfun(gauss,[-1*floor(N/2): floor(N/2)])
   [X,Y] = meshgrid(x,x)
   A =  (X.*Y)/(2*pi*sigma^2);
   gaussian_filter = A/sum(A,'all');
end
