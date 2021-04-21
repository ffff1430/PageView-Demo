//
//  ViewController.swift
//  PageView-Demo
//
//  Created by star on 2021/4/20.
//  Copyright © 2021 star. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var scrollUIView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    
    lazy var scrollButton: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    var viewArray: [UIView] = []
    var buttonArray: [UIButton] = []
    var tempSenderTag = 0
    var a: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        scrollButton.translatesAutoresizingMaskIntoConstraints = false
        scrollUIView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollButton)
        view.addSubview(scrollUIView)
        
        scrollButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        scrollButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        scrollButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollUIView.topAnchor.constraint(equalTo: scrollButton.bottomAnchor, constant: 10).isActive = true
        scrollUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        scrollUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        setTabButton()
        setScrollUIView()
    }
    
    func setTabButton() {
        let buttontitleArray = ["button1", "button2", "button3", "button4", "button5", "button6"]
        var xPosition = 0
        for (index, buttontitle) in buttontitleArray.enumerated() {
            let customButton = UIButton()
            buttonArray.append(customButton)
            scrollButton.addSubview(buttonArray[index])
            customButtonStyle(button: buttonArray[index])
            buttonArray[index].frame = CGRect(x: xPosition, y: 0, width: 100, height: 50)
            xPosition += 100
            buttonArray[index].tag = index
            buttonArray[index].setTitle( buttontitle, for: .normal)
            buttonArray[index].addTarget(self, action: #selector(self.action), for: .touchUpInside)
        }
        scrollButton.contentSize = CGSize(width: xPosition, height: 50)
        buttonArray[tempSenderTag].backgroundColor = .black
    }
    
    func setScrollUIView() {
        var viewXposition: CGFloat = 0
        let width = view.frame.size.width
        let height = view.frame.size.height - 110
        for index in 0..<6 {
            let view = UIView()
            viewArray.append(view)
            scrollUIView.addSubview(viewArray[index])
            customViewStyle(view: viewArray[index])
            viewArray[index].frame = CGRect(x: viewXposition, y: 0, width: width, height: height)
            viewXposition += width
        }
        scrollUIView.contentSize = CGSize(width: viewXposition, height: height)
    }
    
    func changeTabColor(page: Int) {
        guard page != tempSenderTag else {
            return
        }
        print("\(page) $$ \(tempSenderTag)")
        buttonArray[tempSenderTag].backgroundColor = .gray
        tempSenderTag = page
        buttonArray[page].backgroundColor = .black
    }
    
    @objc func action(_ sender: UIButton) {
        var rect = scrollUIView.frame
        rect.origin.x = CGFloat(Int(scrollUIView.frame.size.width) * sender.tag)
        scrollUIView.scrollRectToVisible(rect, animated: true)
    }
    
    func customButtonStyle(button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.borderWidth = 1.5
        button.layer.borderColor = CGColor(srgbRed: 242.0, green: 242.0, blue: 247.0, alpha: 1)
    }
    
    func customViewStyle(view: UIView) {
        view.backgroundColor = UIColor.random
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x / view.frame.width))
        changeTabColor(page: pageIndex)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
