% This is just a demonstration for Contrastive Divergence
% Contrastive Divergence is used in Product of Expert in order to estimate
% the parameters of models(also called as experts)

% Considering two gaussian distributions with mean and std as follows
clear; close all;
mu1 = 1;
sig1 = 1.5;
mu2 = 3;
sig2 = 3;

% A third distribution which is product of the two distributions is
% PROPTIONAL to Gaussian with mean and stdev given by following relation 

mu_R = (mu1*sig2^2 + mu2*sig1^2)/(sig1^2 + sig2^2);
sig_R = (sig1^2 * sig2^2)/(sig1^2 + sig2^2);

% ~~~~~~~~~~~ Plotting ~~~~~~~~~~~~~~~
t = -4:.1:6;
pdf1 = normpdf(t, mu1, sig1);
pdf2 = normpdf(t, mu2, sig2);

figure;
plot(t, pdf1, 'r'); hold on
plot(t, pdf2, 'g') 
legend({'Distribution1', 'Distribution2'})

pdfR = normpdf(t, mu_R, sig_R);
figure;
plot(t, pdfR, 'k');
legend('Dist1*Dist2')

% -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-

X = normrnd(mu_R, sig_R, [1000,1]);

% parameters = [mean1 mean2 sigma1 sigma2]

param0 = [3.5, 5, 2.5, 4.5];
deltaParam = 0.005;
temp_param = param0;

for i = 1:100
    deriv_wrtParam = Cont_Derig_Derivatives(X, temp_param);

    jumpin_sigma = .05;
    Xprime = normrnd(X, jumpin_sigma);
    
    % M-H sampling
    
    logliklihood_X = sum(-(X-temp_param(1)).^2/temp_param(3)^2) + ...
                     sum(-(X-temp_param(2)).^2/temp_param(4)^2);
    
    logliklihood_Xprime = sum(-(Xprime-temp_param(1)).^2/temp_param(3)^2)+...
                          sum(-(Xprime-temp_param(2)).^2/temp_param(4)^2);
        
    CompareLikli = logliklihood_Xprime - logliklihood_X;
    f = min(0, CompareLikli);
    r = rand;
    if f>r
        deriv_wrtParamPrime = Cont_Derig_Derivatives(Xprime, temp_param);
        temp_param(i+1,:) = temp_param + deltaParam*(deriv_wrtParam-deriv_wrtParamPrime);
    end
end


