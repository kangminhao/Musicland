//
//  AppleMusicAPI.swift
//  Jinx (iOS)
//
//  Created by Pawan Dixit on 5/4/21.
//

import Foundation
import StoreKit

class AppleMusicAPI {
    
    static let shared = AppleMusicAPI()
    
    static let developerToken = "eyJhbGciOiJFUzI1NiIsImtpZCI6IjJGRzJaWk44RlgiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJINVFXNk0zUURDIiwiZXhwIjoxNjg3NTg5NDc1LCJpYXQiOjE2NzE4NjQ2NzV9.O_rgSypW5JuPaU-wYOlMsxibW9r60HFSX6SmRddWw-uI7cQP7jUMDyWwQ4HtLhfPuJnVXvXx9p6ptrBaRdda7Q"
    
    var storeFrontId: String {
        
        var storefrontID: String?
        
        let musicURL = URL(string: "https://api.music.apple.com/v1/me/storefront")!
        var musicRequest = URLRequest(url: musicURL)
        musicRequest.httpMethod = "GET"
        musicRequest.addValue("Bearer \(AppleMusicAPI.developerToken)", forHTTPHeaderField: "Authorization")
        musicRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")
        
        let group = DispatchGroup()
        group.enter()
        URLSession.shared.dataTask(with: musicRequest) { data, response, error in
            guard error == nil else {
                print("\(String(describing: error))")
                group.leave()
                return
            }
            
            if let json = try? JSON(data: data!) {
                if let result = (json["data"]).array {
                    if let id = (result[0].dictionaryValue)["id"] {
                        storefrontID = id.stringValue
                    }
                }
            }
            
            group.leave()
        }.resume()
        
        group.wait()
        
        // if we dont get this then we want to fail
        return storefrontID!
    }
    
    var userToken: String = {
        
        var userToken: String?
        
        
        let group = DispatchGroup()
        group.enter()
        
        SKCloudServiceController().requestUserToken(forDeveloperToken: AppleMusicAPI.developerToken) { token, error in
            guard error == nil else {
                print("\(String(describing: error))")
                group.leave()
                return
            }
            
            userToken = token
            group.leave()
        }
        
        group.wait()
        
        // if we dont get this then we want to fail
        return userToken!
    }()
    
    func search(query: String) -> [Song] {
        
        var songs = [Song]()
        
        let musicURL = URL(string: "https://api.music.apple.com/v1/catalog/\(storeFrontId)/search?term=\(query.replacingOccurrences(of: " ", with: "+").replacingOccurrences(of: "\'", with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&types=songs&limit=25")!
        var musicRequest = URLRequest(url: musicURL)
        musicRequest.httpMethod = "GET"
        musicRequest.addValue("Bearer \(AppleMusicAPI.developerToken)", forHTTPHeaderField: "Authorization")
        
        let group = DispatchGroup()
        group.enter()
        
        URLSession.shared.dataTask(with: musicRequest) { data, response, error in
            guard error == nil else {
                print("\(String(describing: error))")
                group.leave()
                return
            }
            
            if let json = try? JSON(data: data!) {
                if let result = (json["results"]["songs"]["data"]).array {
                    for song in result {
                        let attributes = song["attributes"]
                        
                        let song = Song(id: attributes["playParams"]["id"].string ?? "", name: attributes["name"].string ?? "", artist: attributes["artistName"].string ?? "", artworkUrl: attributes["artwork"]["url"].string ?? "")
                        
                        songs.append(song)
                    }
                }
            }
            
            group.leave()
            
        }.resume()
        
        group.wait()
        
        return songs
    }
}
