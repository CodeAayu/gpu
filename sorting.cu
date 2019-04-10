#include<stdio.h>
#include<stdlib.h>
__global__ void srt(int* a, int n){

int idx=threadIdx.x;

for(int i=0; i<n-1; i++){

	if(i%2==idx%2 and idx+1<n)
	{
		if(a[idx]>a[idx+1]){
			int t=a[idx] ;
			a[idx]=a[idx+1] ;
			a[idx+1]=t ;		
		}
	}
}

}

int main()
{

int n;	scanf("%d",&n);

int *a_h;

a_h=(int*)malloc(n*sizeof(int));

for(int i=0; i<n; i++)
	a_h[i]=rand()%1000;

printf("earlier:\n");

for(int i=0; i<n; i++)
	printf("%d ",a_h[i]);

printf("\n");
	
int *a_d;

cudaMalloc( (void**)&a_d, n*sizeof(int) ) ; 
cudaMemcpy( a_d , a_h , n*sizeof(int) , cudaMemcpyHostToDevice ) ;

dim3 blockdim=n ;
dim3 griddim=1 ;

srt<<<griddim,blockdim>>>(a_d,n) ;

cudaMemcpy( a_h , a_d , n*sizeof(int) ,cudaMemcpyDeviceToHost ) ; 

printf("sorted\n"); 

printf("after:\n");

for(int i=0; i<n; i++)
	printf("%d ",a_h[i]);

}

