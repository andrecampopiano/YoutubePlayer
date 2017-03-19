//
//  Video.swift
//  CloneTinder
//
//  Created by André Campopiano on 18/03/17.
//  Copyright © 2017 André Luís  Campopiano. All rights reserved.
//

import UIKit

class Video:NSObject{
    
    var thumbnailImageName: String?
    var title:String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
    
    
}

class Channel: NSObject{
    
    var name:String?
    var profileImageName:String?
    
    
}
