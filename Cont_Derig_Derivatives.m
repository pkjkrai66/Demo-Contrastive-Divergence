function derivatives_wrtParam = Cont_Derig_Derivatives(x, param0)


mu1_guess = param0(1);
mu2_guess = param0(2);
sig1_guess = param0(3);
sig2_guess = param0(4);

delg_mu1 = (x - mu1_guess)/sig1_guess^2;
delg_mu2 = (x - mu2_guess)/sig2_guess^2;

delg_sig1 = (((x - mu1_guess).^2)/sig1_guess^3) - (1./sig1_guess);
delg_sig2 = (((x - mu2_guess).^2)/sig2_guess^3) - (1./sig2_guess);

derivatives_wrtParam = [delg_mu1, delg_mu2, delg_sig1, delg_sig2];