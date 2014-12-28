%ECE 561- Digital Signal Processing -I
%Roshni Uppala - 1011735230 
%Project II - Graphic Equalizer Project
%Variable Description:
% m          FIR length 
% fs         sampling frequency
% f_cutoff   cut off frequency
% w_cutoff   cut off frequency in radians/sample
%The center frequencies are chosen such that they are logarithmic increasing.
%The gains can be adjusted to get the desired changes in the output sound.
%hfilter is the designed function block 
%hr1,hr2,hr3,hr4,hr5 are the impulse response of the respective FIR filter
%with rectangular window.
%hb1,hb2,hb3,hb4,hb5 are the impulse response of the respective FIR filter
%with bartlett window.
%hoverall is the overall effective impulse response 

clear all; close all; clc
m=301;
n=-(m-1)/2:(m-1)/2;
fs=44100;
f_cutoff = [0 300 2000 4000 12000 fs/2];
gain = [10 4 1 4 10];
w_cutoff= 2*pi*f_cutoff *(1/fs);
[hb1 hr1]=hfilter(w_cutoff(1),w_cutoff(2));
[hb2 hr2]=hfilter(w_cutoff(2),w_cutoff(3));
[hb3 hr3]=hfilter(w_cutoff(3),w_cutoff(4));
[hb4 hr4]=hfilter(w_cutoff(4),w_cutoff(5));
[hb5 hr5]=hfilter(w_cutoff(5),w_cutoff(6));
hoverall=gain(1)*hb1+gain(2)*hb2+gain(3)*hb3+gain(4)*hb4+gain(5)*hb5;
stem(n,hoverall)
title('Overall effective impulse response');
xlabel('n');
ylabel('h(n)');
%% Stem plot of middle bandpass filter
%With rectangular window
figure;stem(n,hr3);
xlabel('n');ylabel('Impulse response (h[n])');
title('Middle Bandpass Filter Impulse Response with rectangular window ');
%With the bartlett window
figure;stem(n,hb3);
xlabel('n');ylabel('Impulse response ( h[n] )');
title('Middle Bandpass Filter Impulse Response with bartlett window');

%% Frequency Responses
Hr3=abs(fftshift(fft(hr3,1024)));
Hb3=abs(fftshift(fft(hb3,1024)));
N = length(Hr3);
if mod(N,2) % Odd N
    f = -fs*(N-1)/(2*N) : fs/N : fs*(N-1)/(2*N); % For odd N
else % Even N
    f = -fs/2 : fs/N : fs*(N-2)/(2*N); % For even N
end
for i = 1 : length(f)
    if abs(f(i))>=2000 && abs(f(i))<=4000
        ideal_H(i) = 1/fs;
    else
        ideal_H(i) = 0;
    end
end
figure;plot(f,ideal_H,'r',f,(1/fs)*Hr3,'b',f,(1/fs)*Hb3,'g')
xlabel('Frequency (Hertz)');
ylabel('H(w)');
title('Effective magnitude frequency response');

%% Overall effective frequency response for the system with filter gains
fs=30100 %44100
w=linspace(-pi,pi,1024);
H=abs(fftshift(fft(hoverall,1024)));
figure;
plot(w,abs(H));
xlabel('w in radians/sample');
ylabel('Magnitude of the overall frequency response of the filter');
title('Overall effective frequency response for the system with filter gains');

%% Processing the sound file with the overall FIR filter
x = wavread('gorka.wav');
sound(x,fs)
y(:,1) = conv(x(:,1),hoverall);
y(:,2) = conv(x(:,2),hoverall);
figure;specgram([x(:,1);y(:,1)],1000,fs)
xlabel('Time in seconds');
ylabel('Frequency in Hertz');
title('Unprocessed data(left column) and processed data(right columnm)');
figure;specgram([x(:,2);y(:,2)],1000,fs)
xlabel('Time in seconds');
ylabel('Frequency in Hertz');
title('Unprocessed data(left column) and processed data(right columnm)');
soundsc(y,fs)
audiowrite('new_gorka_30.1Khz.wav',y,fs)

