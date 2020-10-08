/* 
Given two random integer arrays, print their intersection. That is, print all the elements that are present in both the given arrays.
Input arrays can contain duplicate elements.
Note : Order of elements are not important
Input format :
Line 1 : Integer N, Array 1 Size
Line 2 : Array 1 elements (separated by space)
Line 3 : Integer M, Array 2 Size
Line 4 : Array 2 elements (separated by space)
Output format :
Print intersection elements in different lines
Constraints :
1 <= M, N <= 10^6
Sample Input :
6
2 6 8 5 4 3
4
2 3 4 7 
Sample Output :
2 
4 
3
*/

#include<bits/stdc++.h>
using namespace std;

void print_array_intersection(int* arr1,int size1,int* arr2,int size2){
      for(int i=0;i<size1;i++){
         for(int j=0;j<size2;j++){
             if(arr1[i]==arr2[j]){
                cout<<arr2[j]<<endl;
                arr2[j]=-9999;       // for avoiding repetition of element or avoiding duplicate elements
                break;
             }
         }
      }
}

int main(){
    int size1,size2;
    cin>>size1;
    int* arr1=new int[size1];
    for(int i=0;i<size1;i++){
        cin>>arr1[i];
    }
    cin>>size2;
    int* arr2=new int[size2];
    for(int i=0;i<size2;i++){
        cin>>arr2[i];
    }
    print_array_intersection(arr1,size1,arr2,size2);
}