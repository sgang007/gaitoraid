<<<<<<< HEAD
function [U, S] = pca(X)
%PCA Run principal component analysis on the dataset X
%   [U, S, X] = pca(X) computes eigenvectors of the covariance matrix of X
%   Returns the eigenvectors U, the eigenvalues (on diagonal) in S
%

% Useful values
[m, n] = size(X);

% You need to return the following variables correctly.
U = zeros(n);
S = zeros(n);

% ====================== YOUR CODE HERE ======================
% Instructions: You should first compute the covariance matrix. Then, you
%               should use the "svd" function to compute the eigenvectors
%               and eigenvalues of the covariance matrix. 
%
% Note: When computing the covariance matrix, remember to divide by m (the
%       number of examples).
%


sigma = (1/m)*sum(X);
[U, S, V] = svd(sigma);

 


% =========================================================================

end
=======
%%%%%%%// Pre-processing stage
close all;

%// Read in image - make sure we cast to double
B = double(imread('sil10340.pbm'));

%// Calculate covariance matrix
sigma = cov(B);

%// Find eigenvalues and eigenvectors of the covariance matrix
[A,D] = eig(sigma);
vals = diag(D);

%// Sort their eigenvalues
[~,ind] = sort(abs(vals), 'descend');

%// Rearrange eigenvectors
Asort = A(:,ind);

%// Find mean subtracted data
Bm = bsxfun(@minus, B, mean(B,1));

%// Reproject data onto principal components
Bproject = Bm*Asort;

%%%%%%%// Begin reconstruction logic
figure;
counter = 1;

for k = [3 11 15 25 45 65 125 155]
    %// Extract out highest k eigenvectors
    Aq = Asort(:,1:k);

    %// Project back onto original domain
    out = bsxfun(@plus, Bproject(:,1:k)*Aq.', mean(B, 1));

   
    %// Place projection onto right slot and show the image
    subplot(4, 2, counter);
    counter = counter + 1;
%     imshow(out,[]);
imshow(im2uint8(out));
    title(['k = ' num2str(k)]);
end
>>>>>>> 106b7b753dfd94f1d767e6e4164a186f91fe5694
