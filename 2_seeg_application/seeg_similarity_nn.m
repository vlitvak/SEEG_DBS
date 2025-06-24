%%
%Construction of Structural and functional connectivity from SEEG electrode
%and acquisition of SC/FC similarity with Neurosynth maps. 
%% csv list
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
"T09_mni_bcb_contacts.csv"
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

%%
%csv_list=flip(csv_list);
%for k=73:length(csv_list)  %53-43 
for k=53
opts = detectImportOptions(['ALL_Patients_contactsDG/',char(csv_list(k))]);
opts.VariableTypes(2)=opts.VariableTypes(1);
T = readtable(['ALL_Patients_contactsDG/',char(csv_list(k))],opts);

oldxyz = [T.x T.y T.z];

oldgifti = [];
oldgifti.vertices = oldxyz;

oldgifti = gifti(oldgifti);
%%

newgifti = spm_swarp(oldgifti, 'y_t1.nii');

newxyz = newgifti.vertices;
T(:,4)=table(newxyz(:,1));
T(:,5)=table(newxyz(:,2));
T(:,6)=table(newxyz(:,3));
%%
pt=cell2mat(table2array(T(1,1)));

mkdir('new/',pt);

for i=43:size(newxyz,1) 
tic
try
elect=cell2mat(table2array(T(i,2)));
chan=char(num2str(table2array(T(i,3))));
chan_pos=table2array(T(i,4:6));
seed_file=['new/',pt,'/',elect,'_',chan,'.nii'];
fun_connectomes_file='GSP 1000 Matrix (Yeo 2011)>Full Set';
str_connectomes_file='HCP_MGH_32fold_groupconnectome (Horn 2017)';
ea_spherical_roi(seed_file,chan_pos, 3.5 , 1,'/Users/haeunsun/Documents/MATLAB/leaddbs-develop/templates/space/MNI152NLin2009bAsym/t1.nii');
ea_autocrop(seed_file);
lead_job(seed_file,fun_connectomes_file,str_connectomes_file);

rmv_file=['new/',pt,'/',elect,'_',chan,'_conn-GSP1000MATxFullSet_desc-AvgRFz_funcmap.nii'];
delete(rmv_file);
toc
catch
    fprintf('Index exceeds the number of array elements. Index must not exceed 0.')
end
end
end
%%
function lead_job(seed_file,fun_connectomes_file,str_connectomes_file)
% - Lead-DBS Job created on 02-Nov-2023 16:03:22 -
% --------------------------------------

lead path;

options = getoptslocal(seed_file,fun_connectomes_file,str_connectomes_file);

ea_run('run', options);

end

%%
function options = getoptslocal(seed_file,fun_connectomes_file,str_connectomes_file);
options.endtolerance = 10;
options.sprungwert = 4;
options.refinesteps = 0;
options.tra_stdfactor = 0.9;
options.cor_stdfactor = 1;
options.earoot = '/Users/haeunsun/Documents/MATLAB/leaddbs-develop/';
options.importdcm.do = 0;
options.importnii.do = 0;
options.normalize.do = 0;
options.normalize.refine = 0;
options.checkreg = 0;
options.coregmr.check = 0;
options.coregmr.do = 0;
options.coregmr.method = '';
options.coregct.do = 0;
options.modality = 1;
options.verbose = 3;
options.sides = [];
options.doreconstruction = 0;
options.autoimprove = 0;
options.axiscontrast = 8;
options.zresolution = 10;
options.atl.genpt = 0;
options.atl.can = 1;
options.atl.pt = 0;
options.atl.ptnative = 0;
options.native = 0;
options.d2.col_overlay = 1;
options.d2.con_overlay = 1;
options.d2.con_color = [1 1 1];
options.d2.lab_overlay = 0;
options.d2.bbsize = 50;
options.d2.backdrop = 'MNI152NLin2009bAsym T1 (Fonov 2011)';
options.d2.fid_overlay = 1;
options.d2.write = 0;
options.d2.atlasopacity = 0.15;
options.refinelocalization = 0;
options.scrf.do = 0;
options.scrf.mask = 'Coarse mask (Schönecker 2008)';
options.d3.write = 0;
options.d3.prolong_electrode = 2;
options.d3.verbose = 'on';
options.d3.elrendering = 1;
options.d3.exportBB = 0;
options.d3.hlactivecontacts = 0;
options.d3.showactivecontacts = 1;
options.d3.showpassivecontacts = 1;
options.d3.showisovolume = 0;
options.d3.isovscloud = 0;
options.d3.mirrorsides = 0;
options.d3.autoserver = 0;
options.d3.expdf = 0;
options.numcontacts = 4;
options.writeoutpm = 0;
options.elmodel = 'Medtronic 3389';
options.expstatvat.do = 0;
options.fiberthresh = 10;
options.writeoutstats = 1;
options.colormap = 'parula(64)';
options.dolc = 0;
options.lcm.seeds = cellstr(seed_file);
%options.lcm.seeds = {'/Users/haeunsun/Documents/MATLAB/test2.nii'};
options.lcm.seeddef = 'manual';
options.lcm.odir = [];
options.lcm.omask = [];
options.lcm.struc.do = 1;
options.lcm.struc.connectome = str_connectomes_file;
%options.lcm.struc.connectome = 'HCP_MGH_32fold_groupconnectome (Horn 2017)';
options.lcm.struc.espace = 1; %resoultion:2mm
options.lcm.func.do = 1;
options.lcm.func.exportgmtc = 0;
options.lcm.func.connectome = fun_connectomes_file;
%options.lcm.func.connectome = 'Tor PD (Loh & Boutet 2020)>Full Set';
options.lcm.cmd = 1;
options.ecog.extractsurface.do = 0;
options.uivatdirs = [];
options.uipatdirs = {''};
options.leadprod = 'mapper';
options.prefs.dev.profile = 'user';
options.prefs.pp.do = 0;
options.prefs.pp.csize = 4;
options.prefs.pp.profile = 'local';
options.prefs.migrate.doDicomConversion = 1;
options.prefs.migrate.DicomConversionTool = 'dcm2niix';
options.prefs.migrate.interactive = 0;
options.prefs.niiFileExt = '.nii';
options.prefs.prenii_searchstring = 'anat_*.nii';
options.prefs.prenii_order = {
                              'T1w'
                              'T2w'
                              'PDw'
                              'T2starw'
                              }';
options.prefs.prenii_unnormalized = 'anat_t2.nii';
options.prefs.prenii_unnormalized_t1 = 'anat_t1.nii';
options.prefs.prenii_unnormalized_pd = 'anat_pd.nii';
options.prefs.tranii_unnormalized = 'postop_tra.nii';
options.prefs.sagnii_unnormalized = 'postop_sag.nii';
options.prefs.cornii_unnormalized = 'postop_cor.nii';
options.prefs.rawctnii_unnormalized = 'postop_ct.nii';
options.prefs.ctnii_coregistered = 'rpostop_ct.nii';
options.prefs.tp_ctnii_coregistered = 'tp_rpostop_ct.nii';
options.prefs.diary = 0;
options.prefs.preferMRCT = 2;
options.prefs.patientdir = '';
options.prefs.gprenii = 'glanat.nii';
options.prefs.gtranii = 'glpostop_tra.nii';
options.prefs.gcornii = 'glpostop_cor.nii';
options.prefs.gsagnii = 'glpostop_sag.nii';
options.prefs.gctnii = 'glpostop_ct.nii';
options.prefs.tp_gctnii = 'tp_glpostop_ct.nii';
options.prefs.bids_session_postop = 'ses-postDBS';
options.prefs.bids_session_preop = 'ses-preDBS';
options.prefs.tonemap = 'heuristic';
options.prefs.rest_searchstring = 'rest*.nii';
options.prefs.rest = 'rest.nii';
options.prefs.lc.struc.maxdist = 2;
options.prefs.lc.struc.minlen = 3;
options.prefs.lc.graphsurfc = [0.2081 0.1663 0.5292];
options.prefs.lc.matsurfc = [0.8 0.7 0.4];
options.prefs.lc.seedsurfc = [0.8 0.1 0.1];
options.prefs.lc.func.regress_global = 1;
options.prefs.lc.func.regress_wmcsf = 1;
options.prefs.lc.func.bphighcutoff = 0.08;
options.prefs.lc.func.bplowcutoff = 0.009;
options.prefs.lc.datadir = '/Users/haeunsun/Documents/MATLAB/leaddbs-develop/connectomes/';
options.prefs.lc.defaultParcellation = 'Automated Anatomical Labeling 3 (Rolls 2020)';
options.prefs.lcm.vatseed = 'binary';
options.prefs.lcm.vat2fmrimethod = 'fsl';
options.prefs.lcm.chunk = 10;
options.prefs.lcm.includesurf = 0;
options.prefs.lcm.struc.patienttracts.nativeseed = 0;
options.prefs.b0 = 'b0.nii';
options.prefs.fa = 'fa.nii';
options.prefs.fa2anat = 'fa2anat.nii';
options.prefs.FTR_unnormalized = 'FTR.mat';
options.prefs.FTR_normalized = 'wFTR.mat';
options.prefs.DTD = 'DTD.mat';
options.prefs.HARDI = 'HARDI.mat';
options.prefs.dti = 'dti.nii';
options.prefs.bval = 'dti.bval';
options.prefs.bvec = 'dti.bvec';
options.prefs.sampledtidicom = 'sample_dti_dicom.dcm';
options.prefs.normmatrix = 'lmat.txt';
options.prefs.normalize.default = 'ANTs (Avants 2008)';
options.prefs.normalize.inverse.warp = 'inverse';
options.prefs.normalize.inverse.customtpm = 0;
options.prefs.normalize.createwarpgrids = 0;
options.prefs.normalize.fsl.warpres = 8;
options.prefs.normalize.spm.resolution = 1;
options.prefs.reco.method.MRI = 'TRAC/CORE (Horn 2015)';
options.prefs.reco.method.CT = 'PaCER (Husch 2017)';
options.prefs.reco.mancoruse = 'postop';
options.prefs.reco.saveACPC = 0;
options.prefs.reco.saveimg = 0;
options.prefs.reco.exportfiducials = '.fcsv';
options.prefs.ctcoreg.default = 'ANTs (Avants 2008)';
options.prefs.mrcoreg.default = 'SPM (Friston 2007)';
options.prefs.mrcoreg.writeoutcoreg = 0;
options.prefs.scrf.tonemap = 'tp_';
options.prefs.lg.defaultParcellation = 'Automated Anatomical Labeling 3 (Rolls 2020)';
options.prefs.hullmethod = 2;
options.prefs.hullsmooth = 5;
options.prefs.hullsimplify = 0.3;
options.prefs.lhullmethod = 2;
options.prefs.lhullsmooth = 3;
options.prefs.lhullsimplify = 'auto';
options.prefs.d2.useprepost = 'pre';
options.prefs.d2.groupcolors = 'lead';
options.prefs.d2.isovolsmoothed = 's';
options.prefs.d2.isovolcolormap = 'jet';
options.prefs.d2.isovolsepcomb = 'combined';
options.prefs.d3.fiberstyle = 'tube';
options.prefs.d3.fiberwidth = 0.2;
options.prefs.d3.maxfibers = 200;
options.prefs.d3.colorjitter = 0;
options.prefs.d3.showdirarrows = 0;
options.prefs.d3.fiber_activated_color = [1 0 0];
options.prefs.d3.fiber_nonactivated_color = [1 1 1];
options.prefs.d3.fiber_damaged_color = [0.5 0 0.5];
options.prefs.d3.fiber_csf_color = [0 0 1];
options.prefs.d3.fiber_outside_color = [0 1 0];
options.prefs.d3.pointcloudstyle = 'plain';
options.prefs.d3.camlightcolor = [0.8 0.8 1];
options.prefs.d3.ceilinglightcolor = [1 0.9 0.9];
options.prefs.d3.rightlightcolor = [1 0.9 0.7];
options.prefs.d3.leftlightcolor = [0.9 0.9 1];
options.prefs.d3.roi.autofillcolor = 1;
options.prefs.d3.roi.defaultcolormap = 'parula';
options.prefs.d3.cortexcolor = [0.65 0.65 0.65];
options.prefs.d3.cortexalpha = 0.5;
options.prefs.d3.cortex_defaultatlas = 'DKT';
options.prefs.d3.fs.dev = 0;
options.prefs.video.path = [-90 10
                            -110 10
                            -180 80
                            -250 10
                            -360 10
                            -450 10];
options.prefs.video.opts.FrameRate = 24;
options.prefs.video.opts.Duration = 30;
options.prefs.video.opts.Periodic = true;
options.prefs.vat.gm = 'mask';
options.prefs.vat.efieldmax = 10000;
options.prefs.mer.rejwin = [1 60];
options.prefs.mer.offset = 2;
options.prefs.mer.length = 24;
options.prefs.mer.markersize = 0.5;
options.prefs.mer.defaulttract = 1;
options.prefs.mer.n_pnts = 50;
options.prefs.mer.tag.visible = 'off';
options.prefs.mer.step_size = [0.25 0.75 0.05];
options.prefs.mer.tract_info(1).label = 'central';
options.prefs.mer.tract_info(1).color = [0.5 0 0];
options.prefs.mer.tract_info(1).position = [0 0 0];
options.prefs.mer.tract_info(2).label = 'anterior';
options.prefs.mer.tract_info(2).color = [0.5 0.5 0];
options.prefs.mer.tract_info(2).position = [0 1 0];
options.prefs.mer.tract_info(3).label = 'posterior';
options.prefs.mer.tract_info(3).color = [0 0.5 0];
options.prefs.mer.tract_info(3).position = [0 -1 0];
options.prefs.mer.tract_info(4).label = 'lateral';
options.prefs.mer.tract_info(4).color = [0.5 0 0.5];
options.prefs.mer.tract_info(4).position = [1 0 0];
options.prefs.mer.tract_info(5).label = 'medial';
options.prefs.mer.tract_info(5).color = [0 0.5 0.5];
options.prefs.mer.tract_info(5).position = [-1 0 0];
options.prefs.fs.dir = '';
options.prefs.fs.reconall.do = 1;
options.prefs.fs.subcorticalseg.do = 1;
options.prefs.fs.subcorticalseg.thalamus = 1;
options.prefs.fs.subcorticalseg.hippo_amygdala = 0;
options.prefs.fs.subcorticalseg.brainstem = 0;
options.prefs.fs.samseg.do = 0;
options.prefs.slicer.dir = '';
options.prefs.dicom.dicomfiles = 0;
options.prefs.dicom.tool = 'dcm2niix';
options.prefs.addfibers = {};
options.prefs.fibfilt.connfibs.showmax = 5000;
options.prefs.fibfilt.connfibs.fiberwidth = 0.04;
options.prefs.fibfilt.connfibs.alpha = 0.4;
options.prefs.fibfilt.connfibs.color = [1 0.99 0.91];
options.prefs.fibfilt.roi.alpha = 0.5;
options.prefs.fibfilt.roi.color = [1 0.99 0.91];
options.prefs.native.warp = 'inverse';
options.prefs.ls.autosave = 0;
options.prefs.ls.dir = '';
options.prefs.env.dev = 0;
options.prefs.env.logtime = 0;
options.prefs.env.campus = 'generic';
options.prefs.ixi.meanage = 60;
options.prefs.ixi.dir = '';
options.prefs.ltx.pdfconverter = '';
options.prefs.genetics.dbdir = '/Users/haeunsun/Documents/MATLAB/leaddbs-develop/templates/space/MNI152NLin2009bAsym/genetics/';
options.prefs.platform.glnxa64.load_shipped_runtime = false;
options.prefs.platform.maci64.load_shipped_runtime = false;
options.prefs.platform.maca64.load_shipped_runtime = false;
options.prefs.platform.win64.load_shipped_runtime = false;
options.prefs.firstrun = 'off';
options.prefs.machine.atlaspresets = struct([]);
options.prefs.machine.checkreg.default = 'DISTAL Minimal (Ewert 2017)@STN';
options.prefs.machine.chirp = 1;
options.prefs.machine.d2.col_overlay = 1;
options.prefs.machine.d2.con_overlay = 1;
options.prefs.machine.d2.con_color = [1 1 1];
options.prefs.machine.d2.lab_overlay = 0;
options.prefs.machine.d2.bbsize = 50;
options.prefs.machine.d2.backdrop = 'MNI152NLin2009bAsym T1 (Fonov 2011)';
options.prefs.machine.d2.fid_overlay = 1;
options.prefs.machine.lc.general.parcellation = 'Automated Anatomical Labeling 3 (Rolls 2020)';
options.prefs.machine.lc.graph.struc_func_sim = 0;
options.prefs.machine.lc.graph.nodal_efficiency = 0;
options.prefs.machine.lc.graph.eigenvector_centrality = 0;
options.prefs.machine.lc.graph.degree_centrality = 0;
options.prefs.machine.lc.graph.fthresh = NaN;
options.prefs.machine.lc.graph.sthresh = NaN;
options.prefs.machine.lc.func.compute_CM = 0;
options.prefs.machine.lc.func.compute_GM = 0;
options.prefs.machine.lc.func.prefs.TR = 2.69;
options.prefs.machine.lc.struc.compute_CM = 0;
options.prefs.machine.lc.struc.compute_GM = 0;
options.prefs.machine.lc.struc.ft.method = 'ea_ft_gqi_yeh';
options.prefs.machine.lc.struc.ft.do = 0;
options.prefs.machine.lc.struc.ft.normalize = 0;
options.prefs.machine.lc.struc.ft.dsistudio.fiber_count = 200000;
options.prefs.machine.lc.struc.ft.upsample.factor = 1;
options.prefs.machine.lc.struc.ft.upsample.how = 0;
options.prefs.machine.lg = struct([]);
options.prefs.machine.methods_show = 1;
options.prefs.machine.normsettings.maget_peerset = 'IXI-Dataset';
options.prefs.machine.normsettings.maget_peersetcell = [];
options.prefs.machine.normsettings.maget_atlasset = 'DISTAL (Ewert 2016)';
options.prefs.machine.normsettings.schoenecker_movim = 1;
options.prefs.machine.normsettings.ants_preset = 'ea_antspreset_effective_lowvar_default';
options.prefs.machine.normsettings.ants_scrf = 1;
options.prefs.machine.normsettings.ants_strategy = 'SyN';
options.prefs.machine.normsettings.ants_metric = 'Mutual Information';
options.prefs.machine.normsettings.ants_numcores = 0;
options.prefs.machine.normsettings.ants_stagesep = 0;
options.prefs.machine.normsettings.fsl_skullstrip = 0;
options.prefs.machine.normsettings.ants_usefa = 0;
options.prefs.machine.normsettings.ants_skullstripped = 0;
options.prefs.machine.normsettings.spmnewseg_scalereg = 1;
options.prefs.machine.normsettings.ants_reinforcetargets = 0;
options.prefs.machine.normsettings.ants_usepreexisting = 1;
options.prefs.machine.space = 'MNI152NLin2009bAsym';
options.prefs.machine.togglestates.cutview = '3d';
options.prefs.machine.togglestates.refreshcuts = 0;
options.prefs.machine.togglestates.refreshview = 0;
options.prefs.machine.togglestates.xyzmm = [-30 -30 -30];
options.prefs.machine.togglestates.xyztoggles = [0 1 1];
options.prefs.machine.togglestates.xyztransparencies = [100 100 100];
options.prefs.machine.togglestates.template = 'MNI152NLin2009bAsym T1 (Fonov 2011)';
options.prefs.machine.togglestates.tinvert = 0;
options.prefs.machine.togglestates.customfile = [];
options.prefs.machine.vatsettings.estimateInTemplate = 0;
options.prefs.machine.vatsettings.oss_dbs.installed = 0;
options.prefs.machine.vatsettings.butenko_ethresh = 0.2;
options.prefs.machine.vatsettings.dembek_pw = 60;
options.prefs.machine.vatsettings.dembek_ethresh = 0.2;
options.prefs.machine.vatsettings.dembek_ethreshpw = 60;
options.prefs.machine.vatsettings.fastfield_cb = 0.1;
options.prefs.machine.vatsettings.fastfield_ethresh = 0.2;
options.prefs.machine.vatsettings.horn_cwm = 0.14;
options.prefs.machine.vatsettings.horn_useatlas = 1;
options.prefs.machine.vatsettings.horn_atlasset = 'DISTAL Minimal (Ewert 2017)';
options.prefs.machine.vatsettings.horn_cgm = 0.33;
options.prefs.machine.vatsettings.horn_ethresh = 0.2;
options.prefs.machine.vatsettings.horn_removeElectrode = 1;
options.prefs.machine.vatsettings.butenko_fiberDiameter = 5.7;
options.prefs.machine.vatsettings.butenko_calcAxonActivation = 0;
options.prefs.machine.vatsettings.butenko_connectome = 'HCP_MGH_32fold_groupconnectome (Horn 2017)';
options.prefs.machine.vatsettings.butenko_axonLength = 10;
options.prefs.machine.vatsettings.butenko_interactive = 0;
options.prefs.machine.vatsettings.butenko_useTensorData = 1;
options.prefs.machine.vatsettings.butenko_tensorFileName = 'IITMeanTensor.nii.gz';
options.prefs.machine.vatsettings.butenko_tensorScalingMethod = 'NormMapping';
options.prefs.machine.view.az = 180;
options.prefs.machine.view.el = 21;
options.prefs.machine.view.camva = 9.25958075788405;
options.prefs.machine.view.camup = [0 0 1];
options.prefs.machine.view.camproj = 'orthographic';
options.prefs.machine.view.camtarget = [-3.15548027321493 -25.2737400702356 -3.64952824374033];
options.prefs.machine.view.campos = [1.66783869745351 432.619292151714 170.751216175643];
options.prefs.machine.defaultatlas = 'DISTAL Minimal (Ewert 2017)';
options.prefs.prenii = 'glanat.nii';
options.prefs.tranii = 'glpostop_tra.nii';
options.prefs.cornii = 'glpostop_cor.nii';
options.prefs.sagnii = 'glpostop_sag.nii';
options.prefs.ctnii = 'glpostop_ct.nii';
options.lc.general.parcellation = 'Automated Anatomical Labeling 3 (Rolls 2020)';
options.lc.graph.struc_func_sim = 0;
options.lc.graph.nodal_efficiency = 0;
options.lc.graph.eigenvector_centrality = 0;
options.lc.graph.degree_centrality = 0;
options.lc.graph.fthresh = NaN;
options.lc.graph.sthresh = NaN;
options.lc.func.compute_CM = 0;
options.lc.func.compute_GM = 0;
options.lc.func.prefs.TR = 2.69;
options.lc.struc.compute_CM = 0;
options.lc.struc.compute_GM = 0;
options.lc.struc.ft.method = 'ea_ft_gqi_yeh';
options.lc.struc.ft.do = 0;
options.lc.struc.ft.normalize = 0;
options.lc.struc.ft.dsistudio.fiber_count = 200000;
options.lc.struc.ft.upsample.factor = 1;
options.lc.struc.ft.upsample.how = 0;
options.exportedJob = 1;

end
