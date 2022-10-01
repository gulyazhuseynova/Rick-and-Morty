//
//  ViewModel.swift
//  The Rick and Morty
//
//  Created by Gulyaz Huseynova on 26.09.22.
//

import UIKit

struct Manager {
    
    var success: ((ApiData?) -> Void)?
    var success2: ((ApiDataEpisode?) -> Void)?
    var success3 : ((ApiDataLocation?) -> Void)?
    
    func getRequest (pageCount : Int) {
        
        let string = "https://rickandmortyapi.com/api/character?page=\(pageCount)"
        let url = URL(string: string)!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error)
                return
            }
            if let safeData = data {
                let decodedData = try? JSONDecoder().decode(ApiData.self, from: safeData)
                self.success?(decodedData)
            }
        }
        session.resume()
    }
    
    func getEpisodeRequest(url : String) {
        
        let url = URL(string: url)!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error)
                return
            }
            if let safeData = data {
                let decodedData = try? JSONDecoder().decode(ApiDataEpisode.self, from: safeData)
                self.success2?(decodedData)
            }
        }
        session.resume()
    }
    
    func getLocationRequest(url : String) {
        
        guard let url = URL(string: url) else {return}
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error)
                return
            }
            if let safeData = data {
                let decodedData = try? JSONDecoder().decode(ApiDataLocation.self, from: safeData)
                self.success3?(decodedData)
            }
        }
        session.resume()
    }
    
}

