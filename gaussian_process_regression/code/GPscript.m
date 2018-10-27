clear all; close all;
[frame,xvec] = cleandata('GPdata_SG.csv');

time = frame/30;
t1 = time(1:40:end);
y1 = xvec(1:40:end,1);

n = length(t1);
theta0 = [1 1 1];

knl = @(ti,tj,theta)  exp(theta(1)) * exp(-0.5*exp(theta(2))*(pdist2(ti,tj)).^2)+exp(theta(3))*eye(n,n);



 gprMdl = fitrgp(t1,y1,'KernelFunction',knl,'KernelParameters',theta0);
 theta_opt = (gprMdl.KernelInformation.KernelParameters) ;
 exp(theta_opt)
ypred = resubPredict(gprMdl); 
 figure();subplot(2,2,1); plot(y1,'o'); hold on; plot(ypred); title('Data and predictions - one run')
 ylabel('x')
 %%
 
 
t2 =  time(20:40:end); y2 = xvec(20:40:end,1);
[mbad, lbbad,ubbad] = getPred(t1,t2,y1,[ 0 10 0]);
 subplot(2,2,2); plot(t2,y2,'o'); hold on; plot(t2,mbad); plot(t2, lbbad, 'r--',t2, ubbad, 'r--'); 
  title('Interpolated pred - bad hps')
[m2,lb2b,ub2b] = getPred(t1,t2,y1,theta_opt);
 subplot(2,2,3); plot(t2,y2,'o'); hold on; plot(t2,m2); plot(t2, lb2b, 'r--',t2, ub2b, 'r--'); 
xlabel('t'); ylabel('x');
 title('Interpolated pred - goodhps')
 
 t2 =  time(801:2:852); y2 = xvec(801:2:852,1);
[m2,lb2b,ub2b] = getPred(t1,t2,y1,theta_opt);
 subplot(2,2,4); plot(t2,y2,'o'); hold on; plot(t2,m2); plot(t2, lb2b, 'r--',t2, ub2b, 'r--'); 
xlabel('t')
 title('Interpolated predictions - zoomed in')

 %%
t2 =  time(20:40:end); y2 = xvec(20:40:end,1);
[m2,lb2b,ub2b] = getPred(t1,t2,y1,theta_opt);
 figure();subplot(3,1,1); plot(t2,y2,'o'); hold on; plot(t2,m2); plot(t2, lb2b, 'r--',t2, ub2b, 'r--'); 
xlabel('t'); ylabel('x');title('full horizon')
 % first half
 t1b = time(1:20:end/2);
y1b = xvec(1:20:end/2,1);
 gprMdlb = fitrgp(t1b,y1b,'KernelFunction',knl,'KernelParameters',theta0);
  theta_optb = (gprMdlb.KernelInformation.KernelParameters);
  exp(theta_optb)
 t2b = time(10:20:end/2); y2b = xvec(10:20:end/2,1);
[m,lb,ub] = getPred(t1b,t2b,y1b,theta_optb);
subplot(3,1,2); plot(t2b,y2b,'o'); hold on; plot(t2b,m); plot(t2b, lb, 'r--',t2b, ub, 'r--'); xlabel('t'); ylabel('x');
title('first half')
%  second half
   t1c = time(end/2+1:20:end);
    y1c = xvec(end/2+1:20:end,1);
    gprMdlc = fitrgp(t1c,y1c,'KernelFunction',knl,'KernelParameters',theta0);
    theta_optc =(gprMdlc.KernelInformation.KernelParameters) ;
    exp(theta_optc)
    t2c = time(end/2+11:20:end); y2c = xvec(end/2+11:20:end,1);
    [m,lb,ub] = getPred(t1c,t2c,y1c,theta_optc);
    
    subplot(3,1,3); plot(t2c,y2c,'o'); hold on; plot(t2c,m); plot(t2c, lb, 'r--',t2c, ub, 'r--'); xlabel('t'); ylabel('x');
title('second half')
%% zoomed in comparison
 t2 =  time(801:2:852); y2 = xvec(801:2:852,1);
[m2,lb2b,ub2b] = getPred(t1,t2,y1,theta_opt);
 figure();subplot(1,2,1); plot(t2,y2,'o'); hold on; plot(t2,m2); plot(t2, lb2b, 'r--',t2, ub2b, 'r--'); 
xlabel('t'); ylabel('x')
 title('Zoomed in: full horizon fit')


 t2 =  time(801:2:852); y2 = xvec(801:2:852,1);
[m2,lb2b,ub2b] = getPred(t1,t2,y1,theta_optc);
 subplot(1,2,2); plot(t2,y2,'o'); hold on; plot(t2,m2); plot(t2, lb2b, 'r--',t2, ub2b, 'r--'); ylim([-0.7 -0.3])
xlabel('t')
 title('Zoomed in: second half fit')
