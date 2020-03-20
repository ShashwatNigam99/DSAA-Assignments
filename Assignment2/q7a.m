function spectro = return_spectro(signal_file,window_size,stride)
   [signal,fs] = audioread(signal_file)
   len = size(signal,1)
   starters = 1:stride:len-window_size % getting starting positions
   columnized = im2col(signal,[window_size,1]) % convert each window to a column
   x = abs(fft(columnized(:,starters))) % skip windows according to stride,apply fft, take abs and display
   imagesc(x(size(x,1)/2:end,:))
   title('Spectrogram')
   xlabel('Samples')
   ylabel('Frequency')
end
