//
//  ViewController.swift
//  DNSG
//
//  Created by The Dung on 7/29/18.
//  Copyright © 2018 The Dung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let cellIdentifier = "CategoryCellIdentifier"
    private let segueaIdentifier = "ListNewsView"
    private var categories: [String]!
    private var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = []
        categories.append(NSLocalizedString("news", comment: ""))
        categories.append(NSLocalizedString("business_man", comment: ""))
        categories.append(NSLocalizedString("gavernance", comment: ""))
        categories.append(NSLocalizedString("business", comment: ""))
        categories.append(NSLocalizedString("multimedia", comment: ""))
        categories.append(NSLocalizedString("technology", comment: ""))
        categories.append(NSLocalizedString("forum", comment: ""))
        categories.append(NSLocalizedString("trade_chance", comment: ""))
        categories.append(NSLocalizedString("travel", comment: ""))
        categories.append(NSLocalizedString("culture_arts", comment: ""))
        
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemsViewController
        destinationVC.tag = index
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CategoryTableViewCell
        cell.setInformation(title: categories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.index = indexPath.row
        performSegue(withIdentifier: self.segueaIdentifier, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

