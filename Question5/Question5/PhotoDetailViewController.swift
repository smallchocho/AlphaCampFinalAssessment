//
//  PhotoDetailViewController.swift
//  Question5
//
//  Created by Justin Huang on 2016/12/2.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import RealmSwift
class PhotoDetailViewController: UIViewController {
    @IBOutlet weak var photoDetailImageView: UIImageView!
    @IBOutlet weak var photoDetailTextfield: UITextField!
    @IBAction func shareButton(_ sender: UIBarButtonItem) {
        if photoDetailImageView.image != nil && photoDetailTextfield.text != nil{
            let activityViewController = UIActivityViewController(activityItems: [photoDetailImageView.image!,photoDetailTextfield.text!], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        }else{
            print("photoDetailImageView.image is nil or photoDetailTextfield.text is nil")
        }
    }
    var photoImage:String?
    var photoTextfield:String?
    var photoDataBaseList2:Results<PhotoDataBase2List>!
    var selectRowAtPhotoTableView:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard selectRowAtPhotoTableView != nil else {
            print("selectRowAtPhotoTableView is nil")
            return
        }
        photoImage = photoDataBaseList2[0].photoDataList[selectRowAtPhotoTableView!].photoImageUrl
        photoTextfield = photoDataBaseList2[0].photoDataList[selectRowAtPhotoTableView!].photoLabel
        let imageUrl = URL(string: photoImage!)
        self.photoDetailImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "NowLoading"))
        self.photoDetailTextfield.text = photoTextfield
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
extension PhotoDetailViewController:UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoDetailImageView
    }
}
