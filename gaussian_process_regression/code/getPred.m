function[m,lb,ub] = getPred(t1,t2,y1,theta)
%theta = exp(theta);
n = length(t1);
knl = @(ti,tj,theta)  exp(theta(1)) * exp(-0.5*exp(theta(2))*(pdist2(ti,tj)).^2)+exp(theta(3))*eye(n,n);
   K = knl(t1,t1,theta);
 KS = knl(t1,t2,theta);
 KSS = knl(t2,t2,theta);
 m= KS'*inv(K)*y1;
 cov = KSS - KS'*inv(K)*KS;
  lb = m - 2.575*sqrt(diag(cov));
 ub = m + 2.575*sqrt(diag(cov));
 
end