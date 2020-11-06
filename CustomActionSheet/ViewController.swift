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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func didTapAction(){
        print("The action was trigger . . .")
    }

    @IBAction func didTapShowActionSheet(_ sender: Any) {
        let vc = CustomActionSheetWithImageViewController.init()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false, completion: nil)
    }
    
}


