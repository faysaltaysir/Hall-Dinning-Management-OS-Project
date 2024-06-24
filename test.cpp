#include<iostream>
using namespace std;
int main(){
    for(int i=0;i<=132;i++){
        if(i<10)
            cout<<"echo "<<200400<<i<<" >> userId.txt"<< endl;
        else if(i<100)
            cout<<"echo "<<20040<<i<<" >> userId.txt"<< endl;
        else{
            cout<<"echo "<<2004<<i<<" >> userId.txt"<< endl;
        }
    }
}