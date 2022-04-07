function L = GMMLogLikelihood(x,gmm)
% customized by jagabandhu mishra

    xMinusMu = repmat(x,1,1,numel(gmm.w)) - permute(gmm.m',[1,3,2]);
    permuteSigma = permute(gmm.v',[1,3,2]);
    
    Lunweighted = -0.5*(sum(log(permuteSigma),1) + sum(xMinusMu.*(xMinusMu./permuteSigma),1) + size(gmm.m',1)*log(2*pi));
    
    temp = squeeze(permute(Lunweighted,[1,3,2]));
    if size(temp,1)==1
        % If there is only one frame, the trailing singleton dimension was
        % removed in the permute. This accounts for that edge case.
        temp = temp';
    end
    
    L = temp + log(gmm.w')';
end