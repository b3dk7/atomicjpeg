# atomicjpeg
## description
atomicjpeg photo forensics tool that computes the likelyhood of a JPEG photo being manipulated. The strength of this program is that it can analyse multiple images without human intervention. What atomicjpeg can not do is tell you exactly what part of an image has been manipulated, for this we suggest you have at Error Level Analysis (ELA).

The algorithm employed, determines the smoothnes of a jpg's quantized DCT coeficinet historgram. The smoother the histogram, the more likely an image is in its original format and has not been manipulated. More details on the historgram technique can be found in the paper http://www.ws.binghamton.edu/fridrich/Research/Doublecompression.pdf

The program performs better on larger images as they provide a greater sample of coeficinets to work with. We do not suggest using this software on images smaller than 1 mega pixel.




## Requirements
c compiler (we recommend gcc)
ruby
probably easier to do this in linux

## First Step - Compile the C programs
navigate into this directory
extract the jpeg library - `tar xvf jpegsrc.v8a.tar.gz`
compile the jpeg library - `cd jpeg-8a; ./configure; make`
compile the dct_dump program - `cd ..; gcc dct_dump.c -o dct_dump -I jpeg-8a/ -L jpeg-8a/.libs -l jpeg`

## Second Step - install all the Gems (Ruby Libraries)

`sudo gem install exifr`
`sudo gem install histogram`

## Finals Step run the ruby scripts

`ruby histogram.rb test_images/*`



## Further work
* look at http://www.ws.binghamton.edu/fridrich/Research/dc_7_dc.pdf
* look at https://belkasoft.com/forgery-detection
* look at http://www.getghiro.org/
* incorporate metadata using exiftool
* introduce machine learning with tflearn or tensor flow (regression example here https://github.com/b3dk7/horses-ml)
* create massive csv file containing a whole bunch of features for all jpeg files

## Support
Feel free to message me about any issues. My email is benedikt(dot)boehm(at)posteo(dot)net
