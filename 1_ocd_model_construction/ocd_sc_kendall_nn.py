#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr  7 23:51:47 2025

@author: haeunsun
"""

"""
Created on Fri Jul 19 17:32:05 2024

@author: haeunsun
"""

import mat73
import numpy as np
import scipy.io
from scipy.stats import kendalltau

strucgm=mat73.loadmat('send_fin/strucgm_vect_red.mat')

boldmap=mat73.loadmat('/send_fin/boldmap_paper_lv_red_nn/boldmap_list_sc_bin_vect_red.mat')
pt_list=np.arange(0,np.size(strucgm["strucgm_vect_red"],0))
task_list=np.arange(0,11)
coeff_sc_kendall=np.zeros([len(pt_list),len(task_list)])

for i in pt_list:
    for j in task_list:
        corr, p=kendalltau(strucgm["strucgm_vect_red"][i,:],boldmap["map_vect"][j,:])
        coeff_sc_kendall[i,j]=corr
coeff_sc_kendall={"coeff_a2_kendall":coeff_sc_kendall}

coeff_sc_kendall_array = coeff_sc_kendall["coeff_a2_kendall"].astype('float64', order='F')

# 저장
scipy.io.savemat(
    '/send_fin/coeff_sc_kendall.mat',
    {"coeff_sc_kendall": coeff_sc_kendall_array},
    do_compression=True,
    oned_as='column'  # 중요
)

