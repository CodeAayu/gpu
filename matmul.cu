
#include<stdio.h>

#define tw 2

__global__ void matmul(int *a,int *b, int *c, int n){
	
	int ix=tw*blockIdx.x+threadIdx.x;
	int iy=tw*blockIdx.y+threadIdx.y;
	int idx=n*iy+ix;
	c[idx]=0;
	for(int k=0; k<n; k++){
		c[idx]+=a[ix*n+k]*b[k*n+iy];
	}
}

int main(){
	int n;
	scanf("%d",&n);
	int *a;
	int *b;
	int *c;
	
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
			
	int *da,*db,*dc;
	cudaMalloc((void**)&da,n*n*sizeof(int));
	cudaMalloc((void**)&db,n*n*sizeof(int));
	cudaMalloc((void**)&dc,n*n*sizeof(int));
	
	cudaMemcpy(da,a,n*n*sizeof(int),cudaMemcpyHostToDevice);
	cudaMemcpy(db,b,n*n*sizeof(int),cudaMemcpyHostToDevice);

	dim3 griddim(ceil(n*1.0/tw),ceil(n*1.0/tw),1);
	dim3 blockdim(tw,tw,1);

	matmul<<<(griddim,blockdim)>>>(da,db,dc,n);
	
	cudaMemcpy(c,dc,n*n*sizeof(int),cudaMemcpyDeviceToHost);

	for(int i=0; i<n; i++){
		for(int j=0; j<n; j++){
			printf("%d ",c[i][j]);
		}	
		printf("\n");
	}
}
