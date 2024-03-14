clc;
clear;
close all;

%% Problem Definition
img= imread('cviceni3/calc.jpg');
[s1,s2,s3]=size(img);
Rplane = img(:,:,1);
Gplane = img(:,:,2);
Bplane = img(:,:,3);
X1 = (Rplane-min(Rplane(:)))/(max(Rplane(:))-min(Rplane(:))); 
X2 = (Gplane-min(Gplane(:)))/(max(Gplane(:))-min(Gplane(:))); 
X3 = (Bplane-min(Bplane(:)))/(max(Bplane(:))-min(Bplane(:)));  
% taking R-plane, B-plane, G-plane values as features
X = [X1(:) X2(:) X3(:)];
k = 6; % no. of clusters

CostFunction=@(m) ClusteringCost2(m, X);     % Cost Function m = [3x2] cluster centers

VarSize=[k size(X,2)];  % Decision Variables Matrix Size = [4 3]

nVar=prod(VarSize);     % Number of Decision Variables = 12

VarMin= double(repmat(min(X),1,k));      % Lower Bound of Variables [4x1] of[1x3] = [4x3]
VarMax= double(repmat(max(X),1,k));      % Upper Bound of Variables [4x1] of[1x3] = [4x3]

ga_opts = optimoptions('particleswarm','display','iter','MaxTime',600,'MaxIterations',20);
[centers, err_ga] = particleswarm(CostFunction, nVar,VarMin,VarMax,ga_opts);


m=centers;

    % Calculate Distance Matrix
    g=reshape(m,3,6)'; % create a cluster center matrix(4(clusters) points in 3(features) dim plane)=[4x3]
    d = pdist2(X, g); % create a distance matrix of each data points in input to each centers = [(s1*s2)x4]

    % Assign Clusters and Find Closest Distances
    [dmin, ind] = min(d, [], 2);
    % ind value gives the cluster number assigned for the input = [(s1*s2)x1]
    
    % Sum of Within-Cluster Distance
    WCD = sum(dmin); 
    
    z=WCD; % fitness function contain sum of each data point to their corresponding center value set (aim to get it minimum)    
    % z = [1 x 1]     

outimg=reshape(ind,s1,s2);


    figure()
    imagesc(outimg)
   
    
    