require 'histogram/array'  # enables Array#histogram

data = [0,1,2,2,2,2,2,3,3,3,3,3,3,3,3,3,5,5,9,9,10]
# by default, uses Scott's method to calculate optimal number of bins
# and the bin values are midpoints between the bin edges
(bins, freqs) = data.histogram
# equivalent to:  data.histogram(:scott, :bin_boundary => :avg)
