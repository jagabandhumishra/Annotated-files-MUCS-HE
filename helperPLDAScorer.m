function score = helperPLDAScorer(a,b,classifier)
% This function is only for use in this example. It may be changed or
% removed in a future release.
score = audio.internal.ivector.score(b',a',classifier.PLDA);
end
