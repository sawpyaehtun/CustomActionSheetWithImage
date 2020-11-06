//
//  ViewController.swift
//  CustomActionSheet
//
//  Created by saw pyaehtun on 06/11/2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapShowActionSheet(_ sender: Any) {
        let vc = CustomActionSheetWithImageViewController.init()
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false, completion: nil)
    }
    
}

extension ViewController : CustomActionSheetWithImageViewControllerDelegate {
    
    func didSelectItem(at index: Int) {
        
    }
    
}

