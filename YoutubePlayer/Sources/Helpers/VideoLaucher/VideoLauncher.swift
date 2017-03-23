//
//  VideoLauncher.swift
//  YoutubePlayer
//
//  Created by André Campopiano on 22/03/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView{
    
    let activityIndicatorView:UIActivityIndicatorView = {
       let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    
    let controlsContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupPlayerView()
        
        controlsContainerView.frame  = frame
        addSubview(controlsContainerView)
        
        backgroundColor = .black
        
        
        
    }
    
    func setupPlayerView(){
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        
        if let url = URL(string:urlString){
            let player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            
            
            player.play()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        
        if let keyWindow = UIApplication.shared.keyWindow{
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            
            view.frame = CGRect(x: keyWindow.frame.width - 30 , y: keyWindow.frame.height - 30, width: 20, height: 20)
            
            
            let height = keyWindow.frame.width * (9 / 16)
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayer = VideoPlayerView(frame: videoPlayerFrame)
            
            view.addSubview(videoPlayer)
            
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }, completion: { (completedAnimation) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
            
        }
        
        
        
    }
    
    
    
}
