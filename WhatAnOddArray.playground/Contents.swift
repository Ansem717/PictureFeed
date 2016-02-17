//: Playground - noun: a place where people can play

import UIKit


func oddElements(array: [AnyObject]) -> [AnyObject] {
    
    var tempArray = [AnyObject]()
    var isOdd = true //first item is odd, even though it has an index of 0. This means that on index of 1, isOdd is false, and index of 2, isOdd is true.
    
    for element in array {
        if isOdd { tempArray.append(element) }
        isOdd = !isOdd
    }
    return tempArray
}



func oddElementsALTERNATE(array: [AnyObject]) -> [AnyObject] {
    
    var tempArray = [AnyObject]()
    
    for var i = 0; i < array.count; i+=2 {
        tempArray.append(array[i])
    }
    return tempArray
}

var firstArray = [1,2,3,4,5]
var secondArray = ["One","Two","Three","Four","Five"]
var thirdArray = [1, "Two", 3, 4, "Five"]
var fourthArray = ["One", 2, "Three", "Four", 5, 6, 7, "Eight"]
var fifthArray = ["Odd", "Even", "Odd", "Even", "Odd", "Even", "Odd", "Even"]

print("oddElements results:")
print(oddElements(firstArray))
print(oddElements(secondArray))
print(oddElements(thirdArray))
print(oddElements(fourthArray))
print(oddElements(fifthArray))
print("")
print("oddElementsALTERNATE results:")
print(oddElementsALTERNATE(firstArray))
print(oddElementsALTERNATE(secondArray))
print(oddElementsALTERNATE(thirdArray))
print(oddElementsALTERNATE(fourthArray))
print(oddElementsALTERNATE(fifthArray))


//Both of the above functions work for finding every odd element. I am counting the elements starting at one, as if a -person- was to read the elements.
//When the computer reads it, the computer starts at 0, which is neither odd nor even, but most people settle to understand 0 is even.
//Therefore, a different result is acheived if I checked for an odd index rather than an odd position in the array.
//Elements at an odd index have even positions in the array.

//The first one is using a for-in loop with a reference to an external variable "isOdd", which is initially set to true. 
//Running over each element of the array, isOdd switches from true to false to true over and over again with the line (isOdd != isOdd)
//If isOdd is true, then the item is appeneded into a new temporary array. The new array is returned when the loop is finished.

//The second one is using a general for loop creating a new variable i to define the index. It's initial value is 0 because that is the index to the first item. 
//It will always check if i is less than the array's length, and then the index will increment by two instead of 1. This will skip every even number.
//It must be less than the array's length because array.count starts counting the array at 1, not at 0, where the index starts. By requiring i to be less than the length, I will never go past the size of the array.











