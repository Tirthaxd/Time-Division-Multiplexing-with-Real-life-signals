clc;
clear all;
close all;

%% Load audio signals
[signal1, Fs1] = audioread("G:\COMM LAB project\sounds\mixkit-light-rain-loop-2393.wav");  
[signal2, Fs2] = audioread("G:\COMM LAB project\sounds\heartbeat-sound-effects-for-you-122458.mp3");  

%% Resample signals to a common sampling rate
Fs = max(Fs1, Fs2); % Use the higher sampling rate
signal1 = resample(signal1, Fs, Fs1);
signal2 = resample(signal2, Fs, Fs2);

%% Normalize signals
signal1 = signal1 / max(abs(signal1));
signal2 = signal2 / max(abs(signal2));

%% Ensure both signals have the same length
min_length = min(length(signal1), length(signal2));
signal1 = signal1(1:min_length);
signal2 = signal2(1:min_length);

%% Time Division Multiplexing
frame_size = 100; % Number of samples per time slot
num_frames = floor(length(signal1) / frame_size);

mux_signal = zeros(2 * num_frames * frame_size, 1);

for i = 1:num_frames
    start_idx = (i - 1) * frame_size * 2 + 1;
    mux_signal(start_idx:start_idx+frame_size-1) = signal1((i-1)*frame_size+1:i*frame_size);
    mux_signal(start_idx+frame_size:start_idx+2*frame_size-1) = signal2((i-1)*frame_size+1:i*frame_size);
end

%% Play multiplexed signal
%sound(mux_signal, Fs);

%% Visualization
figure;
subplot(3,1,1); plot(signal1); title('Original Signal 1'); xlabel('Sample Index'); ylabel('Amplitude');
subplot(3,1,2); plot(signal2); title('Original Signal 2'); xlabel('Sample Index'); ylabel('Amplitude');
subplot(3,1,3); plot(mux_signal); title('Multiplexed Signal'); xlabel('Sample Index'); ylabel('Amplitude');


%% Time Division Demultiplexing
demux_signal1 = zeros(num_frames * frame_size, 1);
demux_signal2 = zeros(num_frames * frame_size, 1);

for i = 1:num_frames
    start_idx = (i - 1) * frame_size * 2 + 1;
    demux_signal1((i-1)*frame_size+1:i*frame_size) = mux_signal(start_idx:start_idx+frame_size-1);
    demux_signal2((i-1)*frame_size+1:i*frame_size) = mux_signal(start_idx+frame_size:start_idx+2*frame_size-1);
end

%% Play demultiplexed signals
disp('Playing Demultiplexed Signal 1...');
sound(demux_signal1, Fs);
pause(length(demux_signal1) / Fs + 1);

disp('Playing Demultiplexed Signal 2...');
sound(demux_signal2, Fs);

%% Visualization of Demultiplexed Signals
figure;
subplot(2,1,1); plot(demux_signal1); title('Demultiplexed Signal 1'); xlabel('Sample Index'); ylabel('Amplitude');
subplot(2,1,2); plot(demux_signal2); title('Demultiplexed Signal 2'); xlabel('Sample Index'); ylabel('Amplitude');


 
