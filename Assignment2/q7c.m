prompt = 'What is the your roll number? ';
x = input(prompt)
generator(x)
len = size(num2str(x),2)

function roll_number = generator(n)
  dial_tone = [        941  , 1336;
                       697  , 1209;
                       697  , 1336;
                       697  , 1477;
                       770  , 1209;
                       770  , 1336;
                       770  , 1477;
                       852  , 1209;
                       852  , 1336;
                       852  , 1477 ]
    roll_number = double.empty(1,0)
    len = size(num2str(n),2)
    for i= 1:len
      digit = get_digit(i,n);
      roll_number = cat(2,roll_number,beeper(dial_tone(digit+1,1),dial_tone(digit+1,2)));
    end
    spectrogram(roll_number,6276,0,'yaxis');
    sound(roll_number,8192);
end

function beep = beeper(f1,f2)
    fs = 8192;
    t = 0:1/fs:0.2-1/fs;
    beep = cos(2*pi*f1*t) + cos(2*pi*f2*t);
    beep = padarray(beep,[0 3000],0,'post')
end

function digit = get_digit(i,n)
  x = num2str(n)
  digit = str2num(x(i))
end



% roll_number = cat(2, beeper(697,1336),...
%                      beeper(941,1336),...
%                      beeper(697,1209),...
%                      beeper(852,1209),...
%                      beeper(697,1209),...
%                      beeper(941,1336),...
%                      beeper(770,1336),...
%                      beeper(697,1336))
