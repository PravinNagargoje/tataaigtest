//
//  DetailsViewController.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Cosmos
import SKPhotoBrowser

class DetailsViewController: UIViewController {

    var tableView : UITableView = UITableView(
        frame: CGRect.zero,
        style: .grouped
    )
    var swipeView : UIView = UIView()
    var myCollectionView: UICollectionView!
    var indicator = MyIndicator()
    var pageControl : UIPageControl = UIPageControl()
    var detailsViewVM : DetailsViewViewModel!
    var serviceURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
        self.tableView.register(
            DetailsCustomTableViewCell.self,
            forCellReuseIdentifier: "textCell"
        )
        self.tableView.register(
            StarRatingCell.self,
            forCellReuseIdentifier: "starRatingCell"
        )
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)
        
        let tableViewConstraints : [NSLayoutConstraint] = [
            self.tableView.topAnchor.constraint(equalTo: view.topAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
        
    // MARK : Collection view layout
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        self.myCollectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: self.view.bounds.width,
                height: 200),
            collectionViewLayout: layout
        )
  
        self.myCollectionView.isPagingEnabled = true
        self.myCollectionView.dataSource = self
        self.myCollectionView.delegate = self
    
        self.myCollectionView.register(
            MovieCollectionViewCell.self,
            forCellWithReuseIdentifier: "MyCell"
        )
        self.swipeView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200))
        self.myCollectionView.backgroundColor = UIColor.gray
        indicator.StartActivityIndicator(obj: self.myCollectionView)
        self.swipeView.addSubview(myCollectionView)
        self.tableView.tableHeaderView = self.swipeView
        
    // MARK : UIPageControl
       
        configurePageControl()
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.bottomAnchor.constraint(equalTo: swipeView.bottomAnchor, constant : 8).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.pageControl.leadingAnchor.constraint(equalTo: self.swipeView.leadingAnchor).isActive = true
        self.pageControl.trailingAnchor.constraint(equalTo: self.swipeView.trailingAnchor).isActive = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor.white
        self.title = detailsViewVM.getTitle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        self.title = ""
    }
    
    //MARK : UIPageControl

    func configurePageControl() {
        self.pageControl.currentPage = 0
        self.pageControl.pageIndicatorTintColor = UIColor(netHex : 0xd6eaf8 )
        self.pageControl.currentPageIndicatorTintColor = UIColor(netHex: 0xd81b60 )
        self.swipeView.addSubview(pageControl)
        swipeView.bringSubviewToFront(pageControl)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = myCollectionView.contentOffset.x
        let w = myCollectionView.bounds.size.width
        self.pageControl.currentPage = Int(ceil(x/w))
    }
    
    func reloadView() {
        self.pageControl.numberOfPages = detailsViewVM.getMoviePosterArray().count
        if let cv = myCollectionView {
            cv.reloadData()
        }
        indicator.StopActivityIndicator()
    }
}

extension DetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.detailsViewVM.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailsViewVM.getRowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        let textCell = self.self.tableView.dequeueReusableCell(
            withIdentifier: "textCell",
            for: indexPath
            ) as! DetailsCustomTableViewCell
        
        if indexPath.section == 0 {
            textCell.updateData(data : self.detailsViewVM.getTitle())
            
            cell = textCell
        } else if indexPath.section == 1 {
            if let date = detailsViewVM.getDate() {
                textCell.updateData(data: DateFormatter.localizedString(
                    from: date,
                    dateStyle: .medium,
                    timeStyle: .none
                ))
            }
            
            cell = textCell
        } else if indexPath.section == 2 {
            let ratingCell = self.tableView.dequeueReusableCell(
                withIdentifier: "starRatingCell",
                for: indexPath
                ) as! StarRatingCell
            ratingCell.configureCell(rating : self.detailsViewVM.getRatings())
            
            cell = ratingCell
        } else if indexPath.section == 3 {
            textCell.updateData(data : self.detailsViewVM.getOverview())
            
            cell = textCell
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        return detailsViewVM.getSections()[section] as String
    }
}

extension DetailsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return self.detailsViewVM.colletionViewSectionCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.detailsViewVM.getArrayCount()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MyCell",
            for: indexPath) as! MovieCollectionViewCell
        cell.backgroundColor = UIColor.black
        cell.moviePoster.kf.indicatorType = .activity
        var URL: URL?
          URL = detailsViewVM.getMoviePosterArray()[indexPath.row].poster
        
        if let url = AppHelper.getImageURL(usingURL: URL) {
            cell.moviePoster.kf.setImage(with: url)
        }
        
        return cell
    }
}

extension DetailsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photos = self.detailsViewVM.getMoviePosterArray().map({
             SKPhoto.photoWithImageURL(
                 AppHelper.getImageURL(usingURL: $0.poster)!.absoluteString
             )
         })
         let browser = SKPhotoBrowser(photos: photos)
         browser.initializePageIndex(indexPath.row)
         present(browser, animated: true, completion: {})

    }
}

extension DetailsViewController:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.bounds.width, height: self.myCollectionView.bounds.height)
    }
}
