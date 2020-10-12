//
//  Model.swift
//  Youtube_Project
//
//  Created by Noam Moyal on 28/09/2020.
//
//everything in {} is a json object and its basically made of key:value pairs and i can have as value a collection of JSON object son new key:value pairs
//decodable gives us the possibility to give isntruction to how to translate JSON in the Swift objecy we created

import Foundation

protocol ModelDelegate {
    func videosFetched(_ videos: [Video])
}

class Model {
    
    var delegate:ModelDelegate?
    
    func getVideos(){
        //create a URL object
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else {
            print("failed")
            return
        }
        //get a URLsession object
        let session = URLSession(configuration: .default)
        
        //get a data task from the URLsession object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //check if there is no error
            if error != nil || data == nil{
                return
            }
            
            
            do{
                //parsing the data into video objects
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601  //specifying the date type transformation from string
                
                let responseAPI = try decoder.decode(Response.self, from: data!)
                
                if responseAPI.items != nil{
                    
                //call the "videoFetched" method of the delegate
                   DispatchQueue.main.async {
                        self.delegate?.videosFetched(responseAPI.items!)
                   }
                   
                }
                //dump(responseAPI)
                
            }catch{
                
            }
            
        }
        //kick off the task
        dataTask.resume()
    }
}
