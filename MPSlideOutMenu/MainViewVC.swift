//
//  ViewController.swift
//  MPSlideOutMenu
//
//  Created by Marian on 13/10/2017.
//  Copyright © 2017 MarianP. All rights reserved.
//

import UIKit


var windowSize = CGFloat()
public var menuWidthGap : CGFloat = 70

class MainViewVC: UIViewController {

    let setupMainView = MainViewSetup()
    
    var menuXConstant : NSLayoutConstraint!
    var viewXConstant : NSLayoutConstraint!
    
    var slideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the window
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        
        view.backgroundColor = UIColor.white
        
        navigationController?.isNavigationBarHidden = true
       
        NotificationCenter.default.addObserver(self, selector: #selector(menuButtonAction), name: NSNotification.Name("ToogleMenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(tapSelectedCell), name: NSNotification.Name("SelectedCell"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(viewTapped), name: NSNotification.Name("ViewTapped"), object: nil)
        
        setupMainView.mainViewVC = self
        setupMainView.setupViews()
        
        setupViewController()
        setupMenuViewController()
        
        windowSize = window.frame.size.width
        
        menuXConstant.constant = -windowSize
        viewXConstant.constant = 0
        
        print(window.frame.size.width)
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
//        view.isUserInteractionEnabled = true
//        view.addGestureRecognizer(tapGestureRecognizer)

        
    }
    
    func viewTapped() {
        slideMenuOpen = false
        self.menuXConstant.constant = -windowSize
        self.viewXConstant.constant = 0
        
        UIView.animate(withDuration: 0.3) {
            
            self.view.layoutIfNeeded()
            
        }

    }
    
    
    
    func tapSelectedCell() {
        print("tap to close")
        let window = UIScreen.main.bounds
        self.setupMainView.containerView.frame.size.width = window.width
        
        slideMenuOpen = false
        self.menuXConstant.constant = 0
        self.viewXConstant.constant = windowSize
        
        UIView.animate(withDuration: 0.3) {
            
            self.view.layoutIfNeeded()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                UIView.animate(withDuration: 0.2, animations: {
                    
                    self.menuXConstant.constant = -windowSize
                    self.viewXConstant.constant = 0
                    self.view.layoutIfNeeded()
                })
            })
            
        }
        
    }
    
    func menuButtonAction() {
        print("MENU TOOGLE")
        
        if slideMenuOpen {
            slideMenuOpen = false
            self.menuXConstant.constant = -windowSize
            self.viewXConstant.constant = 0
        } else {
            slideMenuOpen = true
            self.menuXConstant.constant = -menuWidthGap
            self.viewXConstant.constant = windowSize - menuWidthGap
        }
        
        UIView.animate(withDuration: 0.3) { 
            self.view.layoutIfNeeded()
        }
        
    }
    
    func setupMenuViewController() {
        let controller = MenuLeftVC()
        addChildViewController(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        menuXConstant = controller.view.centerXAnchor.constraint(equalTo: setupMainView.containerView.centerXAnchor, constant: 0)
        menuXConstant.isActive = true

        controller.view.centerYAnchor.constraint(equalTo: setupMainView.containerView.centerYAnchor).isActive = true
        controller.view.heightAnchor.constraint(equalTo: setupMainView.containerView.heightAnchor).isActive = true
        controller.view.widthAnchor.constraint(equalTo: setupMainView.containerView.widthAnchor).isActive = true
        
        controller.didMove(toParentViewController: self)
    }
    
    func setupViewController() {
        let controller = AnotherViewVC()
        
        let navBar: UINavigationController = UINavigationController(rootViewController: controller)
        addChildViewController(navBar)
        navBar.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar.view)
        
        viewXConstant = navBar.view.leftAnchor.constraint(equalTo: setupMainView.containerViewSlide.leftAnchor, constant: 0)
        viewXConstant.isActive = true
        
        navBar.view.centerYAnchor.constraint(equalTo: setupMainView.containerViewSlide.centerYAnchor).isActive = true
        navBar.view.heightAnchor.constraint(equalTo: setupMainView.containerViewSlide.heightAnchor).isActive = true
        navBar.view.widthAnchor.constraint(equalTo: setupMainView.containerViewSlide.widthAnchor).isActive = true
        
        
        
        navBar.didMove(toParentViewController: self)
    }
    
    

}

