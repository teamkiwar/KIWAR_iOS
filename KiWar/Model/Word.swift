//
//  Word.swift
//  KiWar
//
//  Created by 장용범 on 17/03/2019.
//  Copyright © 2019 장용범. All rights reserved.
//

import Foundation
import UIKit

struct Word {
    var name : String
    var mean : String
    var image : UIImage
}

let bighornsheep = Word(name: "BighornSheep", mean: "큰뿔양", image: #imageLiteral(resourceName: "bighorn sheep"))
let buffalo = Word(name: "Buffalo", mean: "버팔로", image: #imageLiteral(resourceName: "buffalo"))
let camel = Word(name: "Camel", mean: "낙타", image: #imageLiteral(resourceName: "camel"))
let cat = Word(name: "Cat", mean: "고양이", image: #imageLiteral(resourceName: "cat"))
let cow = Word(name: "Cow", mean: "소", image: #imageLiteral(resourceName: "buffalo"))
let dog = Word(name: "dog", mean: "개", image: #imageLiteral(resourceName: "dog1"))
let elephant = Word(name: "Elephant", mean: "코끼리", image: #imageLiteral(resourceName: "elephant"))
let ferret = Word(name: "Ferret", mean: "페럿", image: #imageLiteral(resourceName: "ferret"))
let fox = Word(name: "Fox", mean: "여우", image: #imageLiteral(resourceName: "fox"))
let gazelle = Word(name: "Gazelle", mean: "가젤", image: #imageLiteral(resourceName: "gazelle"))
let goat = Word(name: "Goat", mean: "염소", image: #imageLiteral(resourceName: "goat"))
let horse = Word(name: "Horse", mean: "말", image: #imageLiteral(resourceName: "horse"))
let lion = Word(name: "Lion", mean: "사자", image: #imageLiteral(resourceName: "lion"))
let mouse = Word(name: "Mouse", mean: "쥐", image: #imageLiteral(resourceName: "mouse"))
let otter = Word(name: "Otter", mean: "수달", image: #imageLiteral(resourceName: "otter"))
let panda = Word(name: "Panda", mean: "팬더", image: #imageLiteral(resourceName: "panda"))
let penguin = Word(name: "Penguin", mean: "펭귄", image: #imageLiteral(resourceName: "penguin"))
let pig = Word(name: "Pig", mean: "돼지", image: #imageLiteral(resourceName: "pig"))
let racoon = Word(name: "Raccoon", mean: "라쿤", image: #imageLiteral(resourceName: "racoon"))
let sheep = Word(name: "Sheep", mean: "양", image: #imageLiteral(resourceName: "sheep"))


let animals : [Word] = [bighornsheep,buffalo,camel,cat,cow,dog,elephant,ferret,fox,gazelle,goat,horse,lion,mouse,otter,panda,penguin,pig,racoon,sheep]
