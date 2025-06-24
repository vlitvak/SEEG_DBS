%%
% LOOCV analysis and model construction from entire cohort of OCD dataset.
% Acquisition of ppv,npv,specificity, sensitivity of the model and
% threshold.
load('coeff_sc_dot_ocd_uniform.mat');
load('coeff_fc_kendall.mat');
load('coeff_sc_kendall.mat');
load('improvement.mat');
coeff_sc_kendall(isnan(coeff_sc_kendall))=0;
coeff_fc_kendall(isnan(coeff_fc_kendall))=0;

for i=1:11
coeff_fc=coeff_fc_kendall(:,i)*mean(coeff_sc_kendall)./mean(coeff_fc_kendall);
coeff_scoverlap=coeff_sc_dot_ocd_uniform(:,i)*mean(coeff_sc_kendall)./mean(coeff_scoverlap);
coeff_sccorr=coeff_sc_kendall(:,i);
for j=1:80
X1_train=[coeff_sccorr(1:j-1); coeff_sccorr(j+1:end)];
X2_train=[coeff_scoverlap(1:j-1); coeff_scoverlap(j+1:end)];
X3_train=[coeff_fc(1:j-1); coeff_fc(j+1:end)];

Y_train=[improvement(1:j-1); improvement(j+1:end)];
X1_test=coeff_sccorr(j);
X2_test=coeff_scoverlap(j);
X3_test=coeff_fc(j);
Y_test=improvement(j);
[betaloocv(j,:),interceptloocv(j)]=mvregress([X1_train,X2_train,X3_train],Y_train,'algorithm','mvn');
predict_loocv(j,i)=betaloocv(j,1)*X1_test+betaloocv(j,2)*X2_test+betaloocv(j,2)*X3_test+interceptloocv(j);
end
[beta(i,:),intercept(i)]=mvregress([coeff_sccorr,coeff_scoverlap,coeff_fc],improvement,'algorithm','mvn');
predict(:,i)=beta(i,1)*coeff_sccorr+beta(i,2)*coeff_scoverlap+beta(i,3)*coeff_fc+intercept(i);
[r_loocv(i),p_loocv(i)]=corr(predict_loocv(:,i),improvement);
[r(i),p(i)]=corr(predict(:,i),improvement);
end
save('sccorr_scoverlap_fccorr_model','predict','predict_loocv','beta','intercept','betaloocv','interceptloocv');

%%
bestThreshold = find_best_threshold(predict(4,:), improvement>0);
threshold=bestThreshold;
for i=1:11
    coeff_fc=coeff_fc_kendall(:,i)*mean(coeff_sc_kendall)./mean(coeff_fc_kendall);
    coeff_scoverlap=coeff_sc_dot_ocd_uniform(:,i)*mean(coeff_sc_kendall)./mean(coeff_scoverlap);
    coeff_sccorr=coeff_sc_kendall(:,i);
    predict=beta(4,1)*coeff_sccorr+beta(4,2)*coeff_scoverlap+beta(4,3)*coeff_fc+intercept(4);
    [r(i),p(i)]=corr(predict,improvement);
    portion(i)=sum(predict>threshold)/80;
end


figure; bar(portion*100);
set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11],'XTickLabel',...
{'Speech production','Finger movement','Reward dysfunction','OCD','Addiction','Anxiety','Depression','Bipolar disorder','ADHD','PTSD','Psychosis'});

%%
x1 = improvement(predict(:,7)<bestThreshold);
x2 = improvement(predict(:,7)>=bestThreshold);
x = [x1; x2];
g = [zeros(length(x1), 1); ones(length(x2), 1)];
figure; boxplot(x, g)
%%
sensitivity=sum(improvement(predict(:,4)>threshold)>0)/sum(improvement>0)
specificity=sum(improvement(predict(:,4)<=threshold)<=0)/sum(improvement<=0)
ppv=sum(predict(improvement>0,4)>threshold)/sum(predict(:,4)>threshold)
npv=sum(predict(improvement<=0,4)<=threshold)/sum(predict(:,4)<=threshold)
