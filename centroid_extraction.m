load('centroids_for_100images_with_constant_clusters.mat')
n=340;
sprintf('Number of Images processing: %d',n);
centroids_ts = zeros(2,10,n);
images = image_loader('04006',340);
for i=1:n,
    centroids_ts(:,:,i)=cluster(images(:,:,i),10,inital_cluster',false)';
    initial_cluster = centroids_ts(:,:,i);
end