//
//  dm_knw_article_collect.swift
//  PConnect-IOS
//
//  Created by 金飞 on 2018/9/14.
//  Copyright © 2018年 金飞. All rights reserved.
//

import Foundation

class glossary {
    
    var _id: Int!
    var _article_title: String!
    var _article_url: String!
    var _article_brief_desc: String!
    var _article_content: String!
    var _tag: String!
    var _tag_wait_for_done: String!
    var _author: String!
    var _word_write_time: Date!
    var _origin_write_time: Date!
    var _create_time: Date!
    var _last_timestamp: NSNumber!
    
    init(dict: NSDictionary) {
        self._id = dict.value(forKey: "id")! as! Int
        self._article_title = dict.value(forKey: "article_title")! as! String
        self._article_url = dict.value(forKey: "article_url")! as! String
        self._article_brief_desc = dict.value(forKey: "article_brief_desc")! as! String
        self._article_content = dict.value(forKey: "article_content")! as! String
        self._tag = dict.value(forKey: "tag") as! String
        self._tag_wait_for_done = dict.value(forKey: "tag_wait_for_done") as! String
        self._author = dict.value(forKey: "author") as! String
        self._word_write_time = dict.value(forKey: "word_write_time") as! Date
        self._origin_write_time = dict.value(forKey: "origin_write_time") as! Date
        self._create_time = dict.value(forKey: "create_time") as! Date
        self._last_timestamp = dict.value(forKey: "last_timestamp") as! NSNumber
        
    }
    
    class func getGlossary(handle: @escaping([glossary]?, URLResponse?, Error?) -> Swift.Void){
        let session: URLSession = URLSession.shared
        
        let task: URLSessionTask = session.dataTask(with: URL(string: "\(Config.ECSRestBaseUrl)/pconnect-knw/v1/glossary/getList/1")! , completionHandler: { (data:Data?, res:URLResponse?, err:Error?) in
            
            do {
                let dictData: NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                print(dictData)
                let arrayData: NSArray = dictData.object(forKey: "data") as! NSArray
                
                
                var list: [glossary] = []
                
                for i in 0 ..< arrayData.count {
                    list.append(glossary(dict: arrayData[i] as! NSDictionary))
                }
                
                handle(list, res, err)
                
                print("获取到的lessons:-------------------\(arrayData[0])")
            }catch let err as NSError {
                print(err.localizedDescription)
            }
            
            
        })
        task.resume()
    }
    
}
