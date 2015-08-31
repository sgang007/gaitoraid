%finding a pattern between the cetroids of an input seqqunces of 10 images from the mobob dataset


images=load('gait2go.mat');%load the matrix file
for i=1:10
   
I{i}=images.result{i};
 I{i}=im2double(I{i});

%determine 'white' pixels, size of image can be [M N], [M N 3] or [M N 4]
Idims=size(I{i});
whites=true(Idims(1),Idims(2));

df=I{i};
%we add up the various color channels
for colori=1:size(df,3)
    whites=whites & df(:,:,colori)>0.5;
end

%choose indices of 'white' pixels as coordinates of data
[datax datay]=find(whites);

%cluster data into 10 clumps
K = 10;               % number of mixtures/clusters
cInd = kmeans([datax datay], K, 'EmptyAction','singleton',...
    'maxiter',1000,'start','cluster');

%get clusterwise means
meanx=zeros(K,1);
meany=zeros(K,1);
for j=1:K
    meanx(j)=mean(datax(cInd==j));
    meany(j)=mean(datay(cInd==j));
end

xc{i}=meanx;
xb{i}=meany;
   



figure;
gscatter(datay,-datax,cInd); %funky coordinates for plotting according to image
axis equal;
hold on;
scatter(meany,-meanx,20,'+'); %same funky coordinates


end






