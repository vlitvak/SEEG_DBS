function bestThreshold = find_best_threshold(scores, labels, ppv_target, specificity_min)
    if nargin < 3
        ppv_target = 0.9;
    end
    if nargin < 4
        specificity_min = 0.85;
    end

    thresholds = linspace(0.001, 1, 1000);
    bestThreshold = NaN;
    bestDiff = inf;

    for i = 1:length(thresholds)
        t = thresholds(i);
        preds = scores > t;

        TP = sum(preds == 1 & labels == 1);
        FP = sum(preds == 1 & labels == 0);
        TN = sum(preds == 0 & labels == 0);
        FN = sum(preds == 0 & labels == 1);

        if (TN + FP) == 0
            specificity = 0;
        else
            specificity = TN / (TN + FP);
        end

        if (TP + FP) == 0
            ppv = 0;
        else
            ppv = TP / (TP + FP);
        end

        if specificity > specificity_min
            diff = abs(ppv - ppv_target);
            if diff < bestDiff
                bestDiff = diff;
                bestThreshold = t;
            end
        end
    end
end