%%
%Application of model and getting prediction of effect, number of patients
%to be affected, number of effective electrodes per patient, estimated
%sample size of patients.
%% csv_list
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


%% predict_improvement
load('coeff_a2_dot_ocd_uniform.mat');
load('coeff_fc_kendall.mat');
load('coeff_a2_kendall.mat');
coeff_a2_kendall(isnan(coeff_a2_kendall))=0;
coeff_fc_kendall(isnan(coeff_fc_kendall))=0;
for i=1:length(csv_list)
csv_name=char(csv_list(i));
pt=csv_name(1:3);
load(['coeff_scoverlap_',pt,'.mat']);
load(['coeff_fc_',pt,'.mat']);
load(['coeff_sccorr_',pt,'.mat']);
coeff_scoverlap_pt=coeff_scoverlap_pt*mean(coeff_sc_kendall)./mean(coeff_scoverlap);
coeff_fc_pt=coeff_fc_pt*mean(coeff_sc_kendall)./mean(coeff_fc_kendall);
predict_improvement=4.8402*coeff_sc_pt+1.1396*coeff_scoverlap_pt+1.5060*coeff_fc_pt+0.0763;
save(['predict_',pt,'.mat'],'predict_improvement');
end

%%
figure; subplot(2,1,1); imagesc(predict_improvement);

subplot(2,1,2); imagesc(predict_improvement>bestThreshold);
set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11],'XTickLabel',...
{'Speech production','Finger movement','Reward dysfunction','OCD','Addiction','Anxiety','Depression','Bipolar disorder','ADHD','PTSD','Psychosis'});
%% task most promising

for i=1:length(csv_list)
csv_name=char(csv_list(i));
pt=csv_name(1:3);
load(['predict_',pt,'.mat']);
load(['coeff_sccorr_',pt,'.mat']);
load(['coeff_scoverlap_',pt,'.mat']);
load(['coeff_fc_',pt,'.mat']);

coeff_sc_best(i,:)=max(coeff_sc_pt);
coeff_fc_best(i,:)=max(coeff_fc_pt);
coeff_scoverlap_best(i,:)=max(coeff_scoverlap_pt);
task_best_pt(i,:)=max(predict_improvement);
end
task_best_pt_th=task_best_pt>bestThreshold;
save('task_best_pt_th.mat','task_best_pt_th');
save('task_best_pt.mat','task_best_pt');
%%
figure; subplot(1,3,1); imagesc(coeff_sc_pt); set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11],'XTickLabel',...
{'Speech production','Finger movement','Reward dysfunction','OCD','Addiction','Anxiety','Depression','Bipolar disorder','ADHD','PTSD','Psychosis'}); subplot(1,3,2); imagesc(coeff_scoverlap_pt);set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11],'XTickLabel',...
{'Speech production','Finger movement','Reward dysfunction','OCD','Addiction','Anxiety','Depression','Bipolar disorder','ADHD','PTSD','Psychosis'}); subplot(1,3,3); imagesc(coeff_fc_pt); set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11],'XTickLabel',...
{'Speech production','Finger movement','Reward dysfunction','OCD','Addiction','Anxiety','Depression','Bipolar disorder','ADHD','PTSD','Psychosis'});

%%
figure; subplot(2,1,1); imagesc(task_best_pt_th);
subplot(2,1,2); bar(sum(task_best_pt_th)/86*100);
set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11],'XTickLabel',...
{'Speech production','Finger movement','Reward dysfunction','OCD','Addiction','Anxiety','Depression','Bipolar disorder','ADHD','PTSD','Psychosis'});

%%
for i=1:length(csv_list)
csv_name=char(csv_list(i));
pt=csv_name(1:3);
load(['predict_',pt,'.mat']);

task_best_pt_num(i,:)=sum((predict_improvement)>bestThreshold);
task_best_pt_ratio(i,:)=sum((predict_improvement)>bestThreshold)/size(predict_improvement,1);
end
save('task_best_pt_num.mat',"task_best_pt_num");
save('task_best_pt_ratio.mat',"task_best_pt_ratio")

figure; bar(mean(task_best_pt_num));
set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11],'XTickLabel',...
{'Speech production','Finger movement','Reward dysfunction','OCD','Addiction','Anxiety','Depression','Bipolar disorder','ADHD','PTSD','Psychosis'});
figure; bar(mean(task_best_pt_num(:,1:end)));
hold on; errorbar([1:11],mean(task_best_pt_num(:,1:end)),std(task_best_pt_num(:,1:end)),'.');
set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11],'XTickLabel',...
{'Speech production','Finger movement','Reward dysfunction','OCD','Addiction','Anxiety','Depression','Bipolar disorder','ADHD','PTSD','Psychosis'});

%%
task_best_pt_num_spsize=mean(task_best_pt_num(:,3:end));
task_best_pt_std_spsize=std(task_best_pt_num(:,3:end));
task_best_pt_th_sum=sum(task_best_pt_th(:,3:end))/size(task_best_pt_th,1);
figure; subplot(2,1,1); bar(mean(task_best_pt_num(:,3:end)));
hold on; errorbar([1:9],mean(task_best_pt_num(:,3:end)),std(task_best_pt_num(:,3:end)),'.');
subplot(2,1,2); bar(ceil(29*ones(1,9)./task_best_pt_num_spsize));

max_sp=(29*ones(1,9)./task_best_pt_th_sum);
min_sp=(29*ones(1,9)./(task_best_pt_num_spsize+task_best_pt_std_spsize));
pos=max_sp-ceil(29*ones(1,9)./task_best_pt_num_spsize);
neg=ceil(29*ones(1,9)./task_best_pt_num_spsize)-min_sp;
hold on; errorbar(([1:9]),ceil(29*ones(1,9)./task_best_pt_num_spsize),neg,pos,'.');
set(gca,'XTick',[1 2 3 4 5 6 7 8 9],'XTickLabel',...
{'Reward dysfunction','OCD','Addiction','Anxiety','Depression','Bipolar disorder','ADHD','PTSD','Psychosis'});

