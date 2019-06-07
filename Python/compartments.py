import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np
import scipy
from scipy.signal import savgol_filter
import csv
import plotly.plotly as py
import plotly.graph_objs as go
from plotly.tools import FigureFactory as FF
import peakutils
from scipy.signal import argrelextrema
from scipy.signal import argrelmax, argrelmin
from convert import array_from_dat_file
from matrix import edit_position, derivatives, create_matrix
from left_right import left_or_right, top_or_bottom
from data_analysis import min_or_max_local


# def locate_min_max(matrix, first_value):
#     find_local = np.ones(matrix.size, dtype=np.int32)

#     j = first_value
#     if(j == 2):
#         find_local[0] = 2
#     elif(j == 0):
#         find_local[0] = 0
#     else:
#         find_local[0] = 1
#     print(find_local)
#     i = 1
#     print(find_local[0])

#     while(i < find_local.size - 1):
#         while(matrix[i] == 0.000000000000000000e+00):
#             if(matrix[i] == matrix[i - 1]):
#                 #print('x= ', i)
#                 #print("I = :", i + 1, "Wartosc=", find_local[i])
#                 i += 1
#                 continue
#         while(matrix[i] != 0.000000000000000000e+00):
#             #print('y = ', i)
#             #print("I = :", i, "Wartosc=", find_local[i])
#             if(i == find_local.size - 1):
#                 exit()
#             if(matrix[i + 1] == 0.000000000000000000e+00):
#                 if(matrix[i + 1] != matrix[i]):
#                     #print('z =', (i + 1))
#                     if(j == 0):
#                         j = 2
#                         find_local[i + 1] = 2
#                         #print("I = ", i + 1, "Wartosc = ", find_local[i + 1])
#                         i += 1
#                         break
#                     elif(j == 2):
#                         j = 0
#                         find_local[i + 1] = 0
#                         #print("I = ", i + 1, "Wartosc = ", find_local[i + 1])
#                         i += 1
#                         break
#                 else:
#                     i += 1
#                     break

#     return find_local


# def create_comparison(find_local, matrix, sciezka):
#    matrix0_change = np.copy(matrix[0:matrix.size - 1])
#    find_local = np.transpose(find_local)
#    comparison = np.stack((find_local, matrix0_change), axis=1)
#   np.savetxt(sciezka, comparison, delimiter=',')


plik1 = '2017-12-13 00-46-24 EgzoDynamicReversalExercise RawCh1.dat'
plik2 = '2017-12-13 00-46-24 EgzoDynamicReversalExercise RawCh2.dat'
plik4 = '2017-12-13 00-46-24 EgzoDynamicReversalExercise RawCh4.dat'
position = "2017-12-13 00-46-24 EgzoDynamicReversalExercise Position.dat"
podsumowanie = '2017-12-13 00-46-24 podsumowanie.csv'
lokalizacja_min_max = '2017-12-13 00-46-24 lokalizacja_min_max.csv'

matrix = create_matrix(plik1, plik2, plik4, position, podsumowanie)

which_hand = left_or_right(matrix[:, 1])
print("Ręka: ", which_hand)
destination = top_or_bottom(matrix[:, 1], which_hand)
print("Kierunek: ", destination)
first_value = min_or_max_local(which_hand, destination)
print("first value = ", first_value)

# a = np.diff(matrix[:, 1]).nonzero()[0] + 1  # local min+max
# b = (np.diff(np.sign(matrix[:, 0])) > 0).nonzero()[0] + 1  # local min
# c = (np.diff(np.sign(matrix[:, 0])) < 0).nonzero()[0] + 1  # local max

filter_data = savgol_filter(matrix[:, 1], 1, 0)  # filtracja danych
filter_data2 = savgol_filter(filter_data, 1, 0)  # filtracja danych

#1 filtr analizowac na podstawie czestotliwosci probkowania
#przeliczenie filtru nominalna wartosc, pasmo 0.5hz, 0.25z
#uwzglednic skalowanie

#sprawdzenie czy ma to przelozenie na rzeczywistosc
#lub aproksymacja

#lub wykryc minima odrzucajac jakies male probki

a = np.diff(filter_data2).nonzero()[0] + 1  # local min+max
b = (np.diff(np.sign(filter_data2)) > 0).nonzero()[0] + 1  # local min
c = (np.diff(np.sign(filter_data2)) < 0).nonzero()[0] + 1  # local max

#######################
# ind_max = argrelmax(filter_data2, np.greater)  # indices of the local maxima
# ind_min = argrelmin(filter_data2, np.lesser)  # indices of the local minima

# maxvals = z[ind_max]
# minvals = z[ind_min]

# print(maxvals)
# print(minvals)
######################


#######################################
# punkt = go.Scattergl(
#     x=[j for j in range(len(filter_data2))],
#     y=filter_data2,
#     mode='markers',
#     marker=dict(
#         line=dict(
#             width=1,
#             color='#404040')
#     )
# )

# data = [punkt]
# layout = dict(title='Wykres polozenia')
# fig = dict(data=data, layout=layout)
# py.iplot(data, filename='polozenie_konczyny_wykres')
########################################

# # graphical output...
# x = np.arange(0, len(filter_data2))
# plt.plot(x, filter_data2)
# plt.plot(x[b], filter_data2[b], "o", label="min")
# plt.plot(x[c], filter_data2[c], "o", label="max")
# plt.legend()
# plt.show()


# find_local = locate_min_max(filter_data2, first_value)
# create_comparison(find_local, matrix[:, 0], lokalizacja_min_max)
