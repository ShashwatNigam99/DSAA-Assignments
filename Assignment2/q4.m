[tone,fs] = audioread('signal_6.wav')
tonel = tone(:,1)

order = 10
bf = 200 / (fs/2);
ef = 4000/ (fs/2);
[b,a] = butter(order,[bf,ef],'bandpass');
left_filtered = filter(b,a,tonel);

meaned = smoothdata(left_filtered,'movmean')

gaussed = smoothdata(meaned,'gaussian',15,'omitnan')
stem(abs(fft(gaussed)));

sound(gaussed,fs)
% sound(smoothdata(tonel,'lowess',20),22050)
