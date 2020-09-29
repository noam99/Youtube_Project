//
//  ViewController.swift
//  Youtube_Project
//
//  Created by Noam Moyal on 27/09/2020.
//

import UIKit

class ViewController: UIViewController {
    
    var model = Model()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(5)
        // Do any additional setup after loading the view.
        model.getVideos()
    }


}

