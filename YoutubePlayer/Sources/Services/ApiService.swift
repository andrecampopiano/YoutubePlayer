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
    
    func fetchVideos(completion: @escaping ([Video])->()){
        guard let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if  let err = error {
                print(err)
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                
                var videos = [Video]()
                
                
                
                for dictionary in json as! [[String:AnyObject]]{
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDicitionary = dictionary["channel"] as! [String:AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDicitionary["name"] as? String
                    channel.profileImageName = channelDicitionary["profile_image_name"] as? String
                    video.channel = channel
                    videos.append(video)
                    
                    
                }
                
                DispatchQueue.main.async {
                    completion(videos)
                    
                }
                
                
                
            }catch let jsonErr {
                print(jsonErr)
            }
            
        }
        task.resume()

    }
    
}
