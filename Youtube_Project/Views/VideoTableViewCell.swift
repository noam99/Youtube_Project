//
//  VideoTableViewCell.swift
//  Youtube_Project
//
//  Created by Noam Moyal on 05/10/2020.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var video: Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ v:Video){
        
        self.video = v
        
        //ensure that we have a video
        guard self.video != nil else {
            return
        }
        
        //set the title and date label
        self.titleLabel.text = video?.title
        
        //set the date label
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy" //NSDateFormatter.com
        self.dateLabel.text = df.string(from: video!.publishedDate)
        
        //set the thumbnail
        guard self.video!.thumbnail != "" else {
            return
        }
        
        //Check cache before downloading data
        if let cachedData = CacheManager.getVideoCache(self.video!.thumbnail){
            self.thumbnailImageView.image = UIImage(data: cachedData)
        }
        
        //download thumbnail data
        let url = URL(string: self.video!.thumbnail)
        
        //get the shared URL session object
        let session = URLSession.shared
        
        //create a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil{
                
                //save the data in the cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                //check that the download url matches the video thumbnail url that the cell is currently set to display
                if url!.absoluteString != self.video?.thumbnail{
                    //video cell has been recycled for a new video and no longer matches the thumbnail that was downloaded
                    return
                }
                
                //create the image object
                let image = UIImage(data: data!)
                
                //set the imageView and use dispatch since we need to pass data obtained in the background to the main thread
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
                
            }
        }
        //start the data task
        dataTask.resume()
    }
}


