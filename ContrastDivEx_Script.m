% Demonstration of Contrastive Divergence
% Contrastive Divergence is used in Product of Expert in order to estimate
% the parameters of individual models(also called as experts)

clear; close all;
maxIter =2*10000;

% Considering two gaussian distributions with mean and std as follows
mu1 = 1;
mu2 = 2;
sig1 = 2;
sig2 = 2.5;

% A third distribution which is product of the two distributions is
% PROPTIONAL to Gaussian with mean and stdev given by following relation 

mu_R = (mu1*sig2^2 + mu2*sig1^2)/(sig1^2 + sig2^2);
sig_R = sqrt((sig1^2 * sig2^2)/(sig1^2 + sig2^2));

% ~~~~~~~~~~~ Plotting ~~~~~~~~~~~~~~~
t = -4:.1:6;
pdf1 = normpdf(t, mu1, sig1);
pdf2 = normpdf(t, mu2, sig2);

% figure;
% plot(t, pdf1, 'r'); hold on
% plot(t, pdf2, 'g') 
% legend({'Distribution1', 'Distribution2'})
% 
% pdfR = normpdf(t, mu_R, sig_R);
% figure;
% plot(t, pdfR, 'k');
% legend('Dist1*Dist2')

% -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-

X = normrnd(mu_R, sig_R, [1000,1]);

% parameters = [mean1 mean2 sigma1 sigma2]

param0 = [.5, 1, 1.75, 4.5];
deltaParam = .1;
temp_param = param0;
s.param = NaN(maxIter,4);
s.param(1,:) = param0;
jumpin_sigma = .1;


for i = 1:maxIter
    deriv_wrtParam = mean(Cont_Derig_Derivatives(X, temp_param));

    X0 = X;
       
    for j = 1:10
    
        Xprime = normrnd(X0, jumpin_sigma);

        % M-H sampling

        logliklihood_X0 = sum(-(X0-temp_param(1)).^2/temp_param(3)^2) + ...
                         sum(-(X0-temp_param(2)).^2/temp_param(4)^2);

        logliklihood_Xprime = sum(-(Xprime-temp_param(1)).^2/temp_param(3)^2)+...
                              sum(-(Xprime-temp_param(2)).^2/temp_param(4)^2);

        CompareLikli = exp(logliklihood_Xprime - logliklihood_X0);
        f = min(1, CompareLikli);
        r = rand;
        if f>r
            X0 = Xprime;
        end
    end
    Xprime = X0;
    deriv_wrtParamPrime = mean(Cont_Derig_Derivatives(Xprime, temp_param));
    temp_param = temp_param + deltaParam*(deriv_wrtParam-deriv_wrtParamPrime);
    s.param(i,:) = temp_param;
end

plot(s.param)
legend({'\mu1', '\mu2', '\sigma1', '\sigma2'})
