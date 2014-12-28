% ECE 561- GRAPHIC EQUALIZER PROJECT 
% ROSHNI UPPALA 
% MATLAB function designed to calculate the effective impulse response with
% rectangular window and bartlett window.
% m        Length of the filter
% hrect    Impulse response with rectanglar window
% hbart    Impulse response with bartlett window
% hfilter  Name of this function block 

function [hbart hrect]=hfilter(w1,w2)
m=301
n=[-(m-1)/2:(m-1)/2]
hrect =((w2/pi)*sinc((w2*n)/pi))-((w1/pi)*sinc((w1*n)/pi))
w=window(@bartlett,m)
hbart=hrect.*w';

