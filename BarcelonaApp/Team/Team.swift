//
//  Team.swift
//  BarcelonaApp
//
//  Created by Apple on 17.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

class Team {
    var id: Int
    var name: String
    var position: String
    var number: Int
    var imgUrl: String
    var age: Int
    var height: Int
    var weight: Int
    var nationality: String
    var birth: String
    var contract: String
    
    init(id: Int, name: String, position: String, number: Int, imgUrl: String, age: Int, height: Int, weight: Int, nationality: String, birth: String, contract: String){
        self.id = id
        self.name = name
        self.position = position
        self.number = number
        self.imgUrl = imgUrl
        self.age = age
        self.height = height
        self.weight = weight
        self.nationality = nationality
        self.birth = birth
        self.contract = contract
    }
    
    static func form(id: Int, name: String, position: String, number: Int, imgUrl: String, age: Int, height: Int, weight: Int, nationality: String, birth: String, contract: String) ->
        Team{
            let result = Team(id: id, name: name, position: position, number: number, imgUrl: imgUrl, age: age, height: height, weight: weight, nationality: nationality, birth: birth, contract: contract)
            
            return result
    }
}
