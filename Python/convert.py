import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np
import csv


def array_from_dat_file(path):
    typ = np.dtype([
        ("seconds", np.int32),
        ("data", np.float32),
    ])
    dat_file = open(path, 'rb')
    tab = np.fromfile(dat_file, dtype=typ)
    dat_file.close()
    rozmiar = np.size(tab)
    nowa_tablica = np.zeros(rozmiar)
    # kopia ze struktury do tablicy
    for i in range(rozmiar):
        nowa_tablica[i] = tab[i][1]
    # wektor z poziomego na pionowy
    nowa_tablica = np.transpose(nowa_tablica)
    return nowa_tablica


def Convert_to_csv(path):
    nowa_tablica = array_from_dat_file(path)
    sciezka = path.replace(".dat", ".csv")
    np.savetxt(sciezka, nowa_tablica, delimiter=',')


plik = '2017-12-13 00-46-24 EgzoDynamicReversalExercise Position.dat'
Convert_to_csv(plik)
raw1 = "2017-12-13 00-46-24 EgzoDynamicReversalExercise RawCh1.dat"
raw2 = "2017-12-13 00-46-24 EgzoDynamicReversalExercise RawCh2.dat"
raw4 = "2017-12-13 00-46-24 EgzoDynamicReversalExercise RawCh4.dat"

ch1 = "2017-12-13 00-46-24 EgzoDynamicReversalExercise Ch1.dat"
ch2 = "2017-12-13 00-46-24 EgzoDynamicReversalExercise Ch2.dat"
ch4 = "2017-12-13 00-46-24 EgzoDynamicReversalExercise Ch4.dat"
Convert_to_csv(ch1)
Convert_to_csv(ch2)
Convert_to_csv(ch4)
