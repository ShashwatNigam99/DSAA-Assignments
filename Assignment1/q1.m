rec = audiorecorder(44100,16,1);
disp('Start')
recordblocking(rec, 5);
disp('End');

recObj = getaudiodata(rec);

half = resample(recObj,2,1);
double = resample(recObj,1,2);

subplot(2,1,1)
plot(half);

subplot(2,1,1)
plot(double);
