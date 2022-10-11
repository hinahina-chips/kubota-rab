function blocks_hidden()
clear all; close all;
%dbstop 45
    %parameta---------------------------------------
        global ep 
        global insize 
        global f_cpu 
        global poolsize 
        global n 
        global channel 
        global convsize 
        global x_v
        global conv_f_stride
        global pool_f_stride
        global dataset_path
        global imds
    %------------------------------------------------

            
        %------グローバル変数の初期値---------
        ep = 80;
        insize = 128;
        f_cpu = 'gpu';%GPUを使う
        poolsize = 3;%プーリング層のフィルタの大きさ
        n = 5; %繰り返す回数
        convsize = 3;%conv層のフィルタの大きさ
        %-----------------------------------
        
        %----------------------------------- 
    
	    %データの読み込み
        dataset_path = [pwd, '\resize_dataset'];
        
	    imds = imageDatastore(dataset_path, ...
	            'IncludeSubfolders',true, ...
		        'LabelSource','foldernames');

        w = insize;%inputsizeの幅
        h = insize;%inputsizeの高さ
        for i=1:n
            tic;
            rng(i);	%乱数ｼｰﾄﾞの設定[rng(n)(n:正の整数)は乱数ｼｰﾄﾞをnに設定する]
	        numTrainFiles = 0.7;
	        [imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');
            
          
	        aug_imdsTrain = augmentedImageDatastore([w h], imdsTrain);%画像ｻｲｽﾞの変更('OutputSizeMode', 'resize'(default)が使われることで,bilinear interpolation(行,列に関する線形補間)が行われる)
	        aug_imdsValidation = augmentedImageDatastore([w h], imdsValidation);		%
        
	        %ネットワーク アーキテクチャの定義
	        inputSize = [w h 3];	%ｶﾗｰ画像なので,inputSizeの3番目の要素は3にする
	        
	        numClasses = 8;
	        
	       
       layers= [
	        imageInputLayer(inputSize)
	        convolution2dLayer(convsize, 8,'padding','same','WeightsInitializer','he')	
            batchNormalizationLayer
            leakyReluLayer(0.1)
            maxPooling2dLayer(poolsize,"Stride",poolsize)
            convolution2dLayer(convsize, 16,'padding','same','WeightsInitializer','he')	
            batchNormalizationLayer
            leakyReluLayer(0.1)
            convolution2dLayer(1,8,'padding','same','WeightsInitializer','he')
            batchNormalizationLayer
            leakyReluLayer(0.1)
            convolution2dLayer(convsize,16,'padding','same','WeightsInitializer','he')
            batchNormalizationLayer
            leakyReluLayer(0.1)
            maxPooling2dLayer(poolsize,"Stride",poolsize)
            convolution2dLayer(convsize,32,'padding','same','WeightsInitializer','he')
            batchNormalizationLayer
            leakyReluLayer(0.1)
            convolution2dLayer(1,16,'padding','same','WeightsInitializer','he')
            batchNormalizationLayer
            leakyReluLayer(0.1)
            convolution2dLayer(convsize,32,'padding','same','WeightsInitializer','he')
            batchNormalizationLayer
            leakyReluLayer(0.1)
            convolution2dLayer(1,16,'padding','same','WeightsInitializer','he')
            batchNormalizationLayer
            leakyReluLayer(0.1)
            convolution2dLayer(convsize,32,'padding','same','WeightsInitializer','he')
            batchNormalizationLayer
            leakyReluLayer(0.1)
            convolution2dLayer(1,numClasses,'padding','same','WeightsInitializer','he')
            globalAveragePooling2dLayer
	        softmaxLayer
	        classificationLayer];

           

          

	        %ネットワークの学習
	        options = trainingOptions('sgdm', ...
		        'MaxEpochs',ep, ...
                'L2Regularization',0.001,...
		        'ValidationData',aug_imdsValidation, ...  %元のﾌｧｲﾙは'ValidationData',imdsValidation, ...(ここで,画像ｻｲｽﾞを変更したaug_imdsValidationを検証ﾃﾞｰﾀに使用する
		        'ValidationFrequency',2, ...
                'ExecutionEnvironment', f_cpu, ...
		        'Verbose',false, ...
                'Plots','none',...
                'InitialLearnRate', 0.2,...
                'Minibatchsize',200,...
                'OutputFcn', @(info)dispPerEpoch(info));
		        
	        [net, info] = trainNetwork(aug_imdsTrain, layers, options);	
            save('plot_info_data.mat', 'info');
            save("hidden_datasetmodel/save_blocks"+str(i)+ ".mat", 'net');
            plot_process();
        end
        
        
        
    

function dispPerEpoch(info)
    fprintf('epoch_progress...\n');
    

function plot_process()
    file_name = 'plot_info_data.mat';
    
    %trainNetworkの出力であるinfo構造体のみを出力したmatファイルを指定
    S = load(file_name);

    %プロットレイアウトの指定
    figure
    tiledlayout(2, 1);

    %精度のプロット
    x_v1 = 1:length(S.info.TrainingAccuracy);
    y_v1 = S.info.TrainingAccuracy;
    x_v1s = x_v1(~isnan(y_v1));
    y_v1s = y_v1(~isnan(y_v1));

    x_v2 = 1:length(S.info.ValidationAccuracy);
    y_v2 = S.info.ValidationAccuracy;
    x_v2s = x_v2(~isnan(y_v2));
    y_v2s = y_v2(~isnan(y_v2));

    y_v1i = interp1(x_v1s, y_v1s, x_v1, 'linear');
    y_v2i = interp1(x_v2s, y_v2s, x_v2, 'Linear');

    nexttile
    grid on;

    xlabel('反復');
    ylabel('精度');
    hold on;
    plot(x_v1, y_v1i,'b-')
    plot(x_v2, y_v2i,'k--.')
    hold off;

    %損失のプロット
    x_v3 = 1:length(S.info.TrainingLoss);
    y_v3 = S.info.TrainingLoss;
    x_v3s = x_v3(~isnan(y_v3));
    y_v3s = y_v3(~isnan(y_v3));

    x_v4 = 1:length(S.info.ValidationLoss);
    y_v4 = S.info.ValidationLoss;
    x_v4s = x_v4(~isnan(y_v4));
    y_v4s = y_v4(~isnan(y_v4));

    y_v3i = interp1(x_v3s, y_v3s, x_v3, 'linear');
    y_v4i = interp1(x_v4s, y_v4s, x_v4, 'Linear');

    nexttile
    grid on;

    xlabel('反復');
    ylabel('損失');

    hold on;
    plot(x_v3, y_v3i,'r-')
    plot(x_v4, y_v4i,'k--.')
    hold off;
