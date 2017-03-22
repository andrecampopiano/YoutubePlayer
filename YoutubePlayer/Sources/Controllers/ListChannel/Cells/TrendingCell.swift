//
//  TrendingCell.swift
//  YoutubePlayer
//
//  Created by André Campopiano on 21/03/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingVideos{ (videos:[Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
