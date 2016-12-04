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
    var photoDataBase = [
        ["photoImageUrl":"https://upload.wikimedia.org/wikipedia/zh/3/3d/Rurouni_Kenshin,_Kyoto_Inferno_film_poster.jpg",
         "photoLabel":"神劍闖江湖-京都大火篇"],
        [
            "photoImageUrl":"http://pic.pimg.tw/akiyon/1415541476-2977688954.jpg",
            "photoLabel":"神劍闖江湖-傳說的最終篇"],
        [
            "photoImageUrl":"http://photocdn.sohu.com/20140910/Img404190751.jpg",
            "photoLabel":"模仿遊戲"]
        ]

    var selectRowAtPhotoTableView:Int?
    var takePhotoImage:UIImage?
    @IBAction func takePhoto(_ sender: UIBarButtonItem) {
        lunchCamera()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
