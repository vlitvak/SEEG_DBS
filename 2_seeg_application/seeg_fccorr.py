#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 22 18:08:26 2025

@author: haeunsun
"""

import mat73
import numpy as np
import scipy.io
from scipy.stats import kendalltau

boldmap=mat73.loadmat('/Volumes/WD_BLACK/FIL_data/send_fin/boldmap_paper_lv_red_nn/boldmap_list_fc_bin_vect_red.mat')
csv_list=[
"O05_mni_bcb_contacts.csv",
"O10_mni_bcb_contacts.csv",
"P01_mni_bcb_contacts.csv",
"P02_mni_bcb_contacts.csv",
"P03_mni_bcb_contacts.csv",
"P04_mni_bcb_contacts.csv",
"P05_mni_bcb_contacts.csv",
"P06_mni_bcb_contacts.csv",
"P07_mni_bcb_contacts.csv",
"P08_mni_bcb_contacts.csv",
"P09_mni_bcb_contacts.csv",
"P10_mni_bcb_contacts.csv",
"P11_mni_bcb_contacts.csv",
"P12_mni_bcb_contacts.csv",
"P13_mni_bcb_contacts.csv",
"P15_mni_bcb_contacts.csv",
"P16_mni_bcb_contacts.csv",
"P17_mni_bcb_contacts.csv",
"R01_mni_bcb_contacts.csv",
"R02_mni_bcb_contacts.csv",
"R03_mni_bcb_contacts.csv",
"R04_mni_bcb_contacts.csv",
"R05_mni_bcb_contacts.csv",
"R06_mni_bcb_contacts.csv",
"R07_mni_bcb_contacts.csv",
"R08_mni_bcb_contacts.csv",
"R09_mni_bcb_contacts.csv",
"R10_mni_bcb_contacts.csv",
"R11_mni_bcb_contacts.csv",
"R12_mni_bcb_contacts.csv",
"R13_mni_bcb_contacts.csv",
"R14_mni_bcb_contacts.csv",
"R15_mni_bcb_contacts.csv",
"R16_mni_bcb_contacts.csv",
"R17_mni_bcb_contacts.csv",
"R18_mni_bcb_contacts.csv",
"R19_mni_bcb_contacts.csv",
"R20_mni_bcb_contacts.csv",
"R21_mni_bcb_contacts.csv",
"R22_mni_bcb_contacts.csv",
"R23_mni_bcb_contacts.csv",
"R24_mni_bcb_contacts.csv",
"R25_mni_bcb_contacts.csv",
"R26_mni_bcb_contacts.csv",
"R27_mni_bcb_contacts.csv",
"R28_mni_bcb_contacts.csv",
"R29_mni_bcb_contacts.csv",
"R30_mni_bcb_contacts.csv",
"R31_mni_bcb_contacts.csv",
"R32_mni_bcb_contacts.csv",
"S07_mni_bcb_contacts.csv",
"S13_mni_bcb_contacts.csv",
"S15_mni_bcb_contacts.csv",
"T01_mni_bcb_contacts.csv",
"T02_mni_bcb_contacts.csv",
"T03_mni_bcb_contacts.csv",
"T05_mni_bcb_contacts.csv",
"T06_mni_bcb_contacts.csv",
"T07_mni_bcb_contacts.csv",
"T08_mni_bcb_contacts.csv",
"T09_mni_bcb_contacts.csv",
"T10_mni_bcb_contacts.csv",
"T11_mni_bcb_contacts.csv",
"T12_mni_bcb_contacts.csv",
"T13_mni_bcb_contacts.csv",
"T14_mni_bcb_contacts.csv",
"T16_mni_bcb_contacts.csv",
"T17_mni_bcb_contacts.csv",
"T18_mni_bcb_contacts.csv",
"T20_mni_bcb_contacts.csv",
"T21_mni_bcb_contacts.csv",
"T22_mni_bcb_contacts.csv",
"T23_mni_bcb_contacts.csv",
"T24_mni_bcb_contacts.csv",
"T25_mni_bcb_contacts.csv",
"T26_mni_bcb_contacts.csv",
"T27_mni_bcb_contacts.csv",
"T28_mni_bcb_contacts.csv",
"T29_mni_bcb_contacts.csv",
"T31_mni_bcb_contacts.csv",
"T32_mni_bcb_contacts.csv",
"T33_mni_bcb_contacts.csv",
"T34_mni_bcb_contacts.csv",
"T35_mni_bcb_contacts.csv",
"T36_mni_bcb_contacts.csv",
"T37_mni_bcb_contacts.csv"];

pt_list=np.arange(0,len(csv_list))
task_list=np.arange(0,np.size(boldmap["map_vect"],0))

for i in pt_list:

    pt=csv_list[i][0:3]
    fc=mat73.loadmat('/Volumes/WD_BLACK/FIL_data/send_fin/new_bin_paper/fc_vect_'+pt+'.mat')
    seeds=np.arange(0,np.size(fc['fc_vect_red'],0))
    coeff_fc_pt=np.zeros([len(seeds),len(task_list)])
    for j in seeds:
        for k in task_list:
            corr, p=kendalltau(fc["fc_vect_red"][j,:],boldmap["map_vect"][k,:])
            coeff_fc_pt[j,k]=corr
    
    coeff_fc_pt={'coeff_fc_pt':coeff_fc_pt}
    scipy.io.savemat('/Volumes/WD_BLACK/FIL_data/send_fin_nn/coeff_fc_'+pt+'.mat',coeff_fc_pt)

