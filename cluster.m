function [ centroids, id ] = cluster( image, K, plot_centroids )
%CLUSTER Function to cluster the pose image into head, torso, legs and
%other key features
%   The number of clusters chosen is 10 usually and can be increased later.
%   The centroids of the cluster are used as the means of each component in
%   the Gaussian Mixture.

%find all points of image which contains a body part.
[row, col] = find(image==1);


X = [row, col];

[id, centroids] = kmeans(X,K);

if plot_centroids,        
    figure;
    imshow(image);
    hold;
    plot(centroids(:,2),centroids(:,1),'ro','MarkerSize',12,'LineWidth',2);
end


end

