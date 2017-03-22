# Contrastive Divergence
This is a Matlab code demonstrating the approach of Contrastive Divergence for estimating parameters of models/Probabilistic distributions of Product of Expert


Data is generated from a Gaussian distribution which is multiplication of two Gaussian distributions with some mean and standard deviation. Here the purpose is to predict the  means and stds of the two Gaussians.
The original paper discusses about the contrastive divergence is by Hinton and [available here][d4a65028]. A relatively easy to understand version is [available here][1755ad6c].
For two Gaussian distributions $\mu_1, \sigma_1$ and $\mu_2, \sigma_2$, the product is proportional to a Normal Distribution given by mean and standard deviation as follows:
$$\mu = \frac{\mu_1 \sigma_2^2+\mu_2 \sigma_1^2}{\sigma_1^2+ \sigma_2^2}$$

$$\sigma = \left[\frac{ \sigma_1^2 \sigma_2^2}{\sigma_1^2+ \sigma_2^2}\right]^{1/2} $$

In the Matlab code data is generated with above mean and standard deviation and then the four parameters $\mu_1, \sigma_1, \mu_2, \sigma_2$ were estimated.

The function *Cont_Derig_Derivatives.m* calculates the derivative of $log(g)$ where $g = \mathcal N(\mu_1, \sigma_1)\mathcal N(\mu_2, \sigma_2)$

$$log(g) = log(\mathcal N(\mu_1, \sigma_1))+log(\mathcal N(\mu_2, \sigma_2))$$

$$log(g) = \sum log(\mathcal N(\mu_i, \sigma_i))$$

$$log(g) = \sum log(\frac {1}{\sqrt {2\pi } \sigma_i}\;e^{-{\frac {(x-\mu_i )^{2}}{2\sigma_i ^{2}}}})$$

$$ log(g) = -log({\sqrt {2\pi } \sigma_i}\;) -{\frac {(x-\mu_i )^2}{2\sigma_i ^{2}}}$$

$$\frac{\partial log(g)}{\partial\mu_i} = \frac {(x-\mu_i )}{\sigma_i ^{2}}$$

$$\frac{\partial log(g)}{\partial \sigma_i} = -\frac{1}{\sigma_i}+\frac {(x-\mu_i )^2}{\sigma_i ^{3}}$$


[img]http://bit.ly/1R4Rrh5[/img]




  [1755ad6c]: http://www.robots.ox.ac.uk/~ojw/files/NotesOnCD.pdf "Notes on Contrastive Divergence"
  [d4a65028]: http://www.cs.toronto.edu/~fritz/absps/tr00-004.pdf "Training Products of Experts by Minimizing Contrastive Divergence"
