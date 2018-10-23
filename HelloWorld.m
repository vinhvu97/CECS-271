%Vinh Vu, 015347252, Lab 1
% generate a random number between 1 and 10 and assign it to mynum
% rand returns a pseudorandom number in the interval (0,1)
mynum = floor(10*rand+1);
%prompt the user to guess the number stored in mynum
guess = input('input your guess:');
%load a sound file called "splat"
load splat
%loop so long as guess does not equal mynum
%Note that ~= means "not equal"
while guess ~= mynum
%play the sound file
sound(y,Fs)
if guess > mynum
disp('too high!')
else
disp('too low!')
end;
guess = input('guess again: ');
end
disp('correct!')
load handel
sound(y,Fs) %Hallelujah