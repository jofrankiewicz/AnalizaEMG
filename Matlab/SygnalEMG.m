position = load('2017-12-13 00-46-24 EgzoDynamicReversalExercise Position.csv');
position = filter(fir1(101,0.0001),1,position); %filtracja pozycji rêki

%interpolacja
x = 1:length(position);
v = position;
xq = 1:0.5:length(position);
new_position = interp1(x,v,xq);
%plot(x,v,'o',xq,new_position,'*');
new_position = transpose(new_position);

raw1 = load('2017-12-13 00-46-24 EgzoDynamicReversalExercise RawCh1.csv');
raw2 = load('2017-12-13 00-46-24 EgzoDynamicReversalExercise RawCh2.csv');
raw4 = load('2017-12-13 00-46-24 EgzoDynamicReversalExercise RawCh4.csv');

raw1 = raw1(1:300000);
raw2 = raw2(1:300000);
raw4 = raw4(1:300000);

% raw1 = raw1 * 1.0/6.0 * 2.4 / (2^(23)-1) * 1^(6);
% raw2 = raw2 * 1.0/6.0 * 2.4 / (2^(23)-1) * 1^(6);
% raw2 = raw2 * 1.0/6.0 * 2.4 / (2^(23)-1) * 1^(6);

Fs = 1000;
t = 1:1/Fs:301;
t = t(1:300000)

%% 
[n,Wn]= buttord([1,499]/500,[48,52]/500, 3,50);
[b,a]= butter(n,Wn,'stop'); %usuniêcie 50Hz
band = (2/Fs)* [10 350];
[B1, A1] = butter(2, band, 'Bandpass'); %pasmowo-przepustowy 10-350Hz, zakres charakterystyczny dla EMG

figure(1)
subplot(1,3,1)
fSignal1 = filter(b,a, raw1, [], 1);
fSignal1 = filter(B1,A1,fSignal1);
plot(t, fSignal1);
title('Surowy sygna³ aktywno¶ci miê¶nia dwug³owego ramienia po filtracji')
xlabel('Czas [s]')
ylabel('Amplituda [mV]')
ylim([-6*10^(-41) 6*10^(-41)])
xlim([1 300]);

subplot(1,3,2)
fSignal2 = filter(b,a, raw2, [], 1);
fSignal2 = filter(B1,A1,fSignal2);
plot(t, fSignal2);
title('Surowy sygna³ aktywno¶ci miê¶nia naramiennego po filtracji')
xlabel('Czas [s]')
ylabel('Amplituda [mV]')
ylim([-6*10^(-41) 6*10^(-41)])
xlim([1 300]);

subplot(1,3,3)
fSignal4 = filter(b,a, raw4, [], 1);
fSignal4 = filter(B1,A1,fSignal4);
plot(t, fSignal4);
title('Surowy sygna³ aktywno¶ci miê¶nia trójg³owego ramienia po filtracji')
xlabel('Czas [s]')
ylabel('Amplituda [mV]')
ylim([-6*10^(-41) 6*10^(-41)])
xlim([1 300]);
 % -------------- %
%% 


figure(2)
subplot(1,3,1)
emg1 = abs(fSignal1(2001:end)); %%rektyfikacja
t = t(1:298000);
emg1 = smooth(emg1(:));
%emg1 = rms(emg1, 30, 10, 1);  %%wyg³adzenie
[max_value1, index_number1] = max(emg1(:));
emg1= emg1./max_value1; %normalizacja;
emg1 = emg1.*10^(3);
plot(t, emg1);
title('Aktywno¶æ miê¶nia dwug³owego ramienia po przetworzeniu')
xlabel('Czas [s]')
ylabel('Aktywno¶æ miê¶niowa [mikroV]')
ylim([0 1200]);
xlim([0 300])

subplot(1,3,2)
emg2 = abs(fSignal2(2001:end)); %%rektyfikacja
emg2 = smooth(emg2(:))
%emg2 = rms(emg2, 40, 10, 1);  %%wyg³adzenie
[max_value2, index_number2] = max(emg2(:))
emg2= emg2./max_value2; %normalizacja;
emg2 = emg2.*10^(3);
plot(t, emg2);
title('Aktywno¶æ miê¶nia naramiennego po przetworzeniu')
xlabel('Czas [s]')
ylabel('Aktywno¶æ miê¶niowa [mikroV]')
ylim([0 1200]);
xlim([0 300])

subplot(1,3,3)
emg4 = abs(fSignal4(2001:end)); %%rektyfikacja
%emg4 = rms(emg4, 40, 10, 1);  %%wyg³adzenie
[max_value4, index_number4] = max(emg4(:))
emg4= emg4./max_value4; %normalizacja;
emg4 = emg4.*10^(3);
plot(t, emg4);
title('Aktywno¶æ miê¶nia trójg³owego ramienia po przetworzeniu')
xlabel('Czas [s]')
ylabel('Aktywno¶æ miê¶niowa [mikroV]')
ylim([0 1200]);
xlim([0 300])



%% 
t1 = 1:298000
new_position = new_position(2001:300000);
[Maxima,MaxIdx] = findpeaks(new_position, 'MinPeakProminence',10);
DataInv = 1.01*max(new_position) - new_position;
[Minima,MinIdx] = findpeaks(DataInv, 'MinPeakProminence',10);
Minima = new_position(MinIdx);
figure(3)
plot(t1, new_position)
title('Wychylenie rêki podczas rehabilitacji')
xlabel('Numer próbki')
ylabel('K±t wychylenia [stopnie]')
hold on
scatter(MaxIdx, Maxima, 'm*')
scatter(MinIdx, Minima, 'b*')
hold off
legend('wychylenie koñczyny górnej', 'maksima lokalne', 'minima lokalne')
%%
%przeliczenie stopni na radiany
pozycje_radiany = (new_position./360) * 2*pi;







