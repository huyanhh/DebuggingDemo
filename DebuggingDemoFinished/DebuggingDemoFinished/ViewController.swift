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
        // regular print
        print(someView)
        // prints the object with date, time, process name, process id, thread, id
        NSLog("%@", someView)
        
        // ASSERTS
        // should go through
        //assert(heroes[heroes.endIndex-1] == "Hanzo")
        //assert(heroes[heroes.startIndex] == "Winston")
        
        // should fail
        //assert(heroes[heroes.endIndex] == "Tracer")
        //assert(heroes[heroes.endIndex-1] == "Hanzo")
        
        #if DEBUG
            print("Hello debugger!")
        #endif
        
        let ana = Hero()
        ana.ultPercentage = Percentage()
        print(ana.ultPercentage!) // bad
        guard let ult = ana.ultPercentage else { fatalError() } // better
        print(ult.number)
        
        print(heroes)
        addMoreHeroes(heroes: &heroes)
        print("after adding more heroes: \(heroes)")
        
        assert(heroes[heroes.endIndex-1] == "Mei")

        
        // debug a point
        let point: CGPoint = CGPoint(x: 1, y: 1)
        print(point)
        
        // debug a bezier path
        let rect = UIBezierPath(rect: CGRect(x: 1, y: 1, width: 5, height: 5))
        let layer = CAShapeLayer()
        layer.path = rect.cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.black.cgColor
        
        self.view.layer.addSublayer(layer)
    }
    
    func makeError() throws {
        print("hi im an error")
        throw Some.error
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
        // scroll a bunch of times with this breakpoint to see that dequeue actually works and the
        // debugger keeps on activating until you stop it
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        // stop at D.va
        cell.textLabel?.text = heroes[indexPath.row]
        
        // broken statement, will never execute, go through with debugger
        if indexPath.row == heroes.endIndex {
            cell.textLabel?.text = "Hanzo Main"
        }
        
//        print(self.heroes[self.heroes.endIndex])
        // DOES NOT COUNT AS EXCEPTION
        do {
            try makeError()
        } catch {
            print("hi i was caught")
        }
        
//        let e = NSException(name:NSExceptionName(rawValue: "name"), reason:"reason", userInfo:["key":"value"])
//        e.raise()
        
        return cell
    }
    
    
}
