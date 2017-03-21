% This is just a demonstration for Contrastive Divergence
% Contrastive Divergence is used in Product of Expert in order to estimate
% the parameters of models(also called as experts)

% Considering two gaussian distributions with mean and std as follows
mu1 = 1;
sig1 = 1.5;
mu2 = 3;
sig2 = 3;

% A third distribution which is product of the two distributions is
% PROPTIONAL to Gaussian with mean and stdev given by following relation 

mu = (mu1*sig2^2 + mu2*sig1^2)/(sig1^2 + sig2^2);
sig = (sig1^2 * sig2^2)/(sig1^2 + sig2^2);

% ~~~~~~~~~~~ Plotting ~~~~~~~~~~~~~~~
x = -4:.1:6;
pdf1 = normpdf(x, mu1, sig1);
pdf2 = normpdf(x, mu2, sig2);

figure;
plot(x, pdf1, 'r'); hold on
plot(x, pdf2, 'g') 
legend({'Distribution1', 'Distribution2'})

pdfR = normpdf(x, mu, sig);
figure;
plot(x, pdf, 'k');
legend('Dist1*Dist2')
% -x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-

X = normrnd(mu, sig, [1000,1]);

delg_mu1 = (XX - mu1_guess)/sig1_guess^2;
delg_mu2 = (XX - mu2_guess)/sig2_guess^2;

delg_sig1 = (XX - mu1_guess)^2/sig1_guess^3;
delg_sig2 = (XX - mu2_guess)^2/sig2_guess^3;


% parameters = [mean1 mean2 sigma1 sigma2]

param = [3.5 5 2.5 4.5];








