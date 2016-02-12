//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func howManyWords(text: String) {
    if text.isEmpty { print("0 words"); return }
    let words = text.characters.filter { (character) -> Bool in
        return character == " "
    }
    print("\(words.count+1) words")
}

howManyWords("") //0 words
howManyWords("How many words?") //3 words
howManyWords("The quick brown fox jumps over the lazy dog.") //9 words
howManyWords("What happens when we add punctuation? Or multiple blank spaces?") //10 words

howManyWords("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.") //91 words - I actually counted.

// I stumbled upon this by accident, actually.
// When I normally do not know what to look for, I type the varaible
// and then I type a period following. "text." and then Xcode gives me
// a drop down menu of all methods or classes associated with that variable type.

// I saw characters, and recalled that I was able to manipulate a string like an array by
// using characters. I went with characters, and did the test again:
// text.characters.
// A couple things turned up with an array as a result. 

// I tried the first one, which was filter. The closure filled itself out.
// I tried return true at first, and got every character seperate on it's own line.
// Then I tried 'return character' and got the same result.

// Lastly, I set it to compare if the character is whitespace. 
// Techinically, I counted the number of spaces within the string, instead of the number of characters.
// Since logic dictates that I'll have 1 less whitespace than number of words
// by adding one to the length of the array, you get the number of words.

// So yea, sure, I didn't count the number of words, but it's the same thing, right?

