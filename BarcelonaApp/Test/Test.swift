//
//  Test.swift
//  BarcelonaApp
//
//  Created by Apple on 13.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

class Test {
    var question : String
    var answer : String
    var variantArr : [String]
    var id: Int
    
    init(question : String, answer :String, variantArr : [String], id:Int){
        self.question = question
        self.answer = answer
        self.variantArr = variantArr
        self.id = id
    }
    
    
    static func form(question : String, answer : String, variantArr : [String], id: Int) ->
        Test{
            let result = Test(question : question, answer:answer, variantArr : variantArr, id: id)
            
            return result
            
    }
}
