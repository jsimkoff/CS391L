clear all
% multiple data points
[frame,xvec] = cleandata('GPdata_MC.csv');
[~,xvec2] = cleandata('GPdata_SG.csv');
[~, xvec3] = cleandata('GPdata_CJ.csv');
time = frame/30;
t1 = time(1:40:end);

n = length(t1);
theta0 = [1 1 1];

knl = @(ti,tj,theta)  exp(theta(1)) * exp(-0.5*exp(theta(2))*(pdist2(ti,tj)).^2)+exp(theta(3))*eye(n,n);


yv = xvec(1:40:end,:);
yv2 = xvec2(1:40:end,:);
yv3 = xvec3(1:40:end,:);
theta_optv = [];
for i = 1:4
 gprMdl = fitrgp(t1,yv(:,i),'KernelFunction',knl,'KernelParameters',theta0);
 theta_optv = [theta_optv exp(gprMdl.KernelInformation.KernelParameters)];   
end

theta_avg = mean(theta_optv');


%%
gprMdlavg = fitrgp(t1,mean([yv yv2 yv3]'),'KernelFunction',knl,'KernelParameters',theta0);
theta_opt_yavg = exp(gprMdlavg.KernelInformation.KernelParameters)
ypred = resubPredict(gprMdlavg);
  figure(); plot(t1,ypred,'r','LineWidth',1.5); hold on;
  for i = 1:5
      plot(t1, yv(:,i),'b') 
      plot(t1,yv2(:,i),'b')
      plot(t1,yv3(:,i),'b')
  end
  plot(t1,ypred,'r','LineWidth',3);
 legend('GP','traces'); title('3 subjects: all traces'); xlabel('t'); ylabel('x')
