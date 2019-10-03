//
//  ViewController.swift
//  SoundWave
//
//  Created by Charanjit Singh on 27/09/19.
//  Copyright © 2019 Charanjit Singh. All rights reserved.
//

import UIKit
import AVFoundation

enum PITCH:Int {
    case veryLow = 10
    case low = 20
    case medium = 30
    case high = 40
    case veryHigh = 50
}


class ViewController: UIViewController {
    private var waves:[Wave] = []
    private var stop:Bool = false
    private var pitch:PITCH = .veryLow
    
    
    //Recorder
    var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DispatchQueue.main.async {
            self.view.backgroundColor = UIColor.black
            self.createWave()
        }
        
    }
  
    @IBAction func veryLow(_ sender: Any) {
        self.pitch = .veryLow
    }
    @IBAction func low(_ sender: Any) {
        self.pitch = .low
    }
    @IBAction func medium(_ sender: Any) {
        self.pitch = .medium
    }
    @IBAction func high(_ sender: Any) {
        self.pitch = .high
    }
    @IBAction func veryHigh(_ sender: Any) {
        self.pitch = .veryHigh
    }
    
    @IBAction func stop(_ sender: UIButton) {
        if sender.title(for: .normal) == "Stop" {
            sender.setTitle("Start", for: .normal)
            self.stop = true
        }
        else{
            self.stop = false
            sender.setTitle("Stop", for: .normal)
            self.animateWaves()
        }
    }
    
    private func createWave() {
        
        let pading:CGFloat = 5
        let waveWidth:CGFloat = 5
        let waveHight:CGFloat = 100
        let spaces:CGFloat = 2
        let mainWidth = UIScreen.main.bounds.width - 2*pading
        
        let numberOfWave = Int(mainWidth/waveWidth)
        
        var xVal:CGFloat = 10
        let topWaveHeight:CGFloat = waveHight/2
        for _ in 0..<numberOfWave {
            let wv = Wave.initFromNib()
            wv.frame = CGRect(x: xVal, y: 100, width: waveWidth, height: waveHight)
            wv.layer.cornerRadius = 4
            let number = CGFloat.random(in: 0 ... topWaveHeight)
            wv.top.constant = number
            wv.bottom.constant = number
            self.view.addSubview(wv)
            xVal += waveWidth + spaces
            waves.append(wv)
        }
        
        self.animateWaves()
    }
    
    
    private func animateWaves() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            for wave in self.waves {
               // let topWaveHeight = wave.frame.height/2
                let max:CGFloat = CGFloat(self.pitch.rawValue)
                let number = CGFloat.random(in: 0 ... max)
                wave.top.constant = number
                wave.bottom.constant = number
            }
            
            if !self.stop {
                self.animateWaves()
            }
        }
    }
    
}

