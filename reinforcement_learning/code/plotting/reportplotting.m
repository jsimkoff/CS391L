clear all
close all
load('all_paths3.mat') %SIDEWALK 1
%% litter alone

path_litter1 = path{1,1};
path_litter30 = path{1,30};
path_litter100 = path{1,100};

figure();
subplot(3,1,1); imagesc(sidewalk); hold on;plot(path_litter1(:,1),path_litter1(:,2),'-xr')
title('Litter collection - Episode 1')
set(gca,'xtick',[],'ytick',[]);

subplot(3,1,2); imagesc(sidewalk); hold on;plot(path_litter30(:,1),path_litter30(:,2),'-xr')
title('Episode 30')
set(gca,'xtick',[],'ytick',[]);

subplot(3,1,3); imagesc(sidewalk); hold on;plot(path_litter100(:,1),path_litter100(:,2),'-xr')
title('Episode 100')
set(gca,'xtick',[],'ytick',[]);
%% obs alone
path_obs1 = path{2,1};
path_obs30 = path{2,30};
path_obs100 = path{2,100};

figure();
subplot(3,1,1); imagesc(sidewalk); hold on;plot(path_obs1(:,1),path_obs1(:,2),'-xr')
title('Obstacle avoidance - Episode 1')
set(gca,'xtick',[],'ytick',[]);

subplot(3,1,2); imagesc(sidewalk); hold on;plot(path_obs30(:,1),path_obs30(:,2),'-xr')
title('Episode 30')
set(gca,'xtick',[],'ytick',[]);

subplot(3,1,3); imagesc(sidewalk); hold on;plot(path_obs100(:,1),path_obs100(:,2),'-xr')
title('Episode 100')
set(gca,'xtick',[],'ytick',[]);
%% end alone
path_end1 = path{3,1};
path_end30 = path{3,30};
path_end100 = path{3,100};

figure();
subplot(3,1,1); imagesc(sidewalk); hold on;plot(path_end1(:,1),path_end1(:,2),'-xr')
title('End-reaching - Episode 1')
set(gca,'xtick',[],'ytick',[]);

subplot(3,1,2); imagesc(sidewalk); hold on;plot(path_end30(:,1),path_end30(:,2),'-xr')
title('Episode 30')
set(gca,'xtick',[],'ytick',[]);

subplot(3,1,3); imagesc(sidewalk); hold on;plot(path_end100(:,1),path_end100(:,2),'-xr')
title('Episode 100')
set(gca,'xtick',[],'ytick',[]);

%% coop plots
coop1 = coop_paths{1};
coop10 = coop_paths{10};

figure();
subplot(2,1,1); imagesc(sidewalk); hold on;plot(coop1(:,1),coop1(:,2),'-xr')
title('Integrated modules - Episode 1')
set(gca,'xtick',[],'ytick',[]);

subplot(2,1,2); imagesc(sidewalk); hold on;plot(coop10(:,1),coop10(:,2),'-xr')
title('Episode 10')
set(gca,'xtick',[],'ytick',[]);
%% plot integrated performance metrics for sidewalk 1

% Need to plot left and right yaxis
for i = 1:10
    coop_score(i) = coop_scores{i};
    coop_plength(i) = length(coop_paths{i});
end


figure();

plot(coop_score,'o-'); 
hold on;

plot(100*coop_score./coop_plength,'o-');
title('Score performance')
legend('score','100 x score per move', 'Location','southeast'); xlabel('episode (integrated)');



%% single module comparison

load('single_module_results_3.mat') % SIDEWALK 1 single module results

singlemod100 = singlemod_paths{90};
figure();subplot(2,1,1); imagesc(sidewalk); hold on;plot(coop10(:,1),coop10(:,2),'-xr')
title('Integration of separately trained modules')
set(gca,'xtick',[],'ytick',[]);

subplot(2,1,2); imagesc(sidewalk); hold on;plot(singlemod100(:,1),singlemod100(:,2),'-xr')
title('Single module - episode 100')
set(gca,'xtick',[],'ytick',[]);
%% Sidewalk 2 and 3 integrated module performances

clear all;
load('all_paths2.mat'); % SIDEWALK 2
coop_sw2_10 = coop_paths{10};
figure(); subplot(2,1,1);imagesc(sidewalk); hold on;  plot(coop_sw2_10(:,1),coop_sw2_10(:,2),'-xr')
title('Sidewalk 2 - integrated episode 10')
set(gca,'xtick',[],'ytick',[]);

load('all_paths_regions1.mat'); % SIDEWALK 3
coop_sw3_10 = coop_paths{10};
 subplot(2,1,2); imagesc(sidewalk); hold on; plot(coop_sw3_10(:,1),coop_sw3_10(:,2),'-xr')
title('Sidewalk 3 - integrated episode 10')
set(gca,'xtick',[],'ytick',[]);

%% Sidewalk 3 region performance

load('all_paths_regions1.mat');
coop_sw3_10 = coop_paths{10};figure();
 subplot(3,1,1); imagesc(sidewalk); hold on; plot(coop_sw3_10(:,1),coop_sw3_10(:,2),'-xr')
title('Sidewalk 3 - integrated episode 10')
set(gca,'xtick',[],'ytick',[]);

load('cooperative_regions_relaxedB.mat')
coopreg_sw3_10 = coopreg_paths{10};
 subplot(3,1,2); imagesc(sidewalk); hold on; plot(coopreg_sw3_10(:,1),coopreg_sw3_10(:,2),'-xr')
title('Region-dependent modules episode 10')
set(gca,'xtick',[],'ytick',[]);

subplot(3,1,3); plot(coopreg_sw3_10(:,3),'LineWidth',1.5); title('Mode'); xlabel('mode 1=litter, mode 2=avoid obs, mode 3=all')

