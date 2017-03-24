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
        aiv.startAnimating()
        return aiv
    }()
    
    
    let controlsContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let playPauseButton:UIButton = {
        let buttom = UIButton(type: .system)
        let image = UIImage(named: "pause")
        buttom.setImage(image, for: .normal)
        buttom.translatesAutoresizingMaskIntoConstraints = false
        buttom.tintColor = UIColor.white
        buttom.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        buttom.isHidden = true
        return buttom
    }()

    let videoLenghtLabel:UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    let sliderVideo:UISlider = {
        let slider = UISlider()
        slider.tintColor = UIColor.red
        slider.minimumTrackTintColor = UIColor.red
        slider.maximumTrackTintColor = UIColor.white
        slider.setThumbImage(UIImage(named:"thumb"), for: .normal)
        slider.value = 0
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    var isPlaying = false
    
    func handlePause(){
        if isPlaying {
            player?.pause()
            playPauseButton.setImage(UIImage(named:"play"), for: .normal)
        }else {
            player?.play()
            playPauseButton.setImage(UIImage(named:"pause"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    func handleSliderChange(){
        
        if let duration = player?.currentItem?.duration{
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(sliderVideo.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (bool) in
                
            })
        }
    }
    
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupPlayerView()
        
        controlsContainerView.frame  = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(playPauseButton)
        playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backgroundColor = .black
        
        controlsContainerView.addSubview(videoLenghtLabel)
        
        videoLenghtLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLenghtLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoLenghtLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLenghtLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        controlsContainerView.addSubview(sliderVideo)
        sliderVideo.rightAnchor.constraint(equalTo: rightAnchor, constant:  -40).isActive = true
        sliderVideo.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        sliderVideo.widthAnchor.constraint(equalTo: widthAnchor, constant: -80).isActive = true
        sliderVideo.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
    }
    
    var player:AVPlayer?
    
    func setupPlayerView(){
        
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        
        if let url = URL(string:urlString){
            
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)

        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = UIColor.clear
            playPauseButton.isHidden = false
            if let durationVideo = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(durationVideo)
                let secondsText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLenghtLabel.text = "\(minutesText):\(secondsText)"
                sliderVideo.maximumValue = Float(seconds)
            }
            
            
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
            
            view.frame = CGRect(x: keyWindow.frame.width - 10 , y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            
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
