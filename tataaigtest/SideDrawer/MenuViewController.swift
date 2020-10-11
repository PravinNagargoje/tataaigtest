//
//  MenuViewController.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32, section: Int)
}

class MenuViewController: UIViewController {
    
    var delegate : SlideMenuDelegate?
    var tableView = UITableView()
    var menuVM: MenuVM!
    var menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    var btnCloseMenuOverlay : UIButton! = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    
    let drawerColor = UIColor(netHex:  0xD1608C)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuVM = MenuVM(menuVC: self)
       
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// Mark:- UITableView

extension MenuViewController {
    
    func setupTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.register(
            CustomMenuCell.self,
            forCellReuseIdentifier: "customCell"
        )
        
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.isScrollEnabled = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = UIView()
        
        let constraints : [NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -150),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension MenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.menuVM.getSectionsCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuVM.menuCount(section: section)
    }
    
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(
            withIdentifier: "customCell",
            for: indexPath
            ) as! CustomMenuCell
        cell.backgroundColor = self.drawerColor
        cell.alpha = 1
        cell.configCell(menu: self.menuVM.getMenuItem(index: indexPath.row, section: indexPath.section))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return menuVM.getSections()[section]
    }
}

extension MenuViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.tag = Int("\(indexPath.section)\(indexPath.row)")!
        self.onCloseMenuClick(btn, section: indexPath.section)
    }
    
    func onCloseMenuClick(_ button:UIButton!, section: Int) {
        menuButton.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay) {
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index, section: section)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(
                x: -UIScreen.main.bounds.size.width,
                y: 0,
                width: UIScreen.main.bounds.size.width,
                height: UIScreen.main.bounds.size.height
            )
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
}
