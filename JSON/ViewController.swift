//
//  ViewController.swift
//  JSON
//
//  Created by Grace on 23/03/2018.
//  Copyright © 2018 Grace. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        Weather.forecast(withLocation: "-1.28333,36.81667") { (results:[Weather]) in
            for result in results {
                print("\(result)\n\n")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

