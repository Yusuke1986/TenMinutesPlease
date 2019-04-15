//
//  ViewController.swift
//  TenMinutesPlease
//
//  Created by 松岡裕介 on 2019/04/15.
//  Copyright © 2019 松岡裕介. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    var timerCnt: Double = 0.0
    var timerCntInterval = 0.0
    var elapsedTime = 0.0
    var timer = Timer()
    var timerLabel = UILabel()
    var timerBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = UIView()
        view.backgroundColor = .white
        
        timerLabel.text = "10:00"
        timerLabel.font = UIFont.systemFont(ofSize: 64)
        timerLabel.textAlignment = .center
        
        timerBtn.setTitle("Start", for: .normal)
        timerBtn.backgroundColor = .red
        timerBtn.setTitleColor(.white, for: .normal)

        // ボタンを押した時に実行するメソッドを指定
        //Specify the method to be executed when the button is pressed
        timerBtn.addTarget(self, action: #selector(btnEvent(_:)), for: UIControl.Event.touchUpInside)
        
        newConstraints()
        
        view.addSubview(timerLabel)
        view.addSubview(timerBtn)
    }
    
    func newConstraints() {
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100.0),
            timerLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            timerLabel.heightAnchor.constraint(equalToConstant: 160)
            ])
        
        timerBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            timerBtn.topAnchor.constraint(equalTo: timerLabel.safeAreaLayoutGuide.bottomAnchor, constant: 20.0),
            timerBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            timerBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            timerBtn.heightAnchor.constraint(equalToConstant: 80)
            ])
    }
    
    @objc func btnEvent(_ sender: UIButton) {
        
        if timer.isValid == true {
            timer.invalidate()
            timerLabel.text = "10:00"
            timerCnt = 0.0
            timerCntInterval = 0.0
            timerBtn.setTitle("Start", for: .normal)
            
        }
        else {
                if timerCnt == 0.0 {
                    timerCnt = Date().timeIntervalSince1970
            }
            
                timer =  Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerCount), userInfo: nil, repeats: true)
                    
                timerBtn.setTitle("Stop", for: .normal)
        }
    }
    
    @objc func timerCount() {
        // 経過した時間を、現在の時刻-開始時刻で算出(秒)
        //Calculate the elapsed time as the current time-start time (seconds)
        elapsedTime = Date().timeIntervalSince1970 - timerCnt - timerCntInterval
        // 小数点以下を切り捨てる
        //Truncate following decimal point
        let flooredErapsedTime = Int(floor(elapsedTime))
        // 残り時間 10min (60sec * 10)
        //remaining time 10min (60sec * 10)
        let leftTime = 1 * 60 - flooredErapsedTime
        
        let mm: Int = leftTime / 60
        let ss: Int = leftTime % 60
        
        let displayString = NSString(format: "%02d:%02d", mm, ss) as String
        // ラベルを更新
        //update label
        timerLabel.text = displayString
        
        if leftTime == 0 {
            // タイマーを止める
            //Stop the timer
            timer.invalidate()
            timerLabel.text = "10:00"
            timerCnt = 0.0
            timerCntInterval = 0.0

            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            let alert = UIAlertController(title: "Finish", message: "10 minutes", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
}

