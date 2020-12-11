//
//  Webservice.swift
//  News App
//
//  Created by Niclas Jeppsson on 04/12/2020.
//

import UIKit

protocol ArticleDelegate {
    func updateArticles(data: [Articles])
}

struct Webservice {
    
    var delegate: ArticleDelegate?
    
    let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=927d2efda3fe43c784cfcfda0f8c7c3c"
    
    func setup(){
        getArticles(urlString: urlString)
    }
    
    func getArticles(urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else if let data = data {
                    self.parseJSON(data: data)
                }
            }
            
            .resume()
        }
    
    }
    
    func parseJSON(data:Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ArticleList.self, from: data)
            delegate?.updateArticles(data: decodedData.articles)
        } catch {
            print("Error decoding data : \(error)")
        }
        
    }
    
}
