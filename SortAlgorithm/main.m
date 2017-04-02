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

void swap_sup(int* a, int* b)
{
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

void optimalBubbleSort(int arr[], int n);
void bubbleSort(int arr[], int n);
void insertSort(int arr[], int n);
void selectSort(int arr[], int n);

// 快速排序
void quickSort_sup(int arr[], int left, int right);
void quickSort(int arr[], int n);

// 堆排序-创建大顶堆进行升序排序
void maxHeapCreate(int arr[], int n);
void maxHeapSort(int arr[], int n);

// 归并排序
void mergeSort(int arr[], int n);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        int arr[] = {1, 0};
//        int arr[] = {1, 2, 3, 8, 5, 4, 9, 6};
//        int arr[] = {1, 3, 2, 4, 5, 6, 8, 9};
//        int arr[] = {15, 6, 12, 13, 14, 11, 18, 20, 17};
        int arr[] = {10, 9, 8, 7, 15, 6, 12, 13, 14, 11, 18, 20, 17};
//        int arr[] = {5, 6, 12, 11, 18, 20, 27};
        int arrN = sizeof(arr)/sizeof(arr[0]);
        
//        insertSort(arr, arrN); // 插入排序
        
//        optimalBubbleSort(arr, arrN);
//        bubbleSort(arr, arrN);
        
//        selectSort(arr, arrN);
        
//        quickSort(arr, arrN);
        
//        maxHeapSort(arr, arrN);
        
        mergeSort(arr, arrN);
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

// 选择排序（不稳定排序，时间复杂度O(n^2)）
void selectSort(int arr[], int n)
{
    int times = 0;
    for (int i=0; i<n; i++) {
        int min = arr[i];
        int minIndex = i;
        for (int j=i+1; j<n; j++) {
            times++;
            if (arr[j] < min) {
                min = arr[j];
                minIndex = j;
            }
        }
        if (i != minIndex) {
            arr[minIndex] = arr[i];
            arr[i] = min;
        }
    }
    NSLog(@"times:%i", times);
}

// 快速排序（不稳定排序）
void quickSort(int arr[], int n)
{
    if (n < 2) {
        return;
    }
    quickSort_sup(arr, 0, n-1);
}

void quickSort_sup(int arr[], int left, int right)
{
    if (left >= right) {
        return;
    }
    
    int anchor = arr[left];
    int i = left+1;
    int j = right;
    while (i < j) {
        
        if (arr[i] < anchor) {
            i++;
            continue;
        }
        
        if (arr[j] < anchor) {
            swap_sup(arr+i, arr+j);
            i++;
            
            if (i == j) {
                break;
            }
        }
        j--;
    }
    
    int anchorIndex = i;
    if (arr[i] >= anchor) {
        anchorIndex = i-1;
    }
    swap_sup(arr+left, arr+anchorIndex);
    
    quickSort_sup(arr, left, anchorIndex-1);
    quickSort_sup(arr, anchorIndex+1, right);
}

// 堆调整，index表示子树的根节点下标
void maxHeapAdjust(int arr[], int vn, int index)
{
    int i = index;
    while (2*i+1<vn) {
        
        int a0 = arr[i];
        int a1 = arr[2*i+1];
        
        int tMax = a1;
        int tIndex = 2*i+1;
        
        // 判断是否存在右叶节点
        if (2*i+2 < vn) {
            int a2 = arr[2*i+2];
            if (a1 < a2) {
                tMax = a2;
                tIndex = 2*i+2;
            }
        }
        
        // 如果发生了调整，则对调整的子节点树再进行调整，否则认为该节点的树调整完毕，结束循环
        if (a0 < tMax) {
            arr[tIndex] = a0;
            arr[i] = tMax;
            i = tIndex;
        }
        else {
            break;
        }
    }
}

// 创建最大堆
void maxHeapCreate(int arr[], int vn)
{
    // 从后往前进行堆调整
    for (int i=(vn-2)/2; i>=0; i--) {
        maxHeapAdjust(arr, vn, i);
    }
}

// 堆排序，升序需要建立大顶堆，降序需要建立小顶堆（不稳定排序，时间复杂度O(nlogn)）
void maxHeapSort(int arr[], int n)
{
    // 不断进行堆创建，并将根节点与后面的节点进行交换
    for (int j=n-1; j>0; j--) {
        maxHeapCreate(arr, j+1);
        swap_sup(arr, arr+j);
    }
}

void mergeSort_sup(int arr[], int start, int end, int tArr[])
{
    if (start >= end) {
        return;
    }
    
    int mid = (start + end) / 2;
    mergeSort_sup(arr, start, mid, tArr);
    mergeSort_sup(arr, mid+1, end, tArr);
    
    // 将排序好的两部分进行合并排序，时间复杂度是O(n)
    int i = start;
    int j = mid+1;
    int index = start;
    while (i<=mid && j<=end) {
        if (arr[i] <= arr[j]) {
            tArr[index++] = arr[i++];
        }
        else {
            tArr[index++] = arr[j++];
        }
    }
    while (i<=mid) {
        tArr[index++] = arr[i++];
    }
    while (j<=end) {
        tArr[index++] = arr[j++];
    }
    
    for (int i=start; i<end+1; i++) {
        arr[i] = tArr[i];
    }
}

// 归并排序（稳定排序，时间复杂度O(nlogn)）
void mergeSort(int arr[], int n)
{
    int tmpArr[n];
    mergeSort_sup(arr, 0, n-1, tmpArr);
}













