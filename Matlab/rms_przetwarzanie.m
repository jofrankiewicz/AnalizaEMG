figure(5)
subplot(1,3,1)
emg1_x = abs(fSignal1); %%rektyfikacja
%emg1_x = smooth(emg1_x(:))
emg1_rms = rms(emg1_x, 30, 10, 1);  %%wyg³adzenie
norm = max(emg1_rms);
emg1_rms= emg1_rms./norm; %normalizacja;
tx = 1:1/50:301;
tx = tx(1:15000)
emg1_x = emg1_x.*10^(6);  %? razy ile
plot(tx, emg1_rms);
title('Aktywno¶æ miê¶nia dwug³owego ramienia po przetworzeniu')
xlabel('Czas [s]')
ylabel('Aktywno¶æ miê¶niowa [mikroV]')
xlim([0 300])
ylim([0 0.02])
%%
subplot(1,3,2)
emg2 = abs(fSignal2); %%rektyfikacja
emg2 = smooth(emg2(:))
%emg2 = rms(emg2, 40, 10, 1);  %%wyg³adzenie
norm = max(emg2);
emg2= emg2./norm; %normalizacja
emg2 = emg2.*10^(6);
plot(t, emg2);
title('Aktywno¶æ miê¶nia dwug³owego ramienia po przetworzeniu')
xlabel('Czas [s]')
ylabel('Aktywno¶æ miê¶niowa [mikroV]')
ylim([0 6000]);
xlim([0 300])

subplot(1,3,3)
emg4 = abs(fSignal4); %%rektyfikacja
emg4 = smooth(emg4(:))
%emg4 = rms(emg4, 40, 10, 1);  %%wyg³adzenie
norm = max(emg4);
emg4= emg4./norm; %normalizacja
emg4 = emg4.*10^(6);
plot(t, emg4);
title('Aktywno¶æ miê¶nia dwug³owego ramienia po przetworzeniu')
xlabel('Czas [s]')
ylabel('Aktywno¶æ miê¶niowa [mikroV]')
ylim([0 6000]);
xlim([0 300])