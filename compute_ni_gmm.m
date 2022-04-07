function [Ni]=compute_ni_gmm(x,ubm)

logLikelihood = GMMLogLikelihood(x',ubm);
% Compute a posteriori normalized probability
amax = max(logLikelihood,[],1);
logLikelihoodSum = amax + log(sum(exp(logLikelihood-amax),1));
gamma = exp(logLikelihood - logLikelihoodSum)';
        
% Compute Baum-Welch statistics
n = sum(gamma,1);
%Ni=n./size(x,2);
Ni=n';