clc;
clear all;
close all;
%% 

[audioIn,fs] = audioread('exampleconversation.flac');
load('exampleconversationlabels.mat')
audioIn = audioIn./max(abs(audioIn));
%sound(audioIn,fs)

plot(audioIn)
%%
load('xvectorSystem.mat')
%% feature extraction (25 msec with 5 msec as shift)
features = single((extract(afe,audioIn)-factors.Mean)./factors.STD);

%Analysis window length
featureVectorHopDur = (numel(afe.Window) - afe.OverlapLength)/afe.SampleRate;
segmentDur=2;
segmentHopDur=0.1;

segmentLength = round(segmentDur/featureVectorHopDur);
segmentHop = round(segmentHopDur/featureVectorHopDur);

idx=1:segmentLength;
featuresSegmented = [];

while idx(end) < size(features,1)
    
  featuresSegmented=cat(3,featuresSegmented,features(idx,:)) ; 
  idx=idx+segmentHop;
end

%% X-vector extraction

outputLayer=7;
xvecs = zeros(numel(extractor.Parameters.("fc"+outputLayer).Bias),size(featuresSegmented,3));
%%
for sample = 1:size(featuresSegmented,3)
    dlX = dlarray(featuresSegmented(:,:,sample),'SCB');
    xvecs(:,sample) = extractdata(xvecModel(dlX,extractor.Parameters,extractor.State,'DoTraining',false,'OutputLayer',outputLayer));
end
%% LDA projection

x= classifier.projMat*xvecs;

%% Clustering

knownNumberOfSpeakers = numel(unique(groundTruth.Label));
maxclusters = knownNumberOfSpeakers + 1;

[T,Z] = clusterdata(x','Criterion','distance','distance',@(a,b)helperPLDAScorer(a,b,classifier),'linkage','average','maxclust',maxclusters);
%p=322; %no of leaf node needs to be shown
%dendrogram(Z,p), check the dendogram
%% 

mask = zeros(size(audioIn,1),1);
start = round((segmentDur/2)*fs);

segmentHopSamples = round(segmentHopDur*fs);


mask(1:start) = T(1);
start = start + 1;
for ii = 1:numel(T)
    finish = start + segmentHopSamples;
    mask(start:start + segmentHopSamples) = T(ii);
    start = finish + 1;
end
mask(finish:end) = T(end);

%% VAD Masking

mergeDuration = 0.5;
VADidx = detectSpeech(audioIn,fs,'MergeDistance',fs*mergeDuration);

VADmask = sigroi2binmask(VADidx,numel(audioIn));

mask=mask.*VADmask;
%% each vad regions can be expected to be spoken by single speaker
maskLabels = zeros(size(VADidx,1),1);
for ii = 1:size(VADidx,1)
    maskLabels(ii) = mode(mask(VADidx(ii,1):VADidx(ii,2)),'all');
    mask(VADidx(ii,1):VADidx(ii,2)) = maskLabels(ii);
end

%% plot the signal along with labels
pred_tab=table(VADidx,categorical(maskLabels));
msk=signalMask(table(VADidx,categorical(maskLabels)));
plotsigroi(msk,audioIn)
trueLabel = groundTruth.Label;
for ii = 1:numel(trueLabel)  
    text(VADidx(ii,1),1.1,trueLabel(ii),'FontWeight','bold')
end
%% Evaluation measure

uniqueLabels = unique(trueLabel);
guessLabels = maskLabels;
uniqueGuessLabels = unique(guessLabels);
%%
totalNumErrors = 0;

for ii = 1:numel(uniqueLabels)
    isSpeaker = uniqueLabels(ii)==trueLabel;
    minNumErrors = inf;
    
    for jj = 1:numel(uniqueGuessLabels)
        groupCandidate = uniqueGuessLabels(jj) == guessLabels;
        numErrors = nnz(isSpeaker-groupCandidate);
        if numErrors < minNumErrors
            minNumErrors = numErrors;
            bestCandidate = jj;
        end
        minNumErrors = min(minNumErrors,numErrors);
    end
    uniqueGuessLabels(bestCandidate) = [];
    totalNumErrors = totalNumErrors + minNumErrors;
end
SpeakerErrorRate = totalNumErrors/numel(trueLabel)
