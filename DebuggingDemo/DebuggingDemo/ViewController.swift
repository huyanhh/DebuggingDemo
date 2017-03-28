//
//  ViewController.swift
//  DebuggingDemoFinished
//
//  Created by Huyanh Hoang on 2017. 3. 11..
//  Copyright © 2017년 huyanh. All rights reserved.
//

import UIKit

class Hero {
    var ultPercentage: Percentage?
}

class Percentage {
    var number = 100
}

enum Some: Error {
    case error
}

class ViewController: UIViewController {
    
    var heroes = ["Winston", "Tracer", "D.Va", "Genji", "Hanzo"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var someView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        cell.textLabel?.text = heroes[indexPath.row]

        return cell
    }
    
    
}
