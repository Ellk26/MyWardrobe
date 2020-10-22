//
//  WeatherViewController.swift
//  MyWardrobe
//
//  Created by elliott kung on 2020-09-21.
//

import UIKit

class WeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    
    // MARK: WeatherVC components
    
    let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search a Location"
        searchController.searchBar.showsCancelButton = true
        return searchController
    }()
    
    private var weatherCollectionView: UICollectionView?
    private var clothingItemsCollectionView: UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Today's Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationController?.navigationBar.backgroundColor = .white
       
        weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutWeatherCollectionView())
        guard let weatherCollectionView = weatherCollectionView else { return }
        
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        //weatherCollectionView.backgroundColor = .blue
        
        view.addSubview(weatherCollectionView)
        setupConstraintsWeatherCollectionView()
        
        clothingItemsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutClothingItemsCollectionView())
        guard let clothingItemsCollectionView = clothingItemsCollectionView else { return }

        clothingItemsCollectionView.delegate = self
        clothingItemsCollectionView.dataSource = self
        
        view.addSubview(clothingItemsCollectionView)
        setupContraintsClothingItemsCollectionView()
        
        
    }
    
    // MARK: WeatherCollectionView
    
    func setupConstraintsWeatherCollectionView(){
        weatherCollectionView!.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        weatherCollectionView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        weatherCollectionView!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        weatherCollectionView!.heightAnchor.constraint(equalToConstant: 200).isActive = true
        weatherCollectionView!.backgroundColor = .blue
    }
    
    func layoutWeatherCollectionView()-> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-4, height: (view.frame.size.width/3)-4)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        return layout
    }
    
    func setupContraintsClothingItemsCollectionView(){
        clothingItemsCollectionView!.translatesAutoresizingMaskIntoConstraints = false
        clothingItemsCollectionView!.topAnchor.constraint(equalTo: weatherCollectionView!.bottomAnchor, constant: 5).isActive = true
        clothingItemsCollectionView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        clothingItemsCollectionView!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        clothingItemsCollectionView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        clothingItemsCollectionView!.backgroundColor = .red
    }
    
    func layoutClothingItemsCollectionView() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        
        return layout
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
    
}
