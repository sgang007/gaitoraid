function [obj,idx]=gmmcluster(I,K)

[dimx,dimy] = size(I);
I=im2double(I);
%img is the name of the image
%k is the no of clusters
%read file
I = 255 * uint8(I);


%choose indices of 'white' pixels as coordinates of data
[datax datay]=find(I);

%cluster data into 10 clumps

 [cInd, c] = kmeans([datax datay], K, 'EmptyAction','singleton',...
    'maxiter',1000,'start','cluster');

 %============================================================
 %Generate prior GSM here and feed it as a starting point of EM
 %============================================================
%For newer versions of MATLAB, uncomment below:
%obj = fitgmdist(I,K,'Regularizationvalue',0.1);

options = statset('MaxIter',500);
obj = gmdistribution.fit([datax, datay],K,'Regularize',0.1,'Options',options);


figure;
 
ezsurf(@(x,y)pdf(obj,[x y]),[0 dimx],[0 dimy]);

%imshow(I);
%  gscatter(datay,-datax);
% hold on
% h1=scatter(cluster1(:,1),cluster1(:,2),10,'r.');
% h2=scatter(cluster2(:,1),cluster2(:,2),10,'g.');
% 
% % scatter(obj.mu(:,2),-obj.mu(:,1),20,'ko'); %same funky coordinates
%  scatter(c(:,2),-c(:,1),20,'k+'); %same funky coordinates
%  legend([h1 h2],'Cluster 1','Cluster 2','Location','NW')
end
