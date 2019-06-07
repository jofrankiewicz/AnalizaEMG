import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import scipy as sp
import scipy.interpolate
import numpy as np
import csv
from convert import array_from_dat_file


def edit_position(path):
    position = array_from_dat_file(path)
    print(position)
    size = np.size(position)
    print(size)
    shape = np.shape(position)
    print(shape)
    position = position.reshape(shape, 2)
    print(np.shape(position))

    new_array_position = np.zeros(2 * position.size, dtype=np.int32)
    new_array_position = np.transpose(new_array_position)
    for i in range(position.size):
        new_array_position[2 * i] = position[i]
        new_array_position[2 * i + 1] = position[i]

    return new_array_position


def derivatives(path):
    position = array_from_dat_file(path)
    derivatives_position = np.zeros(position.size, dtype=np.int32)

    derivatives_position = np.diff(position)
    new_derivatives_position = np.zeros(2 * derivatives_position.size, dtype=np.float32)
    for i in range(derivatives_position.size):
        new_derivatives_position[2 * i] = derivatives_position[i]
        new_derivatives_position[2 * i + 1] = derivatives_position[i]

    return new_derivatives_position


def create_matrix(path_raw1, path_raw2, path_raw4, position, sciezka):
    raw1 = array_from_dat_file(path_raw1)
    raw2 = array_from_dat_file(path_raw2)
    raw4 = array_from_dat_file(path_raw4)
    position_array = edit_position(position)
    size_position = position_array.size
    position_derivatives = derivatives(position)

    raw1_change = np.zeros(size_position, dtype=np.float32)
    raw1_change = np.transpose(raw1_change)
    raw2_change = np.zeros(size_position, dtype=np.float32)
    raw2_change = np.transpose(raw2_change)
    raw4_change = np.zeros(size_position, dtype=np.float32)
    raw4_change = np.transpose(raw4_change)

    new_position_array = np.copy(position_array[0:size_position - 2])
    raw1_change = np.copy(raw1[0:size_position - 2])
    raw2_change = np.copy(raw2[0:size_position - 2])
    raw4_change = np.copy(raw4[0:size_position - 2])
    matrix = np.stack((position_derivatives, new_position_array, raw1_change, raw2_change, raw4_change), axis=1)

    np.savetxt(sciezka, matrix, delimiter=',')
    return matrix


plik1 = '2017-12-13 00-46-24 EgzoDynamicReversalExercise RawCh1.dat'
plik2 = '2017-12-13 00-46-24 EgzoDynamicReversalExercise RawCh2.dat'
plik4 = '2017-12-13 00-46-24 EgzoDynamicReversalExercise RawCh4.dat'
podsumowanie = '2017-12-13 00-46-24 podsumowanie.csv'
position = "2017-12-13 00-46-24 EgzoDynamicReversalExercise Position.dat"

macierz = create_matrix(plik1, plik2, plik4, position, podsumowanie)
edit_position(position)
#plt.plot(macierz[:, 0])
# plt.show()
