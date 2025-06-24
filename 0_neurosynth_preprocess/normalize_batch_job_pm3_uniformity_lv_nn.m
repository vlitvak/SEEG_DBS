%-----------------------------------------------------------------------
% Job saved on 16-Dec-2023 20:00:30 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7487)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
%% map list
map_list=[
"addiction_uniformity-test_z_FDR_0.01.nii",
"adhd_uniformity-test_z_FDR_0.01.nii",
"anxiety_uniformity-test_z_FDR_0.01.nii",
"bipolar_uniformity-test_z_FDR_0.01.nii",
"reward_uniformity-test_z_FDR_0.01.nii",
"psychotic_uniformity-test_z_FDR_0.01.nii",
"finger movements_uniformity-test_z_FDR_0.01.nii",
"compulsive_uniformity-test_z_FDR_0.01.nii",
"obsessive_uniformity-test_z_FDR_0.01.nii",
"ocd_uniformity-test_z_FDR_0.01.nii",
"depression_uniformity-test_z_FDR_0.01.nii",
"major depression_uniformity-test_z_FDR_0.01.nii",
"posttraumatic_uniformity-test_z_FDR_0.01.nii",
"ptsd_uniformity-test_z_FDR_0.01.nii",
"speech production_uniformity-test_z_FDR_0.01.nii",
"cognitive control_uniformity-test_z_FDR_0.01.nii"
];
for k=1:length(map_list)
matlabbatch{k}.spm.spatial.normalise.write.subj.def = {'/Users/haeunsun/Documents/MATLAB/leaddbs-develop/templates/space/MNI152NLin2009bAsym/suit/y_avg152T1.nii'};
matlabbatch{k}.spm.spatial.normalise.write.subj.resample =cellstr(['/Volumes/WD_BLACK/FIL_data/send1/psychiatric map_raw/', char(map_list(k))]);
matlabbatch{k}.spm.spatial.normalise.write.woptions.bb = [-90 -126 -72
                                                          90 90 108];
matlabbatch{k}.spm.spatial.normalise.write.woptions.vox = [2 2 2];
matlabbatch{k}.spm.spatial.normalise.write.woptions.interp = 0;
matlabbatch{k}.spm.spatial.normalise.write.woptions.prefix = 'wnn';
end
