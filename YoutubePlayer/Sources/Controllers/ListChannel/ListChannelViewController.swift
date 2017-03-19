//
//  YoutubeViewController.swift
//  CloneTinder
//
//  Created by André Campopiano on 13/03/17.
//  Copyright © 2017 André Luís  Campopiano. All rights reserved.
//

import UIKit

class ListChannelViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos:[Video]?
    
    func fetchVideos(){
        guard let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if  let err = error {
                print(err)
                return
            }
            do{
               let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                
                self.videos = [Video]()
                
                
                
                for dictionary in json as! [[String:AnyObject]]{
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDicitionary = dictionary["channel"] as! [String:AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDicitionary["name"] as? String
                    channel.profileImageName = channelDicitionary["profile_image_name"] as? String
                    video.channel = channel
                    self.videos?.append(video)
                    
                   
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
                
                
            }catch let jsonErr {
                print(jsonErr)
            }
            
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideos()
        
        
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x:0,y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        setupMenuBar()
        setupNavBarButtons()
        
    }

    func setupNavBarButtons(){
        
        //Botao de procurar
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtomItem =  UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        //Botao mais informaçoes
        let moreImage = UIImage(named:"nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage , style: .plain, target: self , action:#selector(handleMore))
        
        navigationItem.rightBarButtonItems = [searchBarButtomItem, moreButton]
    }
    
    func handleSearch(){
        print(1234)
    }
    
    func handleMore(){
        print(4567)
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format:"H:|[v0]|" , views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell

        if let video = videos?[indexPath.item]{
            cell.video = video
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heigth = (view.frame.width - 16 - 16)  * (9 / 16)
        return CGSize(width: view.frame.width, height: heigth + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }


}



