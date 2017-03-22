//
//  ApiService.swift
//  YoutubePlayer
//
//  Created by André Campopiano on 20/03/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func fetchVideosWithEndPoint(endPoint:String,completion: @escaping ([Video])->()){
        guard let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/\(endPoint).json") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if  let err = error {
                print(err)
                return
            }
            do{
                if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String:AnyObject]] {
                    DispatchQueue.main.async {
                        completion(jsonDictionaries.map({return Video(dictionary: $0)}))
                    }
                }
            }catch let jsonErr {
                print(jsonErr)
            }
        }
        task.resume()
        
    }
    
    
    func fetchFeedVideos(completion: @escaping ([Video])->()){
        let endPoint = "home_num_likes"
        fetchVideosWithEndPoint(endPoint: endPoint, completion:completion)
    }
    
    func fetchTrendingVideos(completion: @escaping ([Video])->()){
        let endPoint = "trending"
        fetchVideosWithEndPoint(endPoint: endPoint, completion:completion)
        
    }
    
    func fetchSubscriptionVideos(completion: @escaping ([Video])->()){
        let endPoint = "subscriptions"
        fetchVideosWithEndPoint(endPoint: endPoint, completion: completion)
        
    }
}
