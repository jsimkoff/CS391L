clear all
close all
load digits.mat

num_train = 2000; % num training images
T =20; % num eigenvectors used for basis
A_mat = [];  % matrix of image pixel data
[n,m] = size(trainImages(:,:,1,1));
pixels = n*m;


for i = 1:num_train
    A_mat = [A_mat double(reshape(trainImages(:,:,1,i),pixels,1))];
end

A_mean = mean(A_mat')';
A_mc = A_mat - A_mean;


%% select basis



ATA = A_mc'*A_mc;
[eigvec,D] = eig(ATA);
eigval = diag(D);
eigvec2 = A_mc*eigvec;

% Since I use more training data to achieve good results, can use below
% [eigvec2,D] = eig(A_mc*A_mc');
% eigval = diag(D);

% BUT need to use the above to easily plot the eigenvectors

[sorted_eigvals, index] = sort(eigval);
index = flipud(index);
%  figure();
basis = [];
for i = 1:T
    eigvec_i = eigvec2(:,index(i));
    eigvec_show = (eigvec_i);
    eigvec_i = eigvec_i/norm(eigvec_i) ;
    basis = [basis; eigvec_i'];
  
%     subplot(2,10,i); 
%     imshow(reshape(eigvec_show,m,n)), drawnow
end




%% 
plots = 0;

if plots == 1
    figure();
    for i = 1:10
        A1 = double(reshape(trainImages(:,:,1,i),pixels,1));
        A1_mc = A1 - A_mean;
        A1_proj = basis*A1_mc;
        A1_recon = A1_proj'*basis;
        
        subplot(2,10,i),imshow(reshape(A1, m,n)),
        subplot(2,10,10+i),imshow(reshape(A1_recon, m,n)), drawnow
        pause(0.1);
    end
end


%% knn model
tic
      labels = double(trainLabels(1:num_train))';
    mdl = fitcknn((basis*A_mc)',labels,'NumNeighbors',8, 'DistanceWeight','inverse');
    score = 0;
    num_test = 5000;
    for i = 1:num_test
        A1_test = basis*(double(reshape(testImages(:,:,1,i),pixels,1))-A_mean);
        A1_label = double(testLabels(i));
        A1_predict = predict(mdl,A1_test');
        
        if A1_label == A1_predict
            score = score+1;
        end
    end
    
    first_half = score/num_test*100
      
    score = 0;
    num_test = 5000;
    for i = 5001:5000+num_test
        A1_test = basis*(double(reshape(testImages(:,:,1,i),pixels,1))-A_mean);
        A1_label = double(testLabels(i));
        A1_predict = predict(mdl,A1_test');
        
        if A1_label == A1_predict
            score = score+1;
        end
    end
    
    second_half = score/num_test*100
    

toc