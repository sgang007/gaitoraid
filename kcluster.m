
function c=kcluster(img,b)
%img is the name of the image
%k is the no of clusters
%read file
I=im2double(imread(img));
K=b;
%choose indices of 'white' pixels as coordinates of data
[datax datay]=find(I);

%cluster data into 10 clumps

[cInd, c] = kmeans([datax datay], K, 'EmptyAction','singleton',...
    'maxiter',1000,'start','cluster');

figure;
gscatter(datay,-datax,cInd); %funky coordinates for plotting according to image
axis equal;
hold on;
scatter(c(:,2),-c(:,1),20,'ko'); %same funky coordinates
end