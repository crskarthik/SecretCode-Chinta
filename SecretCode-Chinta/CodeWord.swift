//
//  CodeWord.swift
//  SecretCode-Chinta
//
//  Created by Raja Srikar Karthik Chinta on 2/28/18.
//  Copyright © 2018 Raja Srikar Karthik Chinta. All rights reserved.
//

import UIKit

class CodeWord: NSObject {
    var Symbols:[String]=[]
    var Count:Int=0
    var Code:[String]=[]
    var Guess:[String]=[]
    var OnSymbol:Int=0
    var Attempts:Int
    var Status:String=""
    init(CodeSize n:Int)
    {
        if n>=4
        {
            Count=n
            Symbols = ["A","అ","B","C","D","ஜ"]
            for _ in 1...Count{
                Code.append(Symbols[Int(arc4random_uniform(UInt32(Symbols.count)))])
            }
            
        }
        Attempts=1
        print(Symbols)
        print(Code)
        
    }

    func addSymbol(sym:String){
        if Guess.count <= Code.count{
            Guess.append(sym)
            OnSymbol += 1
            Status = "Attempt \(Attempts): \(Guess.count) guessed"
            if Guess.count == Count {
                Attempts += 1
                OnSymbol = 0
                Status = "Guess Complete: \(noOfCorrectPositions()) positions matched."

            }
        }
        print(Guess)
        print(OnSymbol)
    }
    func undoSymbol(){
        if Guess.count != 0 {
            Guess.removeLast()
            OnSymbol -= 1
            Status = "Attempt \(Attempts): \(Guess.count) guessed"        }
    }
    
    func noOfCorrectPositions()->Int{
        var crt:Int = 0
        for i in 0..<Guess.count{
            if Guess[i] == Code[i]
            {
                crt += 1
            }
        }
        return crt
    }
    func statusOfGuess()->String{
        return Status
    }
    func currentGuess()->String
    {
        var guessString = ""
        for i in 0 ..< Guess.count
        {
            guessString += " \(Guess[i])"
        }
        for _ in Guess.count ..< Count
        {
            guessString += " -"
        }
        return guessString
    }
    func isMatched()->Bool
    {
        var times=0
        for i in 0..<Count{
            if Guess[i] == Code[i]
            {
                times=1
            }
            else{
                times=0
                break
            }
        }
        return times == 1
    }

    func reset()
    {
        OnSymbol = 0
        Code=[]
        Guess=[]
        for _ in 1...Count{
            Code.append(Symbols[Int(arc4random_uniform(UInt32(Symbols.count)))])
        }
        print(Code)
    }
}
