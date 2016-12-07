//
//  ViewController.swift
//  Question3
//
//  Created by Justin Huang on 2016/11/30.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import SwiftyJSON
class ViewController: UIViewController {
    @IBAction func sendGet(_ sender: UIButton) {
        getOringin()
    }
    @IBAction func sendPost(_ sender: UIButton) {
        postRequest()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getOringin(){
        let url = URL(string: "https://httpbin.org/get")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: {
            (data:Data?, response:URLResponse?, error:Error?) in
            guard error == nil else{
                print("拿取JSON失敗")
                return
            }
            guard let downloadData = data else{
                print("沒有JSON資料喔")
                return
            }
            let jsonData = JSON(data: downloadData)
            let originString = jsonData["origin"].stringValue
            NSLog(originString)
        })
        dataTask.resume()
    }
    func postRequest(){
        let url = URL(string: "https://httpbin.org/post")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let postDate = Date()
        let dateFormatter = DateFormatter()
        let postDateString = dateFormatter.string(from: postDate)
        let postBody = ["time": postDateString]
        let postBodyData = try! JSONSerialization.data(withJSONObject: postBody, options: JSONSerialization.WritingOptions.prettyPrinted)
        let uploadTask = URLSession.shared.uploadTask(with: request, from: postBodyData, completionHandler: {
            (data:Data?, response:URLResponse?,error:Error?) in
            guard response != nil else{
                print("沒收到response")
                return
            }
            let recieveDate = Date()
            let diffOfDate = recieveDate.timeIntervalSince(postDate)
            NSLog("花了\(diffOfDate)秒")
        })
        uploadTask.resume()
    }
}

