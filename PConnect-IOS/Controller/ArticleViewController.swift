//
//  ArticleViewController.swift
//  PConnect-IOS
//
//  Created by 金飞 on 2018/9/14.
//  Copyright © 2018年 金飞. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tbl_Article: UITableView!
    
    var _resultArticleList: [dm_knw_article_collect] = []
    
    var _selectedIndexPath: IndexPath? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tbl_Article.dataSource = self
        self.tbl_Article.delegate = self
        
        print(tbl_Article)
        
        dm_knw_article_collect.getDmKnwArticleCollectList { (articleList, res, err) in
            self._resultArticleList = articleList!
            DispatchQueue.main.async {
                self.tbl_Article.reloadData()
            }
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._resultArticleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleItem", for: indexPath)
        
        cell.textLabel?.text = self._resultArticleList[indexPath.row]._article_title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self._selectedIndexPath = indexPath
        self.performSegue(withIdentifier: "navToArticleDetail", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //跳转到预览页
        
        if (segue.identifier == "navToArticleDetail") {
            print(segue.destination)
            if let indexPath: IndexPath = self._selectedIndexPath {
                let advc: ArticleDetailViewController = segue.destination as! ArticleDetailViewController
                advc.detailsContent = (self._resultArticleList[indexPath.row]._article_content)!
            }
        }
    }
 

}
