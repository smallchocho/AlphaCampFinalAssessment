//
//  TakePhotoViewController.swift
//  Question5
//
//  Created by Justin Huang on 2016/12/4.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import SDWebImage
class TakePhotoViewController: UIViewController {
    var takePhotoImage:UIImage?
    @IBOutlet weak var takePhotoImageView: UIImageView!
    @IBOutlet weak var takePhotoTextfield: UITextField!
    override func viewDidLoad(){
        super.viewDidLoad()
        self.takePhotoImageView.image = takePhotoImage

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
