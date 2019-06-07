import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np
from matrix import create_matrix
from convert import array_from_dat_file
from left_right import left_or_right, top_or_bottom


def min_or_max_local(which_hand, destination):
    if (which_hand == 'left'):
        if(destination == 'top'):
            return 2
        elif(destination == 'bottom'):
            return 0
    elif(which_hand == 'right'):
        if(destination == 'top'):
            return 0
        if(destination == 'left'):
            return 2


file = '2017-12-13 00-46-24 EgzoDynamicReversalExercise Position.dat'

array = array_from_dat_file(file)
which_hand = left_or_right(array)
destination = top_or_bottom(array, which_hand)
first_value = min_or_max_local(which_hand, destination)
