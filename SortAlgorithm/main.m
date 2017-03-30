//
//  main.m
//  SortAlgorithm
//
//  Created by guanglong on 2017/3/30.
//  Copyright © 2017年 bjhl. All rights reserved.
//

#import <Foundation/Foundation.h>

void printArr(int arr[], int n) {
    for (int i=0; i<n; i++) {
        printf("%i, ", arr[i]);
    }
    printf("\n");
}

void optimalBubbleSort(int arr[], int n);
void bubbleSort(int arr[], int n);
void insertSort(int arr[], int n);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        int arr[] = {1, 2, 3, 8, 5, 4, 9, 6};
//        int arr[] = {1, 3, 2, 4, 5, 6, 8, 9};
//        int arr[] = {15, 6, 12, 13, 14, 11, 18, 20, 17};
        int arr[] = {10, 9, 8, 7, 15, 6, 12, 13, 14, 11, 18, 20, 17};
//        int insertArr[] = {5, 6, 12, 11, 18, 20, 27};
        int arrN = sizeof(arr)/sizeof(arr[0]);
        
//        insertSort(arr, arrN); // 插入排序
        
//        optimalBubbleSort(arr, arrN);
        bubbleSort(arr, arrN);
        printArr(arr, arrN);
    }
    return 0;
}

// 插入排序（时间复杂度O(n^2)，适合少量数据排序，是稳定的排序算法）
void insertSort(int arr[], int n)
{
    int times = 0;
    for (int i=1; i<n; i++) {
        int tmp = arr[i];
        int j = i-1;
        for (; j>=0; j--) {
            times++;
            if (tmp < arr[j]) {
                arr[j+1] = arr[j];
            }
            else {
                break;
            }
        }
        arr[j+1] = tmp;
    }
    NSLog(@"times:%i", times);
}

// {5, 6, 12, 11, 18, 20, 27}
// 25 6 18 20 17
// {1, 2, 3, 8, 5, 4, 9, 6}
// 优化后的冒泡排序（）
void optimalBubbleSort(int arr[], int n)
{
    int times = 0;
    for (int i=0; i<n; i++) {
        
        BOOL shouldBreak = YES;
        int minIndex = n-1;
        int max = arr[n-1];
        int exchange = INT_MAX;
        
        for (int j=n-1; j>i; j--) {
            times++;
            if (arr[j-1] > arr[j]) {
                int tmp = arr[j-1];
                arr[j-1] = arr[j];
                arr[j] = tmp;
                
                if (arr[j] > max) {
                    max = arr[j];
                }
                
                // 是为了判断这一组是不是已经按升序排好，如果没有排好，则不会提前结束外循环
                if (arr[j] > exchange) {
                    shouldBreak = NO;
                }
                exchange = arr[j];
            }
            else {
                // 是为了判断这一组的最大值是否小于或等于上一组的最小值，如果不是，则不会提前结束外循环
                // 需要注意的是，上一组的最小值就是上一组的第一个元素
                if (max > arr[minIndex]) {
                    shouldBreak = NO;
                }
                minIndex = j;
                max = arr[j-1];
                exchange = INT_MAX;
            }
        }
        
        // 结束内循环之后，判断最后一组的最大值是否小于等于上一组的最小值，如果不是，则不会提前结束外循环
        if (max > arr[minIndex]) {
            shouldBreak = NO;
        }
        
        // 提前结束外循环
        if (shouldBreak) {
            break;
        }
    }
    NSLog(@"opt-times:%i", times);
}

// 冒泡排序（稳定排序，平均时间复杂度O(n^2)）
void bubbleSort(int arr[], int n)
{
    int times = 0;
    for (int i=0; i<n; i++) {
        for (int j=n-1; j>i; j--) {
            times++;
            if (arr[j-1] > arr[j]) {
                int tmp = arr[j-1];
                arr[j-1] = arr[j];
                arr[j] = tmp;
            }
        }
    }
    NSLog(@"unopt-times:%i", times);
}
