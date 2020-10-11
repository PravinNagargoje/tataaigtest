//
//  HomeScreenVC.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class HomeScreenVC: UIViewController {

    var myColletionView : UICollectionView!
    var homePageVM: HomePageViewModel!
    var activityIndicator = UIActivityIndicatorView()
    var segmentControl = UISegmentedControl()
    var rightButton = "search"
    var leftButton = "menu"
    var sectionNumber = 0
    var viewTitle = "Movies"
    var searchBarPlaceholder = "Enter movie name"
    var searchBar = UISearchBar()
    var logoImageView   : UIImageView!
    
    let barButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    let leftBarButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homePageVM = HomePageViewModel(homePageVC: self)
        self.view.backgroundColor = UIColor.gray
        
        setupActivityIndicator()
        setupCollectionView()
        setupSearchBar()
        setupSearchButton()
        setupLeftBarButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
        self.title = viewTitle
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            
        self.title = ""
    }
}

// Mark:- NavigationRightBarButton
extension HomeScreenVC: UISearchBarDelegate {
    
    func setupSearchButton() {

        self.barButton.setImage(UIImage(named: self.rightButton), for: .normal)
        self.barButton.addTarget(self, action: #selector(showSearchBar), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.barButton)
    }
   
    func setupSearchBar() {
        
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.backgroundColor = UIColor.clear
    }
    
    @objc func showSearchBar() {
        self.searchBarPlaceholder = "Enter movie name"
        searchBar.placeholder = self.searchBarPlaceholder
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.white

        searchBar.alpha = 0
        navigationItem.titleView = self.searchBar
        searchBar.tintColor = UIColor.white
        self.searchBar.becomeFirstResponder()
        searchBar.setShowsCancelButton(true, animated: true)
        navigationItem.setRightBarButton(nil, animated: true)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBar.alpha = 1
        }, completion: { finished in
        })
    }
    
    func hideSearchBar() {
        searchBar.alpha = 1
        self.navigationItem.titleView = self.logoImageView
        self.searchBar.text = ""
        self.homePageVM.fetchPopularMoviesData()
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBar.alpha = 0
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.barButton)
            self.searchBar.resignFirstResponder()
        }, completion: { finished in
            
        })
    }
    
    //MARK: UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar()
    }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async {
            searchText.count > 0 ? self.homePageVM.fetchSearchedMovies(movieName: searchBar.text!) : self.homePageVM.fetchPopularMoviesData()
            
        }
    }
    
    func setupActivityIndicator() {
        self.activityIndicator.style = UIActivityIndicatorView.Style.large
        self.activityIndicator.color = UIColor.white
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator = UIActivityIndicatorView(
            frame: CGRect(
                x: self.view.frame.width - 40,
                y: 75,
                width: 30,
                height: 30
        ))
        self.activityIndicator.backgroundColor = UIColor.gray
        self.view.addSubview(self.activityIndicator)
        self.view.bringSubviewToFront(self.activityIndicator)
        self.activityIndicator.startAnimating()

    }
}

// Mark:- NavigationLeftBarButton
extension HomeScreenVC {
    
    func setupLeftBarButton() {
        
        self.leftBarButton.setImage(UIImage(named: self.leftButton), for: .normal)
        self.leftBarButton.addTarget(self, action: #selector(menuButtonClickd(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.leftBarButton)
    }
    
    func switchLeftBarButton() {
        if self.leftButton == "menu" {
            self.leftButton = "back"
        } else {
            self.leftButton = "menu"
        }
        self.leftBarButton.setImage(UIImage(named: self.leftButton), for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.leftBarButton)
    }
    
    @objc func menuButtonClickd(_ sender : UIButton) {
        
        self.switchLeftBarButton()
        
        if (sender.tag == 10) {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1, section: 0)
            
            sender.tag = 0;
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        let menuVC : MenuViewController = MenuViewController()
        menuVC.menuButton = sender
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChild(menuVC)
        menuVC.view.layoutIfNeeded()
        
        menuVC.view.frame=CGRect(
            x: 0 - UIScreen.main.bounds.size.width,
            y: 0,
            width: UIScreen.main.bounds.size.width,
            height: UIScreen.main.bounds.size.height
        )
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.size.width,
                height: UIScreen.main.bounds.size.height
            )
            sender.isEnabled = true
        }, completion:nil)
    }
    
   func reloadCollectionView() {
        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseIn,
            animations:
            {
                if let cView = self.myColletionView {
                    cView.reloadData()
                }
               self.view.layoutIfNeeded()
        })

        self.activityIndicator.stopAnimating()
    }
}

extension HomeScreenVC: SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index: Int32, section: Int) {
        
        self.viewTitle = "Movies"
          
       switch(index) {
        case 0:
            self.homePageVM.sortByPopularity()
            self.switchLeftBarButton()
            print("Popular")
       case 1:
            self.homePageVM.sortByRating()
            self.switchLeftBarButton()
            print("Top Rated")
        default:
            print("default\n", terminator: "")
        }
        self.title = viewTitle
    }
}

//Mark: UICollectionView
extension HomeScreenVC {
    
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        view.backgroundColor = .gray
        
        self.myColletionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: self.view.frame.width,
                height: self.view.frame.height - 70),
            collectionViewLayout: layout
        )
        self.myColletionView.isPagingEnabled = false
        self.myColletionView.dataSource = self
        self.myColletionView.delegate = self
        self.myColletionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        self.myColletionView.backgroundColor = UIColor.gray
        self.view.addSubview(self.myColletionView)
    }
}

extension HomeScreenVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return self.homePageVM.moviesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(
            withReuseIdentifier: "myCell",
            for: indexPath) as! MyCollectionViewCell
        
            cell.cellConfig(movieData: self.homePageVM.getMoviesItem(index: indexPath.row))
          
        return cell
    }
}

extension HomeScreenVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailsViewController()
    
        detailViewController.detailsViewVM =  DetailsViewViewModel(
            DetailsVC: detailViewController,
            movie: self.homePageVM.getMoviesItem(index: indexPath.row), sectionNo: 0,
            search: false
        )
    
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension HomeScreenVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
        ) -> CGFloat {
        
        return homePageVM.getCellSpace()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
        ) -> CGFloat {
        
        return homePageVM.getCellSpace()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        
        return CGSize(width: self.view.bounds.width/3 - 10, height: self.view.bounds.height/4 - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
    }
}
