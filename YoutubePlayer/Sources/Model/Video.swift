//
//  Video.swift
//  CloneTinder
//
//  Created by André Campopiano on 18/03/17.
//  Copyright © 2017 André Luís  Campopiano. All rights reserved.
//

import UIKit

class SafeJsonObject:NSObject{
    override func setValue(_ value: Any?, forKey key: String) {
        
        
        let uppercasedFirstCharacter = String(key.characters.first!).uppercased()
        
        let range = NSMakeRange(0, 1)
        let selectorString = NSString(string: key).replacingCharacters(in: range, with: uppercasedFirstCharacter)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if !responds {
            return
        }
        super.setValue(value, forKey: key)
    }
}

class Video:SafeJsonObject{
    
    var thumbnail_image_name: String?
    var title:String?
    var number_of_views: NSNumber?
    var upload_date: NSDate?
    var duration: NSNumber?
    
    var channel: Channel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "channel" {
            //custom channel setup
            self.channel = Channel()
            self.channel?.setValuesForKeys(value as! [String: AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
    }
    init(dictionary: [String: AnyObject]){
        super.init()
        setValuesForKeys(dictionary)
    }
}

class Channel: SafeJsonObject{
    
    var name:String?
    var profile_image_name:String?
    
    
}
