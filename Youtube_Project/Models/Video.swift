//
//  Video.swift
//  Youtube_Project
//
//  Created by Noam Moyal on 28/09/2020.
//

import Foundation

struct Video: Decodable {
    
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var publishedDate = Date()
    
    enum CodingKeys: String, CodingKey{
        //we use String since we need to specify the json key name in case it dont matches, coding keys allow to pass the folowwing parameter in the init method below
        
        //so we assign to our var publishedDate the correspodning key we are interested in so, if name of variable is same of the key we dont need to put equal to "..."
        case publishedDate = "publishedAt"
        case title
        case videoId
        case description
        case thumbnail = "url" // to write the sequence to get to url (as we usually do with this method) we need to add the case you see below
        
        //to fetch all these JSON object we need to fetch in "snippet" so we add but also we add all the intermediary json keys needed to get the rest like url
        case snippet
        case thumbnails
        case high
        case resourceId
        
    }
    
    init (from decoder: Decoder) throws {
        //init akes the JSON data that we got and the decoder tell it which data type you want your JSON data to be but we also need to set the keys to access the JSON data (trough enum)
        let container = try decoder.container(keyedBy: CodingKeys.self) //where container its like saying the JSON object since it means the {}, ans we pass in the codingKeys that has the coding key protocol
        
        //we want to access the JSON container called snippet(its a key) and will assign the snippet data to the snippetContainer
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        //parse title
        self.title = try snippetContainer.decode(String.self, forKey: .title) //so we decode the key title of the snippetContainer as a string (we chose to decode a string data type)
        
        //parse description
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        //parse the publish date
        self.publishedDate = try snippetContainer.decode(Date.self, forKey: .publishedDate)
        
        //parse thumbnail
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        //parse videoID
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        self.videoId = try resourceIdContainer.decode(String.self, forKey: .videoId)
        
        //we need to parse in items to get the snippet so we create a new file called response with a struct called Response that is Decodable and we create a variable called items of data type [Video]
        
        
        
    }
    
}
