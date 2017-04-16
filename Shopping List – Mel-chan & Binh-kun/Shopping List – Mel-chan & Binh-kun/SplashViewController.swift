//
//  ViewController.swift
//  Shopping List – Mel-chan & Binh-kun
//
//  Created by Thanh-Binh TANG on 15/12/2016.
//  Copyright © 2016 Thanh-Binh TANG. All rights reserved.
//

import UIKit

protocol SplashDelegate: class {
    func splashDidFinish()
}

class SplashViewController: UIViewController {

    weak var delegate:SplashDelegate?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.update), userInfo: nil, repeats: true);
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        activityIndicator.startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        activityIndicator.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        if let delegate = delegate {
            delegate.splashDidFinish()
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//    }
    

}
