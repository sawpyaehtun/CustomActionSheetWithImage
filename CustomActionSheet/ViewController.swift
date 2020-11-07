//
//  ViewController.swift
//  CustomActionSheet
//
//  Created by saw pyaehtun on 06/11/2020.
//

import UIKit

struct ActionSheetType {
    let image : UIImage?
    let title: String?
    let action: (() -> Void)?
}

class ViewController: UIViewController {
    
    var actionSheetItemList : [ActionSheetType] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        createActionSheetItemList()
        // Do any additional setup after loading the view.
    }
    
    func createActionSheetItemList(){
        let actionOne = ActionSheetType(image: UIImage(systemName: "trash"), title: "Action One", action: didTapActionOne)
        let actionTwo = ActionSheetType(image: UIImage(systemName: "trash"), title: "Action Two", action: didTapActionTwo)
        let actionThree = ActionSheetType(image: UIImage(systemName: "trash"), title: "Action Three", action: didTapActionThree)
        actionSheetItemList = [actionOne,actionTwo,actionThree]
    }
    
    func didTapActionOne(){
        print("Did tap action one")
    }
    
    func didTapActionTwo(){
        print("Did tap action two")
    }
    
    func didTapActionThree(){
        print("Did tap action three")
    }
    
    func didTapAction(){
        print("The action was trigger . . .")
    }

    @IBAction func didTapShowActionSheet(_ sender: Any) {
        let vc = CustomActionSheetWithImageViewController.init()
        vc.actionSheetItemList = actionSheetItemList
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false, completion: nil)
    }
    
}


