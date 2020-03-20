clear;
clc;
close all;
load Q4.mat

fft_signal = abs(fft(X))
figure
subplot(2,1,1)
stem(fft_signal)
sound(X,Fs)

filtered_fft = arrayfun(@(x) threshold(x),fft_signal)
subplot(2,1,2)
stem(filtered_fft)
pause(2)
filtered_sound = ifft(filtered_fft)
sound(filtered_sound,Fs)
length = size(X,1)

function y = threshold(x)
  if x>30000
    y=x;
  else
    y=0;
  end
end
