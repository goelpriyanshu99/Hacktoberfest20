#include <bits/stdc++.h>
using namespace std;


int maxValue(int c, int n , int *wt , int *val , int **dp)
{
    if(n==0 || c==0)
        return 0;
    
    if(dp[n][c]!=-1)
        return dp[n][c];

    if(wt[n-1]>c)
       return dp[n][c]=maxValue(c,n-1,wt,val ,dp);
    
  
    return dp[n][c]=max(val[n-1] + maxValue(c-wt[n-1] , n-1 , wt, val,dp  ) , maxValue(c, n-1 ,wt,
                                val,dp));
    
    //return 0;
}

int main()
{
    int n,c;
    cin>>n>>c;
    int wt[n];
    int value[n];
    for(int i=0; i<n; i++)
        cin>>wt[i];
    for(int i=0; i<n; i++)
        cin>>value[i];
    
    int **dp=new int *[n+1];
    for(int i=0; i<n+1; i++)
        dp[i]=new int[c+1];

    //memset(dp , -1 , sizeof(dp));
    for(int i=0; i<n+1; i++)
    {
        for(int j=0; j<c+1; j++)
            dp[i][j]=-1;
    }


    cout<<maxValue(c,n,wt,value,dp);


}
