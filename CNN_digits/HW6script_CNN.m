%% HW 6 - Deep learning for MNIST Image Classification
% Jodie Simkoff
% December 14, 2017

clear all
rng(4); % - use rng seeds for exact comparisons
for iter = 1:10
load('digits.mat')
clear testLabel testData predictedLabels
[~,~,~,Nt] = size(trainImages);

% pick some training data
num_train = 2000; % num training images
pick_train = randperm(Nt,num_train);
for i = 1:num_train
    trainData(:,:,1,i) = double(trainImages(:,:,1,pick_train(i)));
    trainLabel(i) = categorical(trainLabels(pick_train(i)));
end
trainLabel = trainLabel';

% pick some test data
[~,~,~,Nv] = size(testImages);
num_val = 500;
pick_val = randperm(Nv,num_val);
for i = 1:num_val
    testData(:,:,1,i) = double(testImages(:,:,1,pick_val(i)));
    testLabel(i) = categorical(testLabels(pick_val(i)));
end
testLabel = testLabel';

% plot some images
% figure;
% perm = randperm(num_train,20);
% for i = 1:20
%     subplot(4,5,i);
%     imshow(trainData(:,:,:,i));
%     trainLabel(i);
% end



% CNN Architecture
% modified as indicated for the various scenarios

[s1, s2,~,~] = size(trainData);

layers = [
    imageInputLayer([s1 s2 1])
    
    
    convolution2dLayer(3,16,'Padding',1) 
    batchNormalizationLayer
    reluLayer
    
    % Add additional of the above units for architectures 1-6
    
    maxPooling2dLayer(2,'Stride',2) % change to averagePooling2dLayer for 3d
                        % change filter size as needed for 3a-3c

    
    convolution2dLayer(3,16,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];

% training options
%tic
options = trainingOptions('sgdm',...
    'MaxEpochs',10, ...
    'Verbose',false, 'InitialLearnRate',0.01,...
    'LearnRateSchedule','piecewise',...
    'LearnRateDropFactor',0.8,'LearnRateDropPeriod',1); %,'Plots','training-progress');
    % can modify learn rate and learn rate drop policy

net = trainNetwork(trainData,trainLabel,layers,options);
%toc
predictedLabels = classify(net,testData);
% classify validation data and quantify accurancy
accuracy(iter) = sum(predictedLabels == testLabel)/numel(testLabel);

end
mean(accuracy)