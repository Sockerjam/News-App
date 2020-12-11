//
//  NewsListViewController.swift
//  News App
//
//  Created by Niclas Jeppsson on 04/12/2020.
//

import UIKit

class NewsListViewController: UIViewController {
    
    var webservice = Webservice()
    var articles:[Articles]?
    var dataSource:UICollectionViewDiffableDataSource<Sections, Articles>!
    
    var collectionView : UICollectionView = {
        
        let configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewSetup()
        
        webservice.delegate = self
        
        webservice.setup()
        
        listSetup()
        
    }
    
    func listSetup(){
        
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, Articles>
        { cell, indexPath, articles in
            
            
            var content = cell.defaultContentConfiguration()
            content.text = articles.title
            content.secondaryText = articles.description
            content.textProperties.color = .black
            cell.contentConfiguration = content

        }
        
        dataSource = UICollectionViewDiffableDataSource<Sections, Articles>(collectionView: collectionView){collectionView, indexPath, articleList in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: articleList)
            
        }
    }
    
    func snapShot(_ articleListViewModel:[Articles]){
        var snapShot = NSDiffableDataSourceSnapshot<Sections, Articles>()
        snapShot.appendSections([.main])
        snapShot.appendItems(articleListViewModel)
        dataSource.apply(snapShot)
        
    }
    
    
    func collectionViewSetup(){
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension NewsListViewController {
    enum Sections {
        case main
    }
}

extension NewsListViewController : ArticleDelegate {
    func updateArticles(data: [Articles]) {
        DispatchQueue.main.async {
            self.articles = data
            self.snapShot(self.articles!)
        }
    }
    
    
}
