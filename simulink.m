clc;
clear all;
close all;

%% Load the audio signals
[signal1, Fs] = audioread("G:\COMM LAB project\sounds\heartbeat-sound-effects-for-you-122458.mp3");
[signal2, ~] = audioread("G:\COMM LAB project\sounds\mixkit-light-rain-loop-2393.wav");

%% Normalize and match lengths
signal1 = signal1 / max(abs(signal1)); % Normalize signal1
signal2 = signal2 / max(abs(signal2)); % Normalize signal2
minLength = min(length(signal1), length(signal2)); % Match the length of both signals
signal1 = signal1(1:minLength); % Trim signal1
signal2 = signal2(1:minLength); % Trim signal2

%% Create a time vector with Fs = 44100
time = (0:minLength-1)' / Fs; % Time column in seconds

%% Combine time and signals into a 2D matrix
signal1 = [time, signal1]; % Time in the first column, signal values in the second
signal2 = [time, signal2]; % Time in the first column, signal values in the second

%% Save the data for Simulink
save('G:\COMM LAB project\signals.mat', 'signal1', 'signal2', 'Fs');
