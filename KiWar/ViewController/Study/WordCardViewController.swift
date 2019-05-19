//
//  WordCardViewController.swift
//  KiWar
//
//  Created by 장용범 on 17/03/2019.
//  Copyright © 2019 장용범. All rights reserved.
//

import UIKit

class WordCardViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var words : [Word] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "backgroundImg"))
        
        //self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        
        words = animals

    }
 
}

extension WordCardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: WordCardCollectionViewCell.reuseIdentifier, for: indexPath) as! WordCardCollectionViewCell
        cell.backView.layer.cornerRadius = 10
        cell.backView.layer.borderWidth = 1
        cell.backView.layer.borderColor = UIColor.lightGray.cgColor
        cell.imageView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        cell.imageView.image = words[indexPath.row].image
        cell.label.text = words[indexPath.row].mean
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 224)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
  
    
    
}
