//
//  PhotoTableViewController.swift
//  Question5
//
//  Created by Justin Huang on 2016/12/2.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift
class PhotoTableViewController: UITableViewController {
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"TakePhotoViewController"), object: nil)
    }
    var photoDataBaseList2:Results<PhotoDataBase2List>!
    var photoDataBase:[Dictionary<String, String>]!
    var selectRowAtPhotoTableView:Int?
    var takePhotoImage:UIImage?
    @IBAction func takePhoto(_ sender: UIBarButtonItem) {
        lunchCamera()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(uiRealm.configuration.fileURL as Any)
        //資料庫如果沒有任何PhotoDataBase2List物件，則生成預設值
        //檢查PhotoDataBase2List類型的檔案有沒有至少一個存在
        if uiRealm.objects(PhotoDataBase2List.self).first == nil{
            let data1 = PhotoDataBase2(value:["1","神劍闖江湖-京都大火篇","https://upload.wikimedia.org/wikipedia/zh/3/3d/Rurouni_Kenshin,_Kyoto_Inferno_film_poster.jpg"])
            let data2 = PhotoDataBase2(value: ["2","神劍闖江湖-傳說的最終篇","http://pic.pimg.tw/akiyon/1415541476-2977688954.jpg"])
            let data3 = PhotoDataBase2(value: ["3","模仿遊戲","http://photocdn.sohu.com/20140910/Img404190751.jpg"])
            try! uiRealm.write {
                uiRealm.create(PhotoDataBase2List.self, value: ["1",[data1,data2,data3]], update: true)
            }
        }else{
            print("資料庫已經有值")
        }
        //從Realm資料庫中撈出id是1的PhotoDataBase2List物件
        photoDataBaseList2 = uiRealm.objects(PhotoDataBase2List.self).filter("id = '1'")
        photoDataBase = photoDatabase().photoDataBase
        if let database = UserDefaults.standard.array(forKey: "photoDataBase") as? [Dictionary<String,String>]{
            photoDataBase = database
        }
        NotificationCenter.default.addObserver(self, selector: #selector(PhotoTableViewController.addDataToDatabase(notification:)), name: NSNotification.Name(rawValue:"TakePhotoViewController"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        printDataBaseAndDoc()
        self.tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photoDataBaseList2[0].photoDataList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PhotoTableViewCell
        let imageUrl = URL(string: photoDataBaseList2[0].photoDataList[indexPath.row]["photoImageUrl"] as! String)
        cell.photoImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "NowLoading"))
        cell.dataLabel.text = photoDataBaseList2[0].photoDataList[indexPath.row]["photoLabel"] as? String
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRowAtPhotoTableView = indexPath.row
        performSegue(withIdentifier: "GoToDetailPhotoPage", sender: nil)
    }
    //執行刪除資料時,同時把photoDataBase的目前狀態寫入UserDefault中(先刪檔，才刪資料庫)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //對照片檔案進行刪除：
        if let UrlOfPhotoData = URL(string: photoDataBaseList2[0].photoDataList[indexPath.row].photoImageUrl){
            do{
                print("===UrlOfPhotoData:\(UrlOfPhotoData)====")
                try FileManager.default.removeItem(at:UrlOfPhotoData)
            }catch{
                print("delete PhotoData Fail")
            }
        }
        //對Realm資料庫進行刪除：
        try! uiRealm.write {
            uiRealm.delete(photoDataBaseList2[0].photoDataList[indexPath.row])
        }
        //動畫方式呈現刪除效果
        self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        //把最新資料存進UserDefault
        UserDefaults.standard.set(photoDataBase, forKey: "photoDataBase")
        UserDefaults.standard.synchronize()
        printDataBaseAndDoc()
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetailPhotoPage"{
            let destination = segue.destination as! PhotoDetailViewController
            destination.selectRowAtPhotoTableView = self.selectRowAtPhotoTableView
            destination.photoDataBaseList2 = self.photoDataBaseList2
        }
        if segue.identifier == "GoToTakePhotoPage"{
            let destination = segue.destination as! TakePhotoViewController
            destination.takePhotoImage = self.takePhotoImage
        }
    }
}
// MARK: - UIImagePicker
extension PhotoTableViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func lunchCamera(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        takePhotoImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        dismiss(animated: true, completion: {
            self.performSegue(withIdentifier: "GoToTakePhotoPage", sender: nil)
        })
    }
}

extension PhotoTableViewController{
    //將回傳過來的addData增加進photoDataBase
    func addDataToDatabase(notification:Notification){
        if let addData = notification.userInfo as? [String : PhotoDataBase2]{
            try! uiRealm.write {
               photoDataBaseList2[0].photoDataList.append(addData["1"]!)
            }
        }
    }
    func printDataBaseAndDoc(){
        let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileList = try! FileManager.default.contentsOfDirectory(atPath: (docUrl?.path)!)
        print("===DocFile:\(fileList)====")
        print("===PhotoDataBase:\(photoDataBase)====")
    }
}
