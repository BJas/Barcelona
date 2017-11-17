//
//  Answer.swift
//  BarcelonaApp
//
//  Created by Apple on 14.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

class Answer {
    var randomQuestion: String = ""
    var chosenAnswer: String = ""
    var rightAnswer: String = ""
    
    
    init(randomQuestion: String, chosenAnswer: String, rightAnswer: String){
        self.randomQuestion = randomQuestion
        self.chosenAnswer = chosenAnswer
        self.rightAnswer = rightAnswer
    }
    
    static func form(randomQuestion: String,chosenAnswer: String, rightAnswer: String) -> Answer{
        let result = Answer(randomQuestion: randomQuestion,chosenAnswer: chosenAnswer,rightAnswer: rightAnswer)
        return result
    }
}
