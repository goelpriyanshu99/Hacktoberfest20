
id :- deepak290701

#include <bits/stdc++.h>
using namespace std;

void multiply(int f[2][2],int m[2][2]){

    int temp[2][2];
    for(int i=0;i<2;i++){
        for(int j=0;j<2;j++){
            temp[i][j]=0;
            for(int k=0;k<2;k++){
                temp[i][j]+=f[i][k]*m[k][j];
            }
        }
    }
    for(int i=0;i<2;i++){
        for(int j=0;j<2;j++){
            f[i][j]=temp[i][j];
        }
    }

}

void power(int f[2][2], int n){
    int m[2][2]={{1,1},{1,0}};
    if(n==0 || n==1){

        return ;
    }
    power(f,n/2);
    multiply(f,f);
    if(n&1){
        multiply(f,m);
    }


}

int fib(int n){
    int f[2][2]={{1,1},{1,0}};
    if(n==0)
        return 0;
    if(n==1 || n==2)
        return 1;
    power(f,n -1);
    int ans=f[0][0]; //because f[0][0]*1 + f[0][1]*0 = f[0][0]
    return ans;
}


int main()
{
    int n;
    cin>>n;
    cout<<fib(n);
}
