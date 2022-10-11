%テストデータの読み込み
test_data = imageDatastore(dataset_path, ...
	         'IncludeSubfolders',true, ...
		     'LabelSource','foldernames');

model = 

YPred = classify(model, test_data);
YValidation = imdsValidation.Labels;
accuracy(1) = mean(YPred == YValidation);

model = 

YPred = classify(model, test_data);
YValidation = imdsValidation.Labels;
accuracy(2) = mean(YPred == YValidation);


model = 

YPred = classify(model, test_data);
YValidation = imdsValidation.Labels;
accuracy(3) = mean(YPred == YValidation);

model = 

YPred = classify(model, test_data);
YValidation = imdsValidation.Labels;
accuracy(4) = mean(YPred == YValidation);


model = 

YPred = classify(model, test_data);
YValidation = imdsValidation.Labels;
accuracy(5) = mean(YPred == YValidation);

accuracy_mean = 0;
for i = 1:5
    accuracy_mean = accuracy_mean + accuracy(i);
end



print("[model名]" + ":" + accuracy_mean / 5);
