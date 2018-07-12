# atomicjpeg
## description
atomicjpeg photo forensics tool that computes the likelyhood of a JPEG photo being manipulated. The strength of this program is that it can analyse multiple images without human intervention. What atomicjpeg can not do is tell you exactly what part of an image has been manipulated, for this we suggest you have at Error Level Analysis (ELA).

The algorithm employed, determines the smoothnes of a jpg's quantized DCT coeficinet historgram. The smoother the histogram, the more likely an image is in its original format and has not been manipulated. More details on the historgram technique can be found in the paper http://www.ws.binghamton.edu/fridrich/Research/Doublecompression.pdf

The program performs better on larger images as they provide a greater sample of coeficinets to work with. We do not suggest using this software on images smaller than 1 mega pixel.


##Making the most of atomicjpeg
We suggest atomicjpeg is to

##Performance
##accuracy
accuracy of X percent accieved using a likelyhood threshold of Y percent tested on a pool of Z original and W photoshoped fotos. 

###speed
0.3 seconds per 13 mega pixel image tested with an intel i3 (2.4GHz) and 6GB of ram


##Requirements
libjpg version 8a or higher

##Compilation and instalation (installs into /usr/local/bin)
To compile, simply run

`make`

to install, log in as root and rum

`make install`

##Usage and output
for usage instructions compile and run

`atomicjpeg [FILES]`

The output is 

##Example

To analyze a single file run

`atomicjpeg pic.jpg`

To analyze all jpg files in the current directory and save results to a file names 'results' run

`atomicjpeg *.jpg > results`

##Further work
* look at http://www.ws.binghamton.edu/fridrich/Research/dc_7_dc.pdf
* look at https://belkasoft.com/forgery-detection
* look at http://www.getghiro.org/
* incorporate metadata using exiftool
* introduce machine learning with tflearn (regression example here https://github.com/b3dk7/horses-ml)
* create massive csv file containing a whole bunch of features for all jpeg files



##Support

Feel free to message me about any issues. My email is benedikt(at)riseup(dot)net

ps: please let me know anyone wants to be able to output the DCT histogram itself, I would be glad to add this feature.
