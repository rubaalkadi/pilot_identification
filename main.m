%% read all the session from each pilot
% clear all 
InputDir='C:\Users\ruba.alkadi\Dropbox\C2PS Project\Data_shifted here on March 1-2021\Data December 2017\all';
pilotdir=dir(InputDir); 
pilots={pilotdir(3:end).name}; % three folders of data  
numberOfPilots= length(pilots);
sec=9;
for n=1:numberOfPilots
    % access pilot foldr 
    pilotFolder=[InputDir '\' pilots{n}];
    cd(pilotFolder);
    % find sessions 
    sessions=dir(pilotFolder);
    sessionsNames={sessions(3:end).name};
    sessionsCount=length(sessionsNames);
    % Read each excel sheet session into a cell array
    for s=1:sessionsCount
        session{s}=xlsread(sessionsNames{s});
        
        % remove date and time 
        if size(session{s},2)==22
            session{s}(:,1:3)=[];
        elseif size(session{s},2)==21
            session{s}(:,1:2)=[];
        end
    end
        if n==1 % legitimate user
            legitimateSessions=session;
        end
            
    PilotsAllSessions{n}=cell2mat(session');
    clear session
    cd .. 
end 

%% %% %% take one intruder out
for intruder=numberOfPilots:-1:2
    legitimateSessions_copy=legitimateSessions;
    PilotsAllSessions_copy=PilotsAllSessions;
    Intruder_testing=PilotsAllSessions_copy{intruder};

%% %% %% take one session of the ligitimate user out for testing 
% AS is the legitiate user 
[legitimateSession_testing, legitimateSession_testingIdx]=findLongestSession(legitimateSessions_copy);
Testing1Samples=breakSamplesSlidingWindow({legitimateSession_testing},1000,sec,1);
Testing0Samples=breakSamplesSlidingWindow({Intruder_testing},1000,sec,0);
allTesting=[Testing1Samples; Testing0Samples];
label_testing= [ones(length(Testing1Samples),1); zeros(length(Testing0Samples),1)]; 
% shuffle 
shuffleIdx_test=randperm(length(allTesting));
allTesting=allTesting(shuffleIdx_test);
label_testing=label_testing(shuffleIdx_test);
%% %% %% divide the rest of the sessions into training and validation 
% remove the testing sessions from the training/validation set 
PilotsAllSessions_copy(intruder)=[];
legitimateSessions_copy(legitimateSession_testingIdx)=[];

% make the sequences samples of 1 sec 
%% Use function breaksampleslidingwindow instead
% for i=1:19 % for each pilot
%     % divide flights lS=length(PilotsAllSessions{i}); j=1; while
%     (lS-sec)>=0 % take every x sec as an observation
%        if i==1 % legitimate user
%         legitimateUser_trVal{j,1}=PilotsAllSessions{i}(1:sec,:)';
%        else
%         PilotsDivided{j,i-1}=PilotsAllSessions{i}(1:sec,:)';
%        end
%         PilotsAllSessions{i}(1:sec,:)=[]; % remove the taken sec from the
%         original vector lS=lS-sec; j=j+1;
%     end
%         
%  end
legitimateUser_trVal=breakSamplesSlidingWindow(legitimateSessions_copy,1000,sec,1);
PilotsDivided=breakSamplesSlidingWindow(PilotsAllSessions_copy(2:end),1000,sec,0);
%% prepare the training validation sets 
PilotsDivided=reshape(PilotsDivided,[size(PilotsDivided,1)*size(PilotsDivided,2) 1]);
PilotsDivided=shuffle(PilotsDivided);
legitimateUser_trVal=shuffle(legitimateUser_trVal); % shuffle

% take 0.9 from pilotsDivideds
numberOf0samples=0.9*length(PilotsDivided);
Training0samples=PilotsDivided(1:numberOf0samples);
Validation0Samples=PilotsDivided(numberOf0samples+1:end);


% take 0.9 from legitimate User
numberOf1samples=floor(0.9*length(legitimateUser_trVal));
Training1Samples=legitimateUser_trVal(1:numberOf1samples);
Validation1Samples=legitimateUser_trVal(numberOf1samples+1:end);

% concatenate training and labels then shuffle
AllTrainingSamples=[Training1Samples; Training0samples];
labels_training=[ones(size(Training1Samples,1),1); zeros(size(Training0samples,1),1)] ;
 % shuffle 
 Shuffled_Idxs=randperm(length(AllTrainingSamples));
 AllTrainingSamples=AllTrainingSamples(Shuffled_Idxs);
 labels_training=labels_training(Shuffled_Idxs);
 
 % concatenate validation and labels then shuffle
AllValidationSamples=[Validation1Samples; Validation0Samples];
labels_Validation=[ones(size(Validation1Samples,1),1); zeros(size(Validation0Samples,1),1)] ;
 % shuffle 
 Shuffled_Idxs_v=randperm(length(AllValidationSamples));
 AllValidationSamples=AllValidationSamples(Shuffled_Idxs_v);
 labels_Validation=labels_Validation(Shuffled_Idxs_v);


 
%% %% %% train validate and test 

XTrain=AllTrainingSamples;
YTrain=categorical(labels_training);
XValidation=AllValidationSamples;
YValidation=categorical(labels_Validation);
numFeatures = size(XTrain{1},1);
nhu=100;
numHiddenUnits = nhu;
numClasses = 2;
classWeights = [1-length(Training0samples)/(length(Training0samples)+length(Training1Samples)) ...
    length(Training0samples)/(length(Training0samples)+length(Training1Samples))];
% YTrain=reordercats(YTrain,categories(YValidation));
layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
   classificationLayer];


miniBatchSize = 1024;

options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'MaxEpochs',10, ...
    'Shuffle','every-epoch',...
    'MiniBatchSize',miniBatchSize, ...
    'ValidationData',{XValidation,YValidation}, ...
    'ValidationFrequency',10,...
    'GradientThreshold',2, ...
    'Shuffle','every-epoch', ...
    'Verbose',true, ...
    'InitialLearnRate',0.0015,...
    'Plots','training-progress' ... 
    );
net = trainNetwork(XTrain,YTrain,layers,options);
YPred{21-intruder} = classify(net,allTesting,'MiniBatchSize',miniBatchSize);
lbl_testing{21-intruder}=label_testing;
acc(21-intruder) = mean(YPred{21-intruder} == categorical(label_testing));

%% %% %% repeat again by another intruder 
end 
 % convert YPred to doubl 
 for k=1:19
    YPredd{k}=double(YPred{k})-1; 
 end
all_label_all_tests=cell2mat(lbl_testing');
all_pred_all_tests=cell2mat(YPredd');
TP=sum(bitand((all_label_all_tests==all_pred_all_tests) , (all_label_all_tests==1)));%11
TN=sum(bitand((all_label_all_tests==all_pred_all_tests),(all_label_all_tests==0)));%00
FP=sum(bitand((all_label_all_tests~=all_pred_all_tests),(all_label_all_tests==0)));%01
FN=sum(bitand((all_label_all_tests~=all_pred_all_tests),(all_label_all_tests==1)));%00
FAR=FP/(FP+TN);
Recall=TP/(TP+FN);
Precision=TP/(TP+FP);
F1_score=2*(Precision*Recall)/(Precision+Recall);
FRR=FN/(FN+TP);

function [longestsession,longestsessionIdx]=findLongestSession(session)
    l=numel(session);
    for k=1:l
        lengthofsession(k)=size(session{k},1);
    end 
    [longestsessionlength,longestsessionIdx]=max(lengthofsession);
    longestsession=session{longestsessionIdx};
end 