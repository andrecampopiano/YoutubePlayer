//
//  SubscriptionCell.swift
//  YoutubePlayer
//
//  Created by André Campopiano on 21/03/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionVideos{ (videos:[Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
