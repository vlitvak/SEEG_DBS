#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr  8 01:41:29 2025

@author: haeunsun
"""


import mat73
import numpy as np
import scipy.io
from scipy.stats import kendalltau

strucgm=mat73.loadmat('send_fin/fc_vect_red.mat')

boldmap=mat73.loadmat('/send_fin/boldmap_paper_lv_red_nn/boldmap_list_fc_bin_vect_red.mat')
pt_list=np.arange(0,np.size(strucgm["fc_vect_red"],0))
task_list=np.arange(0,11)
coeff_fc_kendall=np.zeros([len(pt_list),len(task_list)])

for i in pt_list:
    for j in task_list:
        corr, p=kendalltau(strucgm["fc_vect_red"][i,:],boldmap["map_vect"][j,:])
        coeff_fc_kendall[i,j]=corr
coeff_fc_kendall_0={"coeff_fc_kendall":coeff_fc_kendall}


# 저장
scipy.io.savemat(
    'send_fin/coeff_fc_kendall.mat',
    coeff_fc_kendall_0
)
