% List of open inputs
nrun = 1; % enter the number of runs here
jobfile = {'normalize_batch_job_pm3_uniformity_lv_nn.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'PET');
spm_jobman('run', jobs, inputs{:});
