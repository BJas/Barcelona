//
//  News.swift
//  BarcelonaApp
//
//  Created by Apple on 22.10.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

class News {
    var id: String
    var title : String
    var imgUrl : String
    var description : String
    var date: String
    
    init(id: String, title : String, imgUrl :String, description : String, date: String){
        self.id = id
        self.title = title
        self.imgUrl = imgUrl
        self.description = description
        self.date = date
    }
    
    static func form(id: String, title : String, imgUrl : String, description : String, date: String) ->
        News{
            let result = News(id: id, title : title, imgUrl: imgUrl, description: description, date: date)
            
            return result
        }
}
