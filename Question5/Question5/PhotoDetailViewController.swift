//
//  PhotoDetailViewController.swift
//  Question5
//
//  Created by Justin Huang on 2016/12/2.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    var photoImage:String?
    var photoTextfield:String?
    @IBOutlet weak var photoDetailImageView: UIImageView!
    @IBOutlet weak var photoDetailTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        photoDetailTextfield.text = photoTextfield
        photoDetailImageView.image = UIImage(named: photoImage!)
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
