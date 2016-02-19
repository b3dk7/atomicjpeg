/*
  Copyright (c) 2013 Daniel Lerch Hostalot <dlerch@gmail.com> and b3dk7

  Permission is hereby granted, free of charge, to any person obtaining a 
  copy of this software and associated documentation files (the "Software"), 
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, sublicense, 
  and/or sell copies of the Software, and to permit persons to whom the 
  Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in 
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
  DEALINGS IN THE SOFTWARE.
*/






#include <stdio.h>
#include <assert.h>
#include <setjmp.h>
#include <jpeglib.h>
#include <string.h>

#define MAX(a,b) (a>=b?a:b);
#define MIN(a,b) (a<=b?a:b);

#define VAL 50
int hist[VAL];



void print_dct_coef(j_decompress_ptr cinfo, jvirt_barray_ptr *coeffs, int ci){
        
  int max=0;
  int min=0;
  jpeg_component_info *ci_ptr = &cinfo->comp_info[ci];

  JBLOCKARRAY buf =
    (cinfo->mem->access_virt_barray)
    (
     (j_common_ptr)cinfo,
     coeffs[ci],
     0,
     ci_ptr->v_samp_factor,
     FALSE
     );

  int sf;
  for (sf = 0; (JDIMENSION)sf < ci_ptr->height_in_blocks; ++sf)
    {
      JDIMENSION b;
      for (b = 0; b < ci_ptr->width_in_blocks; ++b)
	{
			
	  int j;
	  for(j=0; j<64; j++)
	    {
	      int dc = 0;
	      dc = buf[sf][b][j];

	      if(dc>-1 && dc < 50)

		hist[dc] = hist[dc]+1;


	    }
	}
    }

}

GLOBAL(int) read_JPEG_file (char * filename)
{
  struct jpeg_decompress_struct cinfo;

  struct jpeg_error_mgr jerr;
  FILE * infile;

  if ((infile = fopen(filename, "rb")) == NULL) 
    {
      fprintf(stderr, "can't open %s\n", filename);
      return 0;
    }

  cinfo.err = jpeg_std_error(&jerr);
  jpeg_create_decompress(&cinfo);
  jpeg_stdio_src(&cinfo, infile);
  (void) jpeg_read_header(&cinfo, TRUE);
  jvirt_barray_ptr *coeffs = jpeg_read_coefficients(&cinfo);

  int c=0;
  for(c=0; c<cinfo.num_components; c++)
    print_dct_coef(&cinfo, coeffs, c);

  (void) jpeg_finish_decompress(&cinfo);
  jpeg_destroy_decompress(&cinfo);
  fclose(infile);
  return 1;
}
// }}}

int main(int argc, char **argv)
{

    int ret = 0;
    
    if (argc == 1 || strcmp(argv[1],"--help")==0){
      fprintf(stderr, "usage: %s <jpg file>\n", argv[0]);
      return 1;
    }
    printf("file,likelyhood of manipulation\n");
    int c;
    for(c=1;c<argc;c++){

      //resetting attary
      int x;
      for(x=0;x<VAL;x++)
	hist[x]=0;

      printf("%s",argv[c]);
      ret = read_JPEG_file(argv[c]);
	

      int weight = 50;
      float tamper = 0;

      int i;


      for(i=1;i<VAL;i++){
	if((hist[i]-hist[i-1])>0){
	  float penalty = ((float)hist[i]/(float)hist[i-1])*weight;
	  tamper = tamper + penalty;
	  //printf("%d,%f\n",i,penalty);
	}
	//printf("%d,%d,%f\n",i,hist[i],tamper);
	  
	    
	weight = weight -1;
      }
      //printf("%s,%d\n",argv[c],tamper);
      printf(",%0.1f\n",tamper);
	
    }

  return 0;
}



