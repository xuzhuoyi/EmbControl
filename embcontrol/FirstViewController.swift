//
//  FirstViewController.swift
//  embcontrol
//
//  Created by 徐卓异 on 15/6/20.
//  Copyright © 2015年 LDE Team. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var labelldever: UILabel!
    @IBOutlet weak var labelserverinfo: UILabel!
    @IBOutlet weak var labelstatus: UILabel!
    @IBAction func onBtnFindTouchUpi(sender: AnyObject) {
        inConnectingStatus()
        let ldecloud=LDECloud()
        labelldever.text=ldecloud.testtcpclient()
        labelstatus.text="连接成功！"
    }
    
    func inConnectingStatus() {
        labelstatus.text="正在连接服务器……"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

