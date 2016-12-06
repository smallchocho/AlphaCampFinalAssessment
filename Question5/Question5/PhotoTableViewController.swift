//
//  PhotoTableViewController.swift
//  Question5
//
//  Created by Justin Huang on 2016/12/2.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import SDWebImage
class PhotoTableViewController: UITableViewController {
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"TakePhotoViewController"), object: nil)
    }
    var photoDataBase:[Dictionary<String, String>]!
    var selectRowAtPhotoTableView:Int?
    var takePhotoImage:UIImage?
    @IBAction func takePhoto(_ sender: UIBarButtonItem) {
        lunchCamera()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return photoDataBase.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PhotoTableViewCell
        let imageUrl = URL(string: photoDataBase[indexPath.row]["photoImageUrl"]!)
        cell.photoImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "NowLoading"))
        cell.dataLabel.text = photoDataBase[indexPath.row]["photoLabel"]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRowAtPhotoTableView = indexPath.row
        performSegue(withIdentifier: "GoToDetailPhotoPage", sender: nil)
    }
    //執行刪除資料時,同時把photoDataBase的目前狀態寫入UserDefault中
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let UrlOfPhotoData = URL(string: photoDataBase[indexPath.row]["photoImageUrl"]!){
            do{
                print("===UrlOfPhotoData:\(UrlOfPhotoData)====")
                try FileManager.default.removeItem(at:UrlOfPhotoData)
            }catch{
                print("delete PhotoData Fail")
            }
        }
        photoDataBase.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
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
            destination.photoDataBase  = self.photoDataBase
            destination.selectRowAtPhotoTableView = self.selectRowAtPhotoTableView
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
    //將回傳過來的addData增加進photoDataBase，並且將目前photoDataBase的值存進UserDefault
    func addDataToDatabase(notification:Notification){
        if let addData = notification.userInfo as? [String : String]{
            photoDataBase.append(addData)
            UserDefaults.standard.set(photoDataBase, forKey: "photoDataBase")
            UserDefaults.standard.synchronize()
        }
    }
    func printDataBaseAndDoc(){
        let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileList = try! FileManager.default.contentsOfDirectory(atPath: (docUrl?.path)!)
        print("===DocFile:\(fileList)====")
        print("===PhotoDataBase:\(photoDataBase)====")
    }
}
