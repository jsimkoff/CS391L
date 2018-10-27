% ICA on sound signals

close all;
clear all;
load('sounds.mat')
U = sounds(1:3,:);
%A = rand(3,3);
A = [  0.2    0.3    0.4;...
    0.4    0.5    0.3;...
    0.4    0.2    0.5];
X = A*U;
[m,n] = size(A);
% Winit = 0.9*inv(A);
% Winit = inv(A) + 0.2*randn(3,3);
%Winit = 0.1*rand(3,3);
Winit =[ 0.0831    0.0917    0.0754;...
    0.0585    0.0286    0.0380;...
    0.0550    0.0757    0.0568];

W = Winit;
eta = 0.001;
max_iter = 10^6;
delW = 1;
iter = 0;

tic
while norm(delW) > 1e-10 && iter < max_iter
    Y = W*X;
    Z = 1./(1+exp(-Y));
   delW = eta*(eye(m,n) *W + (1 - 2*Z)*Y'*W);
    W = W+delW;
    error = norm(Y-U,2);
    iter = iter+1;
end
toc
%% plots
rate = 11025;
figure();
subplot(3,1,1);

for i = 1:3
    Unorm = (U(i,:)- min(U(i,:))) ./ ( max(U(i,:)) - min(U(i,:)) );
    time = [1:1:length(Unorm)]/rate;
    plot(time(1800:2000),Unorm(1800:2000) + 0.5*i); hold on;
    ylim([0.5 2.5]);
end


subplot(3,1,2);

for i = 1:3
   Ynorm = (Y(i,:)- min(Y(i,:))) / ( max(Y(i,:)) - min(Y(i,:)) );
    time = [1:1:length(Ynorm)]/rate;
    plot(time(1800:2000),Ynorm(1800:2000) + 0.5*i); hold on;
    ylim([0.5 2.5]);
end

subplot(3,1,3);

for i = 1:3
    Xnorm = (X(i,:)- min(X(i,:))) / ( max(X(i,:)) - min(X(i,:)) );
    time = [1:1:length(Xnorm)]/rate;
    plot(time(1800:2000),Xnorm(1800:2000) + 0.5*i); hold on;
    ylim([0.5 2.5]);
end

% %%
% sound(U(1,:), rate)
% 
% %%
% sound(X(1,:),rate)
% 
% %%
% sound(Y(1,:),rate)


