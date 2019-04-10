#include<stdio.h>

__global__ void maxi(int *d_a,int n){

int strid=(n/2);
int idx=threadIdx.x;
while(strid>0){
	if(idx<strid)
		if(d_a[idx]<d_a[idx+strid])
			d_a[idx]=d_a[idx+strid];
strid=(strid/2);
}

}

int main(){
int n=512;
int *a;
a=(int*)malloc(n*sizeof(int));
for(int i=0; i<n; i++)
	a[i]=i*i*i;

int *d_a;

cudaMalloc((void**)&d_a,n*sizeof(int));

cudaMemcpy(d_a,a,n*sizeof(int),cudaMemcpyHostToDevice);

dim3 blockD(n,1,1);
dim3 gridD(1,1,1);

maxi<<<gridD,blockD>>>(d_a,n);

int *b;
b=(int*)malloc(n*sizeof(int));
cudaMemcpy(b,d_a,n*sizeof(int),cudaMemcpyDeviceToHost);
printf("%d\n",b[0]);


}

