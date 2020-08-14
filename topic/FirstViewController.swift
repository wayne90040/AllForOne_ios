//
//  FirstViewController.swift
//  topic
//
//  Created by 許維倫 on 2019/5/18.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit
import Lottie

// 開app動畫
class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setAnimation()
        
    }
    
    func setAnimation(){
        let animationview = AnimationView(name: "firstview")
        animationview.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationview.center = self.view.center
        animationview.contentMode = .scaleAspectFill
        animationview.loopMode = .autoReverse
        view.addSubview(animationview)
        
        
        animationview.play(completion: { (finished) in
            // Do Something
        })
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
