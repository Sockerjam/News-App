//
//  ArticleViewModel.swift
//  News App
//
//  Created by Niclas Jeppsson on 04/12/2020.
//

import Foundation

struct ArticleListViewModel: Decodable, Hashable{

    
    let articles:[ArticleList]
    
}

struct ArticleList : Codable, Hashable {
    
    var articles:[Articles]
}

struct Articles : Codable, Hashable {
    
    var source:Source
    var title:String?
    var description:String?
    
}

struct Source : Codable, Hashable {
    
    var name:String
}
