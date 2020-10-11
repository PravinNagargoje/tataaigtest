//
//  MenuVM.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//


import Foundation

class MenuVM {
    
    var menuVC: MenuViewController!
    let sections = ["Sort By"]
    let menuItems = ["Most Popular", "Highest Rated"]
    
    init(menuVC: MenuViewController) {
        self.menuVC = menuVC
    }
    
    func getMenuItem(index: Int, section: Int) -> String {
      
        return menuItems[index]
    }
    
    func getSectionsCount() -> Int {
        return self.sections.count
    }
    
    func menuCount(section: Int) ->Int {
       
        return self.menuItems.count
    }
    
    func getSections() -> [String] {
        return sections
    }
}
