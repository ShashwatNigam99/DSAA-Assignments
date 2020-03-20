[sound,freq] = audioread('sa_re_ga_ma.mp3');

original = audioplayer(sound,freq);

Rlowess = smoothdata(sound,'rlowess');
Rlowess_ans = audioplayer(Rlowess,freq);
play(Rlowess_ans)

Rloess = smoothdata(sound,'rloess');
Rloess_ans = audioplayer(Rloess,freq);
play(Rloess_ans)

Movemedian = smoothdata(sound,'movmedian');
Movemedian_ans = audioplayer(Movemedian,freq);
play(Movemedian_ans)

Sgolay = smoothdata(sound,'sgolay', 100);
Sgolay_ans = audioplayer(Sgolay,freq);
play(Sgolay_ans)

Movmean = smoothdata(sound,'movmean', 10);
Movmean_ans = audioplayer(Movmean,freq);
play(Movmean_ans)

SmoothingFactor = smoothdata(sound,'SmoothingFactor', 0.999999);
SmoothingFactor_ans = audioplayer(SmoothingFactor,freq);
play(SmoothingFactor_ans)

Lowess = smoothdata(sound,'lowess');
Lowess_ans = audioplayer(Lowess,freq);
play(Lowess_ans)

Gaussian = smoothdata(sound,'gaussian');
Gaussian_ans = audioplayer(Gaussian,freq);
play(Gaussian_ans)
