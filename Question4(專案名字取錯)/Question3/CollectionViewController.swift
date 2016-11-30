//
//  CollectionViewController.swift
//  Question3
//
//  Created by Justin Huang on 2016/11/29.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import MessageUI
private let reuseIdentifier = "Cell"
class CollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout{
    let displayText = ["顯示一個AlertView","顯示藍色,點擊後變成紅色,再次點擊又變成藍色","透過CoreMotion顯示使用者現在的步數，並且即時更新","開啟APP在IOS設定的頁面","打開GoogleMap或是Web導航至AlphaCamp","開啟信箱並將標題寫上\"測試信件\""]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionCell
        // Configure the cell
        cell.cellLabel.text = displayText[indexPath.row]
        //自定義cell的邊框
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.black.cgColor
        if indexPath.row == 1{
            cell.backgroundColor = UIColor(red: 67.0/255.0, green: 148.0/255.0, blue: 248.0/255.0, alpha: 1)
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            lunchAlertController(alertTitle: "Alert打開了!", alertMessage: "恩好，沒事了")
        }
        if indexPath.row == 1{
            if collectionView.cellForItem(at: indexPath)?.backgroundColor != UIColor.red{
                collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.red
            }else{
                collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor(red: 67.0/255.0, green: 148.0/255.0, blue: 248.0/255.0, alpha: 1)
            }
        }
        if indexPath.row == 2{
            performSegue(withIdentifier: "GoToCoreMotionPage", sender: nil)
        }
        if indexPath.row == 3{
            performSegue(withIdentifier: "goToViewController", sender: nil)
        }
        if indexPath.row == 4{
            openGmap()
        }
        if indexPath.row == 5{
            openMailPage()
        }
    }
    //調整cell的外觀相關
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width/2, height: self.view.bounds.height/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(integerLiteral: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(integerLiteral: 0)
    }



    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
extension CollectionViewController{
    //生出一個AlertController
    func lunchAlertController(alertTitle:String,alertMessage:String){
        let alertController = UIAlertController(title: alertTitle, message:alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
//mail相關的method(注意這邊要遵從UINavigationControllerDelegate)
extension CollectionViewController:MFMailComposeViewControllerDelegate,UINavigationControllerDelegate{
    //打開寄mail頁面
    func openMailPage(){
        let mailController = MFMailComposeViewController()
        mailController.setSubject("測試信件")
        mailController.setToRecipients(["bigchocho@gmail.com"])
        mailController.setMessageBody("喔喔喔喔喔，這份考卷是Peter出的吧？", isHTML: false)
        present(mailController, animated: true, completion: nil)
        //這邊要注意必須用mailComposeDelegate
        mailController.mailComposeDelegate = self
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}


extension CollectionViewController{
//打開GoogleMap應用程式或用Safari開啟GoogleMap網站
    func openGmap(){
        let safariUrl = URL(string: "https://www.google.com.tw/maps/dir//104%E5%8F%B0%E5%8C%97%E5%B8%82%E4%B8%AD%E5%B1%B1%E5%8D%80%E5%8D%97%E4%BA%AC%E6%9D%B1%E8%B7%AF%E4%BA%8C%E6%AE%B597%E8%99%9F5+%E6%A8%93ALPHA+Camp/@25.0522726,121.4622187,12z/data=!3m1!4b1!4m8!4m7!1m0!1m5!1m1!1s0x3442a96126e64fb7:0xe844420ac13b2cb1!2m2!1d121.532259!2d25.052289?hl=zh-TW")

        let GmapAppUrl = URL(string: "comgooglemapsurl://www.google.com.tw/maps/dir//104%E5%8F%B0%E5%8C%97%E5%B8%82%E4%B8%AD%E5%B1%B1%E5%8D%80%E5%8D%97%E4%BA%AC%E6%9D%B1%E8%B7%AF%E4%BA%8C%E6%AE%B597%E8%99%9F5+%E6%A8%93ALPHA+Camp/@25.0522726,121.4622185,12z/data=!3m1!4b1!4m8!4m7!1m0!1m5!1m1!1s0x3442a96126e64fb7:0xe844420ac13b2cb1!2m2!1d121.532259!2d25.052289?hl=zh-TW")
        //ios10以上執行的方法
        if #available(iOS 10, *){
            //在iOS10以後open方法裡頭可回傳開啟Url是否成功的Bool，藉以取代舊版本的canOpenURL的方法
            UIApplication.shared.open(GmapAppUrl!, options: [:], completionHandler: { (bool:Bool) in
                guard bool else{
                    //如果沒有安裝GMapApp就打開普通GMap網址
                    UIApplication.shared.open(safariUrl!, options: [:], completionHandler: nil)
                    return
                }
            })
            //ios9以下的執行方法
        }else{
            if UIApplication.shared.canOpenURL(GmapAppUrl!){
                UIApplication.shared.openURL(GmapAppUrl!)
            }else{
                UIApplication.shared.openURL(safariUrl!)
            }
        }
    }
}
