rec = audiorecorder(44100,24,1);

disp('Start')
recordblocking(rec, 5);
disp('End');

recording = getaudiodata(rec);

sub_24 = resample(recording,6,11);
sub_16 = resample(recording,4,11);
sub_8 = resample(recording,2,11);
sub_4= resample(recording,1,11);

church = audioread('smallchurch.wav');
in_church = conv(recording(:,1),church(:,1));

caves = audioread('minicaves.wav');
in_caves = conv(recording(:,1),caves(:,1));

hall = audioread('bighall.wav');
in_hall = conv(recording(:,1),hall(:,1));

player1 = audioplayer(in_church,44100);
pause(5);
player2 = audioplayer(in_caves,44100);
pause(5);
player3 = audioplayer(in_hall,44100);

play(player1);
play(player2);
play(player3);
