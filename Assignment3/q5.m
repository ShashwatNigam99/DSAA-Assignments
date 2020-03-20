clear
clc
close all

[s1,fs] = audioread('./q5/1.wav')
[s2,fs] = audioread('./q5/2.wav')
[s3,fs] = audioread('./q5/3.wav')
[s4,fs] = audioread('./q5/4.wav')
[s5,fs] = audioread('./q5/5.wav')

t = fs*5
starts = zeros(t,5)
starts(:,1) = s1(1:t,1)
starts(:,2) = s2(1:t,1)
starts(:,3) = s3(1:t,1)
starts(:,4) = s4(1:t,1)
starts(:,5) = s5(1:t,1)

ends = zeros(t,5)
ends(:,1) = s1(end-t+1:end,1)
ends(:,2) = s2(end-t+1:end,1)
ends(:,3) = s3(end-t+1:end,1)
ends(:,4) = s4(end-t+1:end,1)
ends(:,5) = s5(end-t+1:end,1)

combs = perms([1 2 3 4 5])

corr = zeros(120,1)
for i = 1:120
  p1=combs(i,1)
  p2=combs(i,2)
  p3=combs(i,3)
  p4=combs(i,4)
  p5=combs(i,5)
  corr(i) = max(abs(xcorr(ends(:,p1),starts(:,p2)))) + ...
        max(abs(xcorr(ends(:,p2),starts(:,p3)))) + ...
        max(abs(xcorr(ends(:,p3),starts(:,p4)))) + ...
        max(abs(xcorr(ends(:,p4),starts(:,p5))))
end
[maxval,index] = max(corr)
corr(index,:)

s1 = filtering(s1(:,1),fs)
s2 = filtering(s2(:,1),fs)
s3 = filtering(s3(:,1),fs)
s4 = filtering(s4(:,1),fs)
s5 = filtering(s5(:,1),fs)

s = [s3(1 : (end - (fs * 4)), :); s5((end - (fs * 4)), :); s1(end - (fs * 4), :); s2(end - (fs * 4), :); s4(:, :)];
sound(s,fs)

function s = filtering(s1,fs)
  % s = lowpass(s1(:,1),230,fs)
  [b,a] = butter(9,800/(fs/2))
  s = filter(b,a,s1)
  % s = smoothdata(s,'movmedian',5)
  s = smoothdata(s,'gaussian',5)
end

 combs(index,:) % 3 5 1 2 4
