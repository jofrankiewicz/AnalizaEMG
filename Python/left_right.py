import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np
from convert import array_from_dat_file


def left_or_right(array):
    srednia = np.mean(array)
    if srednia > 0:
        return 'right'
    elif srednia < 0:
        return 'left'


def top_or_bottom(array, hand):
    ix = []
    for i in range(len(array) - 1):
        if(array[i] != array[i + 1]):
            ix.append(i)

    for i in ix[0:-1]:
        t1 = np.take(array, range(i, i + 50))
        t2 = np.take(array, range(i + 50, i + 100))

        if np.mean(t1) > np.mean(t2):
            if hand == 'right':
                return 'bottom'
            elif hand == 'left':
                return 'top'
        elif np.mean(t1) < np.mean(t2):
            if hand == 'right':
                return 'top'
            elif hand == 'left':
                return 'bottom'


file = '2017-12-13 00-46-24 EgzoDynamicReversalExercise Position.dat'
array = array_from_dat_file(file)
which_hand = left_or_right(array)
destination = top_or_bottom(array, which_hand)
