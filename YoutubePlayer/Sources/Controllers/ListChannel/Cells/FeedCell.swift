//
//  FeedCell.swift
//  YoutubePlayer
//
//  Created by André Campopiano on 21/03/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    var videos:[Video]?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    func fetchVideos(){
        ApiService.sharedInstance.fetchFeedVideos { (videos:[Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    
    
    let cellId = "cellId"
    override func setupViews(){
        super.setupViews()
        
        fetchVideos()
        backgroundColor = .brown
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        
        if let video = videos?[indexPath.item]{
            cell.video = video
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heigth = (frame.width - 16 - 16)  * (9 / 16)
        return CGSize(width: frame.width, height: heigth + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }

    
}
