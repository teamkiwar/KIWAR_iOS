//
//  MainViewController.swift
//  KiWar
//
//  Created by 장용범 on 17/03/2019.
//  Copyright © 2019 장용범. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = UIImageView.init(image: #imageLiteral(resourceName: "logotype"))
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "backBtn")
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "backgroundImg"))
       
    }

    
    @IBAction func goLearn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: StudyViewController.reuseIdentifier) as! StudyViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goGame(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: PlayViewController.reuseIdentifier) as! PlayViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func goDecorate(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: DecoViewController.reuseIdentifier) as! DecoViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func goDict(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: DictViewController.reuseIdentifier) as! DictViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
