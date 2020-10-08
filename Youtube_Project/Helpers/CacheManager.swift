//
//  CacheManager.swift
//  Youtube_Project
//
//  Created by Noam Moyal on 06/10/2020.
//

import Foundation

class CacheManager{
    
    static var cache = [String:Data]()
    
    static func setVideoCache(_ url: String, _ data: Data?){
        //store the image data and the url as the key
        cache[url] = data
    }
    
    static func getVideoCache(_ url: String) -> Data?{ //return nil if that url doesnt exist in our cache
        //try to get the data for the specified url
        return cache[url]
    }
    
}
