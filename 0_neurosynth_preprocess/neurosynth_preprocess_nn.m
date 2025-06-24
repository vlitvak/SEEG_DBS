%% map list
map_list=[
"addiction_uniformity-test_z_FDR_0.01.nii",
"adhd_uniformity-test_z_FDR_0.01.nii",
"anxiety_uniformity-test_z_FDR_0.01.nii",
"bipolar_uniformity-test_z_FDR_0.01.nii",
"reward_uniformity-test_z_FDR_0.01.nii",
"psychotic_uniformity-test_z_FDR_0.01.nii",
"finger movements_uniformity-test_z_FDR_0.01.nii",
"speech production_uniformity-test_z_FDR_0.01.nii",
"cognitive control_uniformity-test_z_FDR_0.01.nii",
"compulsive_uniformity-test_z_FDR_0.01.nii",
"obsessive_uniformity-test_z_FDR_0.01.nii",
"ocd_uniformity-test_z_FDR_0.01.nii",
"depression_uniformity-test_z_FDR_0.01.nii",
"major depression_uniformity-test_z_FDR_0.01.nii",
"posttraumatic_uniformity-test_z_FDR_0.01.nii",
"ptsd_uniformity-test_z_FDR_0.01.nii"
];
%% normalize
normalize_batch3_uniformity_lv_nn
%%
for i=1:length(map_list)
    task=char(map_list(i));
    map=load_nii(['psychiatric map_raw/wnn', task]);
    rawmap=load_nii(['psychiatric map_raw/', task]);
    map.img=map.img>0;
    save_nii(map,['psychiatric map_corr_nn/', task(1:length(task)-31),'_uniform.nii']);
end
%% map combin list
map_combin_list1=["obsessive","compulsive","ocd"];
map_combin_list2=["posttraumatic","ptsd"];
map_combin_list3=["depression","major depression"];
combin=zeros(91,109,91);
task_list=[];
for i=1:size(map_combin_list1,2)
    task=char(map_combin_list1(i));
    map=load_nii(['psychiatric map_corr_nn/', task,'_uniform.nii']);
    map.img(isnan(map.img))=0;
    map.img(isinf(map.img))=0;
    combin=max(combin,map.img);
    task_list=[task_list,task(1:length(task)),'+'];
end
map.img=combin;
save_nii(map,['psychiatric map_corr_nn/',task_list(1:end-1),'_uniform.nii']);
combin=zeros(91,109,91);
task_list=[];
for i=1:size(map_combin_list2,2)
    task=char(map_combin_list2(i));
    map=load_nii(['psychiatric map_corr_nn/', task,'_uniform.nii']);
    map.img(isnan(map.img))=0;
    map.img(isinf(map.img))=0;
    combin=max(combin,map.img);
    task_list=[task_list,task(1:length(task)),'+'];
end
map.img=combin;
save_nii(map,['psychiatric map_corr_nn/',task_list(1:end-1),'_uniform.nii']);
combin=zeros(91,109,91);
task_list=[];
for i=1:size(map_combin_list3,2)
    task=char(map_combin_list3(i));
    map=load_nii(['psychiatric map_corr_nn/', task,'_uniform.nii']);
    map.img(isnan(map.img))=0;
    map.img(isinf(map.img))=0;
    combin=max(combin,map.img);
    task_list=[task_list,task(1:length(task)),'+'];
end
map.img=combin;
save_nii(map,['psychiatric map_corr_nn/',task_list(1:end-1),'_uniform.nii']);
%% sc_vect
boldmap_list_sc=[
    "speech production_uniform.nii",
    "finger movements_uniform.nii",
    "reward_uniform.nii",
    "obsessive+compulsive+ocd_uniform.nii",
    "addiction_uniform.nii",
    "anxiety_uniform.nii",
    "depression+major depression_uniform.nii",
    "bipolar_uniform.nii",
    "adhd_uniform.nii",
    "posttraumatic+ptsd_uniform.nii",
    "psychotic_uniform.nii"];
for i=1:length(boldmap_list_sc)
map=load_nii(['send1/psychiatric map_corr_nn/', char(boldmap_list_sc(i))]);
gm=load_nii('TPM_gm222_corrorg.nii');
gm.img(isnan(gm.img))=0;
gm.img(isinf(gm.img))=0;
gm_vect=reshape(gm.img,1,[]);
gm_ind=find(gm_vect>0);
map_vect(i,:)=map.img(gm_ind);
end
save('send_fin/boldmap_paper_lv_red_nn/boldmap_list_sc_bin_vect_red','map_vect');
clear map_vect
%% fc_vect
boldmap_list_fc=[
    "speech production_uniform.nii",
    "finger movements_uniform.nii",
    "reward_uniform.nii",
    "obsessive+compulsive+ocd_uniform.nii",
    "addiction_uniform.nii",
    "anxiety_uniform.nii",
    "depression+major depression_uniform.nii",
    "bipolar_uniform.nii",
    "adhd_uniform.nii",
    "posttraumatic+ptsd_uniform.nii",
    "psychotic_uniform.nii"];
for i=1:length(boldmap_list_fc)
map=load_nii(['psychiatric map_corr_nn/', char(boldmap_list_fc(i))]);
gm=load_nii(['TPM_gm222_corrorg_fnc.nii']);
gm.img(isnan(gm.img))=0;
gm.img(isinf(gm.img))=0;
gm_vect=reshape(gm.img,1,[]);
gm_ind=find(gm_vect>0);
map_vect(i,:)=map.img(gm_ind);
end
save('boldmap_paper_lv_red_nn/boldmap_list_fc_bin_vect_red','map_vect'); 