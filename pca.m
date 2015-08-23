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