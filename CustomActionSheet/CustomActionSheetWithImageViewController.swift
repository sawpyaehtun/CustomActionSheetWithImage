//
//  CustomActionSheetWithImageViewController.swift
//  CustomActionSheet
//
//  Created by saw pyaehtun on 06/11/2020.
//

import UIKit

class CustomActionSheetWithImageViewController: UIViewController {
    
    @IBOutlet weak var viewActionSheetBackground: UIView!
    @IBOutlet weak var heightViewActionSheetBackground: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintViewActionSheet: NSLayoutConstraint!
    @IBOutlet weak var bottemConstrainttableViewActionSheetItemList: NSLayoutConstraint!
    @IBOutlet weak var tableViewActionSheetItemList: UITableView!
    
    var topTableViewActionSheetItemList : CGFloat = 20
    var actionSheetBackgroundHeight : CGFloat = 400
    var bottomTableViewActionSheetItemList : CGFloat = 35
    var cornerRadius : CGFloat = 30
    var actionSheetItemList : [ActionSheetType] = []
    var rowHeightTableView : CGFloat = "text".size(withAttributes:[.font: UIFont.systemFont(ofSize:18.0)]).height * 3
    var pointOrigin : CGPoint?
    
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
        /**
         Adding the tap gesture for dismissing our custom action sheet
         */
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        viewActionSheetBackground.isUserInteractionEnabled = true
        viewActionSheetBackground.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackgroundView))
        tapGesture.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
        setupTableView()
        
        /**
         table view bottom constraint for notch device
         */
        bottomTableViewActionSheetItemList = UIDevice.current.hasNotch ? 35 : 0
        bottemConstrainttableViewActionSheetItemList.constant = bottomTableViewActionSheetItemList
        
        /**
         reload the tableView to get contentSize
         */
        tableViewActionSheetItemList.reloadData()
        
        
        /**
         setting up the background size
         */
        actionSheetBackgroundHeight = (rowHeightTableView * CGFloat(actionSheetItemList.count)) + topTableViewActionSheetItemList + bottomTableViewActionSheetItemList
        self.heightViewActionSheetBackground.constant = actionSheetBackgroundHeight
        
    }
    
    private func setupTableView(){
        tableViewActionSheetItemList.delegate = self
        tableViewActionSheetItemList.dataSource = self
        tableViewActionSheetItemList.register(UINib(nibName: String(describing: InternetProviderPhoneItemTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: InternetProviderPhoneItemTableViewCell.self))
        tableViewActionSheetItemList.rowHeight = rowHeightTableView
        tableViewActionSheetItemList.bounces = false
    }
    
    private func playPresentAnimation(){
        UIView.animate(withDuration: 0.2) {
            self.view.alpha = 1
        } completion: { (_) in
            UIView.animate(withDuration: 0.3) {
                self.viewActionSheetBackground.center.y -= (self.actionSheetBackgroundHeight)
            } completion: { (_) in
                /**
                 save the origin
                 */
                self.pointOrigin = self.viewActionSheetBackground.frame.origin
            }
        }
    }
    
    private func playDismissAnimation(index : Int? = nil){
        
        UIView.animate(withDuration: 0.3) {
            self.viewActionSheetBackground.center.y += (self.actionSheetBackgroundHeight)
        } completion: { (_) in
            UIView.animate(withDuration: 0.2) {
                self.view.alpha = 0
            } completion: { (_) in
                self.dismiss(animated: false) {
                    if  let index = index,
                        let action = self.actionSheetItemList[index].action{
                        action()
                    }
                }
            }
        }
        
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        viewActionSheetBackground.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                // Velocity fast enough to dismiss the uiview
                self.playDismissAnimation()
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.viewActionSheetBackground.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    @objc func didTapBackgroundView(){
        self.playDismissAnimation()
    }
    
}

extension CustomActionSheetWithImageViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionSheetItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InternetProviderPhoneItemTableViewCell.self), for: indexPath) as! InternetProviderPhoneItemTableViewCell
        cell.setupCell(phoneNumber: actionSheetItemList[indexPath.row].title ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        playDismissAnimation(index: indexPath.row)
    }
    
}

extension CustomActionSheetWithImageViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        touch.view == self.view
    }
}
