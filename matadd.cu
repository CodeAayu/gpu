#include <stdio.h>

#define tw 2

__global__ void matadd(int *a, int *b, int *c,  int n){
	int ix = tw*blockIdx.x +threadIdx.x;
	int iy = tw*blockIdx.y + threadIdx.y;
	int idx = iy*n+ix;
	if(idx<n*n)
		c[idx]=a[idx]+b[idx];
}

int main(void) {
	int n;
	scanf("%d",&n);
	int a[n][n];
	int b[n][n];
	int c[n][n];
	for(int i=0; i<n; i++){
		for(int j=0; j<n; j++){
			scanf("%d",&a[i][j]);
		}
	}
	for(int i=0; i<n; i++){
		for(int j=0; j<n; j++){
			scanf("%d",&b[i][j]);
		}
	}
	
	int *a_d, *b_d, *c_d;
	
	cudaMalloc((void **)&a_d, n*n*sizeof(int));
	cudaMalloc((void **)&b_d, n*n*sizeof(int));
	cudaMalloc((void **)&c_d, n*n*sizeof(int));
	cudaMemcpy(a_d, a, n*n*sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(b_d, b, n*n*sizeof(int), cudaMemcpyHostToDevice);
	
	dim3 dimGrid(n/2,n/2,1);
	dim3 dimBlock(tw,tw,1);
	
	matadd<<<dimGrid,dimBlock>>>(a_d,b_d,c_d,n);
	
	cudaMemcpy(c,c_d,n*n*sizeof(int),cudaMemcpyDeviceToHost);
	
	for(int i=0; i<n; i++)
		printf("%d ",&c[i]);
	printf("\n");
	
	return 0;
}

