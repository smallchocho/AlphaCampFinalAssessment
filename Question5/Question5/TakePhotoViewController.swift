//
//  TakePhotoViewController.swift
//  Question5
//
//  Created by Justin Huang on 2016/12/4.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import SDWebImage
class TakePhotoViewController: UIViewController{
    var takePhotoImage:UIImage?
    @IBOutlet weak var takePhotoImageView: UIImageView!
    @IBOutlet weak var takePhotoTextfield: UITextField!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.takePhotoImageView.image = takePhotoImage

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        savePhotoToDatabase()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TakePhotoViewController{
    func savePhotoToDatabase(){
        guard let image = takePhotoImage  else {
            print("takePhotoImage is nil")
            return
        }
        guard  takePhotoTextfield.text != nil && takePhotoTextfield!.text != "" else{
            print("takePhotoTextfield.text is nil or \"\"")
            return
        }
        let imageName = takePhotoTextfield.text!
        let imageUrl = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        let url = imageUrl?.appendingPathComponent(imageName)
        guard let imageData = UIImageJPEGRepresentation(image, 0.9) else{
            print("imageData is nil")
            return
        }
        try! imageData.write(to: url!)
        var addData:[String:String] = [
            "photoImageUrl":"",
            "photoLabel":""]
        addData["photoImageUrl"] = String(describing: url!)
        addData["photoLabel"] = imageName
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"TakePhotoViewController"), object: nil, userInfo: addData)
        print(addData)
    }
}
