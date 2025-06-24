# SEEG Application

This document outlines the process for applying the OCD model to SEEG data in the SEEG_DBS project.

## Execution Order

Please run the scripts in the following order:

1. **seeg_similarity_nn.m** - Calculate similarity metrics for SEEG data
2. **seeg_sccorr.py** - Process structural connectivity correlations
3. **seeg_fccorr.py** - Process functional connectivity correlations
4. **seeg_predict_nn.m** - Generate predictions from processed data
