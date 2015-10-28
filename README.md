# Gaitoraid (under development)

[![Join the chat at https://gitter.im/sgang007/gaitoraid](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/sgang007/gaitoraid?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Usage of gait information to establish identity of a person in traffic cameras.
Re-identification of persons across multiple cameras using their gait information.

#Testing out our work:
1. Clone this repository on your desktop
2. Download the MoBo database from [the official CMU website](http://www.cs.cmu.edu/afs/cs/project/MoBo/web/) .
3. Make a folder called Mobo and extract the archive called moboBgSub.tgz in this directory
4. Open MATLAB or Octave and browse to the root of this repository.
5. Run the script centroid_extraction.m to get clustered centroids of all images in fast_walk pose.
6. Form the feature vectors by taking the abcissa/ordinates of each of the 10 centroids.
7. Use the net.m script to train the Nonlinear autoregrssive neural network on the set of observations.

Note: A seperate network to train each of the vectors is more advisable rather than taking a matrix of all centroids and its trend in the timestep.

TODO:

- [x] Image clustering to get positions of head, torso and 10 other key features.
- [x] Organizing the clusters and optimizing it so that the clusters represnt constant classes in all images
- [x] Time series analysis on the cluster centroids to observe lag in data
- [ ] Seperate trend, seasonality and stochasticity of the data
- [x] NAR based Neural network to train on the time series
- [ ] Predict based on the trained neural network
- [ ] Test results plotted in performance curves
- [x] Develop dynamic kernel using the time series estimates.
- [ ] Calculate simmalirty score using p-values and check if hypothesis is true.
