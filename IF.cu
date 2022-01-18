//Riley Taylor-S00348849
//CSCI4250, HW2
//Image Filtering

#include <iostream>
using namespace std;
//Thanks for showing us this!
#define iceil(num,den) (num+den-1)/den

//Kernel Function
__global__ void imgFilKernel(float* d_img_in, float* d_img_out, int *d_img_filter,int w, int h){
	
	//Access each "pixel" array index!
	int col = blockDim.x * blockIdx.x + threadIdx.x;
	int row = blockDim.y * blockIdx.y + threadIdx.y;

	//The if statement helps in creating a small border so the image does not go out of bounds!
	if(col < w && row < h && row > 0 && col > 0 && row < h-1 && col < w-1)																	//4 5 3 7 1 8 0 6 2
		d_img_out[row*w + col] = ((((((((((d_img_in[row*w + col] * d_img_filter[4]) + d_img_in[row*w + (col+1)] * d_img_filter[5]) + d_img_in[row*w + (col-1)] * d_img_filter[3]) +d_img_in[(row+1)*w + col] * d_img_filter[7]) + d_img_in[(row-1)*w + col] * d_img_filter[1]) + d_img_in[(row+1)*w + (col+1)] * d_img_filter[8]) + d_img_in[(row-1)*w + (col-1)] * d_img_filter[0]) +d_img_in[(row+1)*w + (col-1)] * d_img_filter[6]) +d_img_in[(row-1)*w + (col+1)] * d_img_filter[2])/9);
	//while this is not the best way to filter (index by index) it works for all examples you just have to edit the numbers in the filter
}

void imgFil(float*img_in, float* img_out, int *img_filter, int w, int h) {
	
	//This number of bytes are going be allocated and transferred
	int size = w * h * sizeof(float);
	int size2 = 8*sizeof(int);
	
	float *d_img_in, *d_img_out;
	int *d_img_filter;
	//GPU memory allocation!
	cudaMalloc((void**)&d_img_in, size);
	cudaMalloc((void**)&d_img_out, size);
	cudaMalloc((void**)&d_img_filter,size2);
	
	//GPU data transfer
	cudaMemcpy(d_img_in, img_in, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_img_filter,img_filter,size2,cudaMemcpyHostToDevice);
	dim3 myBlockDim(16, 16, 1);
	dim3 myGridDim(iceil(w, 16), iceil(h, 16), 1);
	//Call the kernel!
	imgFilKernel <<<myGridDim, myBlockDim >>> (d_img_in, d_img_out, d_img_filter, w, h);

	//Transfer "Image" back to HOST!
	cudaMemcpy(img_out, d_img_out, size, cudaMemcpyDeviceToHost);

	//free the allocated memory
	cudaFree(d_img_in);
	cudaFree(d_img_out);
	cudaFree(d_img_filter);
}

//Prints the image!
void printImage(float* img, int w, int h) {
	for (int i = 0; i < h; i++) {
		for (int j = 0; j < w; j++) {
			cout << img[i*w + j] << " ";
		}
		cout << endl;
	}
	cout << endl;
}

int main(){

	int w = 30; int h = 20;
	//allocating CPU memory!
	float *img_in = new float[w*h];
	float *img_out = new float[w*h];
	int *img_filter = new int[8];
	//Fill array with 3s
	for (int i = 0; i < h; i++)
		for (int j = 0; j < w; j++)
			img_in[i*w + j] = 3;
	//fill the filter with 9s
	for (int i = 0; i < 9; i++)
		img_filter[i] = 9;
	
	//prints the "image" before hand so you can see the difference.
	printImage(img_in, w, h);

	//apply filter to "image"
	imgFil(img_in, img_out, img_filter, w, h);
	
	//THis prints out the filter!
	for (int x=0; x<1; x++)
		for (int y=0; y<3; y++)
		{
			cout << img_filter[x*x+y]<<img_filter[x*x+y]<<img_filter[x*x+y];
			cout <<endl;
		}		
	
	cout <<endl;
	//prints the after "image" so you can see the applied filter
	printImage(img_out, w, h);

	return 0;
}
