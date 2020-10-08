// can find factorial of numbers upto 100 and beyond

#include<bits/stdc++.h>
#define ll long long
using namespace std;

int main(){
    int n,m;

    // input the number
    cin>>m;

    //initialise the array with 0
    int a[500]={0};
    int i;

    //setting the first element of array to 1
    a[0]=1;
    int x;
    int temp;
    int j;
    i=1;

    // outer loop to traverse all numbers from given number downto 2
    for(n=2;n<=m;n++){
        temp=0;

    // to perform multiplication of two numbers using array and storing the result in array    
    for(j=0;j<i;j++){
        x=a[j]*n+temp;
        a[j]=x%10;
        temp=x/10;
    }

    // this loop handles the temp value left after above loop also value of i tells
    // about the index upto which there is non-zero value in array
    while(temp){
        a[i]=temp%10;
        temp=temp/10;
        i++;
    }
    }

    // print the array from last non-zero value in reverse order to get the answer
    for(i=i-1;i>=0;i--)
        cout<<a[i];
    return 0;
    }