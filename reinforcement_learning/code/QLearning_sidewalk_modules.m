% QLearning_sidewalk_modules.m
% Jodie Simkoff

% This function trains three modules separately 
% Input an existing sidewalk, or if no input the function will randomly
% create a new sidewalk.

% The output of the module can be fed to cooperative.m or
% cooperative_regions.m 

function[ sidewalk_new, path, score_track,Q] = QLearning_sidewalk_modules(sidewalk)
close all

NUM_ITER = 100;

Q = {1:3};
rng('shuffle');
if isempty(sidewalk) == true
   
    fprintf('creating new sidewalk')
    % build sidewalk with rewards and obstacles
    W = 8; L = 80;
    sidewalk = zeros(W,L);
    
    for i = 1:20
        sidewalk(ceil(W*rand),ceil(L*rand)) = 160;
        sidewalk(ceil(W*rand),ceil(L*rand)) = 20;
    end
    sidewalk(:,L) = 200;
    
  
end
% save a copy of new sidewalk
sidewalk_new = sidewalk;
W = size(sidewalk,1); L = size(sidewalk,2);
startX = 1; startY = 4;
sidewalk(startY, startX) = 80;
% create Q matrix - randomly intialized from uniform dist
Qreward = rand(W,L,5);
Qobs = rand(W,L,5);
Qend = rand(W,L,5);
alpha = 0.9; gamma = 0.5;
figure();
for mode = 1:3
    for iter =1:NUM_ITER
        sidewalk = sidewalk_new;
        score = 0;
        
                fig = imagesc(sidewalk); hold on;
                set(gcf, 'Position', [300, 300, 900, 400])
                set(gca,'xtick',[],'ytick',[]);
                title(iter)
        
        currX = startX ;
        currY = startY;
        pause(1)
        pathk = [startX startY];
        
        while currX < L
            
            pause(0.2);
            sidewalk(currY,currX) = 0;
            if iter < 20
                action = ceil(5*rand);
            else
                if mode == 1
                    [~,index] = max(Qreward(currY,currX,:));
                elseif mode == 2
                    [~,index] = max(Qobs(currY,currX,:));
                elseif mode == 3
                    [~,index] = max(Qend(currY,currX,:));
                elseif mode == 4
                    [~,index] = max(max(([Qreward(currY,currX,:),Qobs(currY,currX,:),Qend(currY,currX,:)])));
                end
                action = index;
            end
            prvX = currX; prvY = currY;
            
            [newX,newY] = move(currX,currY,action);
            
            currX = newX;
            if newY <= W && newY >= 1
                currY = newY;
            end
            
            pathk = [pathk; currX currY];
            
            if sidewalk(currY,currX) == 160
                reward = 3;
                obs = 0;
                isend = currX - prvX;
                score = score+3;
            elseif sidewalk(currY,currX) == 20
                reward = 0;
                obs = -1;
                isend = currX - prvX;
                score = score - 1;
            elseif sidewalk(currY,currX) == 200
                reward = 0;
                obs = 0;
                isend = 1000;
                
            else
                reward = 0;
                obs = 0;
                isend = currX - prvX;
            end
            
            
            Qreward(prvY,prvX,action) = Qreward(prvY,prvX,action) + ...
                alpha*(reward+gamma*max(Qreward(currY,currX,:)) - Qreward(prvY,prvX,action));
            Qobs(prvY,prvX,action) = Qobs(prvY,prvX,action) + ...
                alpha*(obs+gamma*max(Qobs(currY,currX,:)) - Qobs(prvY,prvX,action));
            Qend(prvY,prvX,action) = Qend(prvY,prvX,action) + ...
                alpha*(isend+gamma*max(Qend(currY,currX,:)) - Qend(prvY,prvX,action));
            
            sidewalk(currY,currX) = 80;
            
                        imagesc(sidewalk);
            
            
            
        end
        score_track{mode,iter} = score;
        
        path{mode,iter} = pathk;
        fprintf('mode %d - episode %d \n',mode, iter)
        
    end
    Q = {Qreward, Qobs, Qend};
end
end
function [newX,newY] = move(currX,currY,action)

if action == 1 % go north
    newY = currY + 1;
    newX = currX;
elseif action == 2 % go northeast
    newY = currY + 1;
    newX = currX + 1;
elseif action == 3 % go east
    newY = currY;
    newX = currX + 1;
elseif action == 4 % go southeast
    newY = currY - 1;
    newX = currX + 1;
elseif action == 5 % go south
    newY = currY - 1;
    newX = currX;
end


end


