# OCD Model Construction

This document outlines the necessary steps for constructing the OCD model for the SEEG_DBS project.

## Execution Order

Please run the scripts in the following order:

1. **ocd_sc_similarity_nn.m** - Calculate structural connectivity similarity
2. **ocd_fc_similarity_nn.m** - Calculate functional connectivity similarity
3. **ocd_sc_kendall_nn.py** - Perform Kendall correlation analysis for SC
4. **ocd_fc_kendall_nn.py** - Perform Kendall correlation analysis for FC
5. **ocd_loocv_model_nn.m** - Leave-one-out cross-validation model

