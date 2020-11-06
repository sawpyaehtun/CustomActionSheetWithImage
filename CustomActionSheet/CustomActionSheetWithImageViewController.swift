//
//  CustomActionSheetWithImageViewController.swift
//  CustomActionSheet
//
//  Created by saw pyaehtun on 06/11/2020.
//

import UIKit

protocol CustomActionSheetWithImageViewControllerDelegate {
    func didSelectItem(at index : Int)
}

class CustomActionSheetWithImageViewController: UIViewController {
    
    @IBOutlet weak var viewActionSheetBackground: UIView!
    @IBOutlet weak var heightViewActionSheetBackground: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintViewActionSheet: NSLayoutConstraint!
    
    var actionSheetBackgroundHeight : CGFloat = 400
    var cornerRadius : CGFloat = 30
    
    var delegate : CustomActionSheetWithImageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareForPresentAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playPresentAnimation()
    }
    
    private func prepareForPresentAnimation(){
        self.view.alpha = 0
        bottomConstraintViewActionSheet.constant -= actionSheetBackgroundHeight
        viewActionSheetBackground.layer.cornerRadius = cornerRadius
        viewActionSheetBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupUI(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackgroundView))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
        self.heightViewActionSheetBackground.constant = actionSheetBackgroundHeight
    }
    
    
    private func playPresentAnimation(){
        UIView.animate(withDuration: 0.2) {
            self.view.alpha = 1
        } completion: { (_) in
            UIView.animate(withDuration: 0.3) {
                self.viewActionSheetBackground.center.y -= (self.actionSheetBackgroundHeight)
            }
        }
    }
    
    private func playDismissAnimation(){
        
        UIView.animate(withDuration: 0.3) {
            self.viewActionSheetBackground.center.y += (self.actionSheetBackgroundHeight)
        } completion: { (_) in
            UIView.animate(withDuration: 0.2) {
                self.view.alpha = 0
            } completion: { (_) in
                self.dismiss(animated: false, completion: nil)
            }
            
        }
        
    }
    
    @objc func didTapBackgroundView(){
        self.playDismissAnimation()
    }
    
}