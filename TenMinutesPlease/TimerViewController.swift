//
//  TimerViewController.swift
//  TenMinutesPlease
//
//  Created by 松岡裕介 on 2019/04/15.
//  Copyright © 2019 松岡裕介. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    var timerBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view = UIView()
        view.backgroundColor = .white
        
        timerBtn.setTitle("Start", for: .normal)
        timerBtn.backgroundColor = .red
        timerBtn.setTitleColor(.white, for: .normal)
        
        newConstraints()
        
        view.addSubview(timerBtn)
        // Do any additional setup after loading the view.
    }
    
    func newConstraints() {
        timerBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            timerBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            timerBtn.widthAnchor.constraint(equalTo: view.widthAnchor),
            timerBtn.heightAnchor.constraint(equalToConstant: 80)
            ])
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
