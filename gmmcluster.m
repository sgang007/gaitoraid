function [obj,idx]=gmmcluster(I,K)

I=im2double(imread((I)));
%img is the name of the image
%k is the no of clusters
%read file
I = 255 * uint8(I);


%choose indices of 'white' pixels as coordinates of data
[datax datay]=find(I);

%cluster data into 10 clumps

 [cInd, c] = kmeans([datax datay], K, 'EmptyAction','singleton',...
    'maxiter',1000,'start','cluster');
obj = fitgmdist(I,K,'Regularizationvalue',0.1);
idx = cluster(obj,I);
cluster1 = I(idx == 1,:);
cluster2 = I(idx == 2,:);

 figure;
 
 imshow(I);
 gscatter(datay,-datax);
hold on
h1=scatter(cluster1(:,1),cluster1(:,2),10,'r.');
h2=scatter(cluster2(:,1),cluster2(:,2),10,'g.');

% scatter(obj.mu(:,2),-obj.mu(:,1),20,'ko'); %same funky coordinates
 scatter(c(:,2),-c(:,1),20,'k+'); %same funky coordinates
 legend([h1 h2],'Cluster 1','Cluster 2','Location','NW')
end
