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
    
    let feedCellId = "feedCellId"
    let trendingCellId = "trendingCell"
    let subscriptionCellId = "subscriptionCell"
    
    let titles = ["title_home", "title_trending", "title_subscriptions", "title_account"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x:0,y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = NSLocalizedString("title_home", comment: "")
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
        
    }
    
    func setupCollectionView(){
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: feedCellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView?.isPagingEnabled = true

    }
    
    func setupNavBarButtons(){
        
        //Botao de procurar
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtomItem =  UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        //Botao mais informaçoes
        let moreImage = UIImage(named:"nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage , style: .plain, target: self , action:#selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtomItem]
    }
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.listChannelController = self
        return launcher
    }()
    
    func handleMore(){
        
        settingsLauncher.showSettings()
    }
    
    func showControllerForSettings(setting:Setting) {
        let dummySettingsVewController = UIViewController()
        dummySettingsVewController.navigationItem.title = setting.name.rawValue
        dummySettingsVewController.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.pushViewController(dummySettingsVewController, animated: true)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    func handleSearch(){
       
    }
    
    func scrollToMenuIndex(menuIndex:Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at:indexPath as IndexPath , at: [], animated: true)
        setTitleForIndex(index: menuIndex)
    }
    
    private func setTitleForIndex(index: Int){
        if let titleLabel = navigationItem.titleView as? UILabel{
            titleLabel.text = NSLocalizedString(titles[index], comment: "")
        }
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.listChannelViewController = self
        return mb
    }()
    
    func setupMenuBar(){
        
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format:"H:|[v0]|" , views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index:Int = Int(targetContentOffset.pointee.x / view.frame.width)
        
        let indexPath = NSIndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        setTitleForIndex(index: index)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        switch indexPath.item {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedCellId, for: indexPath)
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: trendingCellId, for: indexPath)
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: subscriptionCellId, for: indexPath)
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedCellId, for: indexPath)
        }
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    
    
}



