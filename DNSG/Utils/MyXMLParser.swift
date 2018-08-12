//
//  XMLParser.swift
//  DNSG
//
//  Created by The Dung on 8/5/18.
//  Copyright © 2018 The Dung. All rights reserved.
//

import UIKit

class MyXMLParser: NSObject, XMLParserDelegate {
    
    var viewDelegate: NewsItemDelegate?
    private var newsItems: [NewsItem] = []
    private var currentTitle: String = "" {
        didSet {
            self.currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentPubDate: String = "" {
        didSet {
            self.currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDescribe: String = "" {
        didSet {
            self.currentDescribe = currentDescribe.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentAuthor: String = "" {
        didSet {
            self.currentAuthor = currentAuthor.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentLink: String = "" {
        didSet {
            self.currentLink = currentLink.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentElement: String = ""
    
    private var parserCompletionHandler: (([NewsItem]) -> Void)?
    
    func parseFeed (url: String, completionHandler: @escaping (([NewsItem]) -> Void)) {
        self.parserCompletionHandler = completionHandler
        let request = URLRequest (url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                    self.viewDelegate?.doWhenError()
                }
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
    }
    
    // MARK: Parser delegate:
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "title"{
            currentTitle = ""
            currentDescribe = ""
            currentPubDate = ""
            currentAuthor = ""
            currentLink = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
        case "title":
            currentTitle += string
        case "description":
            currentDescribe += string
        case "pubDate":
            currentPubDate += string
        case "author":
            currentAuthor += string
        case "link":
            currentLink += string
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let newsItem = NewsItem()
            newsItem.author = currentAuthor
            newsItem.title = currentTitle
            newsItem.describe = currentDescribe
            newsItem.link = currentLink
            newsItem.pubDate = currentPubDate
            self.newsItems.append(newsItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(newsItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
