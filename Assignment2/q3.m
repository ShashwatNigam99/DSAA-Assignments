beep_array = ones(10,44100)
beep_array(1,:) = audioread('./q3/0.ogg')
beep_array(2,:) = audioread('./q3/1.ogg')
beep_array(3,:) = audioread('./q3/2.ogg')
beep_array(4,:) = audioread('./q3/3.ogg')
beep_array(5,:) = audioread('./q3/4.ogg')
beep_array(6,:) = audioread('./q3/5.ogg')
beep_array(7,:) = audioread('./q3/6.ogg')
beep_array(8,:) = audioread('./q3/7.ogg')
beep_array(9,:) = audioread('./q3/8.ogg')
beep_array(10,:) = audioread('./q3/9.ogg')

dial_freq = ones(10,2)
dialled_freq = ones(8,2)
number = ones(1,8)

for i=1:10
  [dial_freq(i,1),dial_freq(i,2)] = beep_finder(beep_array(i,:))
end

[dialled,fs]= audioread('tone.wav')
window_size = size(dialled,1)/8;
% because 8 dial tones heard

for i = 1:8
    [dialled_freq(i,1),dialled_freq(i,2)] = number_dialled(dialled(((i-1)*window_size+1):(i*window_size)),fs,window_size)
    for j = 1:10
      if (dialled_freq(i,1)<=(dial_freq(j,1)+1)) && (dialled_freq(i,1)>=(dial_freq(j,1)-1)) && (dialled_freq(i,2)>=(dial_freq(j,2)-1)) && (dialled_freq(i,2)<=(dial_freq(j,2)+1))
        number(i) = j-1
      end
    end
end

function [freq1,freq2] = beep_finder(beep)
  sz = size(beep,2)
  abs_fft_beep = abs(fft(beep))
  sorted_abs_fft_beep = sort(abs_fft_beep(1:(sz/2)))
  max1 = sorted_abs_fft_beep(end)
  max2 = sorted_abs_fft_beep(end-1)
  freq1 = find(abs_fft_beep==max1,1,'first')
  freq2 = find(abs_fft_beep==max2,1,'first')
end

function [freq1,freq2] = number_dialled(beep,fs,window_size)
  sz = size(beep)
  abs_fft_beep = abs(fft(beep))
  sorted_abs_fft_beep = sort(abs_fft_beep(1:(sz/2)))
  max1 = sorted_abs_fft_beep(end)
  max2 = sorted_abs_fft_beep(end-1)
  freq1 = floor(find(abs_fft_beep==max1,1,'first')*(fs/window_size));
  freq2 = floor(find(abs_fft_beep==max2,1,'first')*(fs/window_size));
end
