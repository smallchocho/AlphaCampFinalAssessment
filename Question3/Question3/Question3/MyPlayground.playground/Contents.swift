//: Playground - noun: a place where people can play

import UIKit
import SwiftyJSON
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
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
