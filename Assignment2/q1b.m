function median_filtered_image = median_filter(I,N)
  og_image = imread(I);
  [r,c] = size(og_image)
  % padded_image = padarray(og_image,[floor(N/2) floor(N/2)],'replicate','both');
  padded_image = padarray(og_image,[floor(N/2) floor(N/2)],0,'both');
  columnized = im2col(padded_image,[N N])
  med = median(columnized)
  median_filtered_image = reshape(med,[r c])
end
