//
//  CoreMotionViewController.swift
//  Question3
//
//  Created by Justin Huang on 2016/11/30.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import CoreMotion
class CoreMotionViewController: UIViewController {
    let motionManager = CMMotionManager()
    let pedometer = CMPedometer()
    var resultMotion = 0
    @IBOutlet weak var directXValue: UILabel!
    @IBOutlet weak var directYValue: UILabel!
    @IBOutlet weak var directZValue: UILabel!
    @IBOutlet weak var motionCountValue: UILabel!
    @IBAction func startMotion(_ sender: UIButton) {
        
        lucnchCoreMotion()
    }
    @IBAction func stopMotion(_ sender: UIButton) {
        pedometer.stopUpdates()
        motionManager.stopDeviceMotionUpdates()
        self.resultMotion = 0
    }
    @IBAction func backToMainPage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()


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
    // MARK: - 打開CMMotionManager
    func lucnchCoreMotion(){
        //確認能不能開啟CMMotionManager
        guard motionManager.isDeviceMotionAvailable else{
            print("DeviceMotion is not Available")
            return
        }
        //確認現在CMMotionManage有沒有啟動中如果沒有啟動
        guard motionManager.isDeviceMotionActive else{
            print("DeviceMotion is not Active")
            motionManager.deviceMotionUpdateInterval = 0.45
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!){(deviceManager, error) in
                let complexAcceleration = sqrt(deviceManager!.userAcceleration.x * deviceManager!.userAcceleration.x + deviceManager!.userAcceleration.y * deviceManager!.userAcceleration.y + deviceManager!.userAcceleration.z * deviceManager!.userAcceleration.z)
                if complexAcceleration > 0.2{
                    self.resultMotion += 1
                }
                self.directXValue.text = String(deviceManager!.userAcceleration.x.roundTo(places: 2))
                self.directYValue.text = String(deviceManager!.userAcceleration.y.roundTo(places: 2))
                self.directZValue.text = String(deviceManager!.userAcceleration.z.roundTo(places: 2))
                self.motionCountValue.text = String(self.resultMotion)
                print("\(deviceManager!.userAcceleration)") // no print
                print("\(self.resultMotion)")
            }
            //            print("====\(backValue)====")
            //            print("====\(motionManager.isDeviceMotionActive)====")
            return
        }
        
    }
}
extension CoreMotionViewController{
    func lunchPedometer(){
        if(CMPedometer.isStepCountingAvailable()){
            self.pedometer.startUpdates(from: Date()) { (data: CMPedometerData?, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    guard error != nil else{
                        return
                    }
                    guard let stepData = data else{
                        return
                    }
                    self.motionCountValue.text = String(describing: stepData.numberOfSteps)
                })
            }
        }
    }
}
//四捨五入的方法
extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
