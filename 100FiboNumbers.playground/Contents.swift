//: Playground - noun: a place where people can play

import UIKit

func showMeFibo(maximum: Int) -> [Int] {

    var tempFiboArray = [Int]()
    var prevNumber = 0
    var prevNumber2 = 0
    var result = 0
    
    while result <= maximum {
        switch (prevNumber, prevNumber2) {
        case (0,0): //Both numbers are 0 initially
            prevNumber = 1
            tempFiboArray.append(1)
        case (1,0): //Above, we set one number to increase, but the one before it still doesn't
            prevNumber2 = 1
            tempFiboArray.append(1)
        default: //Now that our loop isn't inifitely adding 0, we can do the math.
            result = prevNumber + prevNumber2
            prevNumber2 = prevNumber
            prevNumber = result //Both of these lines essentially move the chain down the list. Now PN2 is equal to 1 (value of PN) and PN is now equal to 2
            if result <= maximum { tempFiboArray.append(result) }
        }
    }
    
    return tempFiboArray
}


print(showMeFibo(100))
print(showMeFibo(1000))
print(showMeFibo(10000))


//Every time I tried to check if subtracting from the index would result in an error, the if statement that checked resulted in an error itself. So I just manually 
//placed in the answers if the index is 0 or 1. Once the index is 2, the math can kick in.

//I earlier had an abundant of if statements and was really thinking about what I could do to shorten the if statments. I then refreshed myself on making better "If else" chains (like maybe I could do it in one line or something) and I found switch-case. Figured it could work, but had no clue I could state two numbers, so yet another google search.

// It took me a while, and then I kept getting an error when I was using a for-in loop and a generic for loop. 

/*

for var i = 0; i <= 100; i++ {
    //switch statement
}

The above code kept giving a bad instructions error. Also took me some time trying to debug instead of switching to a while loop.

*/

//This assignment was much harder than the other code challenges, due to the clunky start of the Fibo sequence, as well as the errors and poor looking results.
//To cap the result list at 100 (which I later changed to allow a maximum), I had to check if the result iself was too big. If it wasn't, dont add it.











