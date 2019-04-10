#include<stdio.h>
#include<stdlib.h>
__global__ void matadd(int *d_a,int *d_b,int *d_c, int n){

int idx=threadIdx.x;
if(idx<n)
d_c[idx]=d_a[idx]+d_b[idx];

}


int main(){

int n;
scanf("%d",&n);
cudaEvent_t start,stop;
float escap_time;


cudaEventCreate(&start);
cudaEventCreate(&stop);

cudaEventRecord(start,0);




int *h_a,*h_b,*h_c;

cudaHostAlloc((void**)&h_a,20*n*sizeof(int),cudaHostAllocDefault);
cudaHostAlloc((void**)&h_b,20*n*sizeof(int),cudaHostAllocDefault);
cudaHostAlloc((void**)&h_c,20*n*sizeof(int),cudaHostAllocDefault);


return 0;

}
