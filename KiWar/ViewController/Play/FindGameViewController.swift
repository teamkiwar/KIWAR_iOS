//
//  FindGameViewController.swift
//  KiWar
//
//  Created by 장용범 on 05/05/2019.
//  Copyright © 2019 장용범. All rights reserved.
//

import UIKit

class FindGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    

}
