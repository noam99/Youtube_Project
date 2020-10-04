//
//  ViewController.swift
//  Youtube_Project
//
//  Created by Noam Moyal on 27/09/2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModelDelegate {
   
    
    @IBOutlet weak var tableView: UITableView!
    var model = Model()
    var videos = [Video]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        model.getVideos()
        
        //set itself as datasource and the delegate
        tableView.dataSource = self
        tableView.delegate = self
        model.delegate = self
        
    }
    //MARK: - Model Delegate Methods
    func videosFetched(_ videos : [Video]) {
        //set the returned videos to our video property
       
        self.videos = videos
        
        tableView.reloadData()
        
    }
    
    //MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath)
        
        //configure the cell with the data
        //get the title for the video in question
        
        let title = self.videos[indexPath.row].title
        cell.textLabel?.text = title
        
        //return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

