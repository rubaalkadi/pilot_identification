%% Prepare Sequence data for LSTM 
% clear all 
% 
% load('RandomPilot.mat')

function [XTrain,YTrain]=breakSamplesSlidingWindow(RandomPilot_Copy,desiredNoOfSamples,second,authorized)
NumberOfPilots=size(RandomPilot_Copy,2);
 Fs = 1/0.1;
 

  clear   NumOfObservations
   clear  Xtrain Ytrain;
ws=Fs*second;% window size 
for p=1:NumberOfPilots
    RandomPilot_Copy{p}=RandomPilot_Copy{p}';

FeatureNum=size(RandomPilot_Copy{p},1);
 

FeatureLength=size(RandomPilot_Copy{p},2);
overlap=ceil((FeatureLength-ws)/(desiredNoOfSamples-1));
NumOfObservations(p)=floor((FeatureLength-(ws)+overlap)/overlap); % number of samples in the 
 
for i=  1:NumOfObservations(p)                                            
  xx=0; 
if p~=1
    xx=sum(NumOfObservations(1:end-1));
end


    y = RandomPilot_Copy{p}(1:FeatureNum,(i-1)*overlap+1:(i-1)*overlap+ws);

sequencelength=size(y,2);
Xtrain{i+xx}(1:FeatureNum,1:sequencelength)=y;
Ytrain(i+xx)=authorized;

 
end 

% labels=[];
% labels(1,1:datapoints)=ones();
% for l=2:20
%     fl=(l-1)*datapoints+1;
%     labels(1,fl:datapoints-1+fl)=l.*ones();
% 
% end 
% freqResp(FeatureNum+ 1,:)=labels;
end 

XTrain=Xtrain';

YTrain=categorical(Ytrain');


end 
