//
//  ItemsViewController.swift
//  DNSG
//
//  Created by The Dung on 8/5/18.
//  Copyright © 2018 The Dung. All rights reserved.
//

import UIKit

protocol NewsItemDelegate: class {
    func doWhenError()
}

class ItemsViewController: UIViewController {
    @IBOutlet var loadingView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var tag: Int!
    private var newsItems: [NewsItem] = []
    private let cellIdentifier = "NewsItemIdentifier"
    private let seagueIdentifier = "NewsDetail"
    private var link: String = ""
    private var detailLink: String = ""
    
    @IBOutlet weak var newsListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        newsListTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        switch tag {
        case 0:
            link = AppConstants.NEWS_LINK
        case 1:
            link = AppConstants.BUSINESS_MAN_LINK
        case 2:
            link = AppConstants.GANERVANCE_LINK
        case 3:
            link = AppConstants.BUSINESS
        case 4:
            link = AppConstants.MULTIMEDIA_LINK
        case 5:
            link = AppConstants.TECHNOLOGY_LINK
        case 6:
            link = AppConstants.FORUM_LINK
        case 7:
            link = AppConstants.TRADE_CHANGE_LINK
        case 8:
            link = AppConstants.TRAVEL_LINK
        case 9:
            link = AppConstants.CULTURE_ARTS_LINK
        default:
            link = AppConstants.NEWS_LINK
        }
        if GeneralUtils.isConnectedToNetwork() {
            fetchData()
        }else {
            let alert = UIAlertController(title: NSLocalizedString("network_not_available_title", comment: ""), message: NSLocalizedString("network_not_available_message", comment: ""), preferredStyle: .alert)
            
            let action = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .cancel) { (_) in
                self.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(action)
            present(alert, animated: true) {
                // do nothing
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func fetchData() {
        showLoadingScreen()
        let feedParser = MyXMLParser()
        feedParser.viewDelegate = self
        feedParser.parseFeed(url: link) { (items) in
            self.newsItems = items
            
            OperationQueue.main.addOperation {
                self.hideLoadingScreen()
                self.newsListTableView.reloadData()
            }
        }
    }
    
    private func showLoadingScreen() {
        loadingView.bounds.size.width = view.bounds.width - 32
        loadingView.bounds.size.height = view.bounds.height - 150
        loadingView.center = view.center
        loadingIndicator.startAnimating()
        loadingView.alpha = 0
        view.addSubview(loadingView)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 1
        }) { (success) in
            
        }
    }
    
    private func hideLoadingScreen() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.loadingView.transform = CGAffineTransform(translationX: 0, y: -10)
        }) { (success) in
            UIView.animate(withDuration: 0.5, animations: {
                self.loadingView.transform = CGAffineTransform(translationX: 0, y: 1500)
            })
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! NewsViewController
        destinationVC.link = detailLink
    }

}

extension ItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NewsTableViewCell
        cell.setInformation(info: newsItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newsListTableView.deselectRow(at: indexPath, animated: true)
        detailLink = newsItems[indexPath.row].link
        performSegue(withIdentifier: seagueIdentifier, sender: self)
    }
}

extension ItemsViewController: NewsItemDelegate {
    func doWhenError() {
        let alert = UIAlertController(title: NSLocalizedString("something_went_wong", comment: ""), message: NSLocalizedString("can_not_finish", comment: ""), preferredStyle: .alert)
        
        let action = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .cancel) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(action)
        loadingView.isHidden = true
        present(alert, animated: true) {
            // do nothing
        }
    }
}
