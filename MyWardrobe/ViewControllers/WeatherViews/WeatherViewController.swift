//
//  WeatherViewController.swift
//  MyWardrobe
//
//  Created by elliott kung on 2020-09-21.
//

import UIKit

class WeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchControllerDelegate {
    
    // MARK: closet items
    
    var items:[Item]?
    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: WeatherVC components
    
    let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search a Location e.g Toronto, CA"
        searchController.searchBar.showsCancelButton = true
        return searchController
    }()
    
    let pageController = UIPageViewController()
    
    private var weatherCollectionView: UICollectionView?
    private var clothingItemsCollectionView: UICollectionView?
    
    var locationName = ""
    var locationTemp = ""
    var locationDescription = ""
    var weatherIcon = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Today's Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        self.navigationItem.searchController!.searchBar.delegate = self
        navigationController?.navigationBar.backgroundColor = .white
        
        weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutWeatherCollectionView())
        guard let weatherCollectionView = weatherCollectionView else { return }
        
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        
        view.addSubview(weatherCollectionView)
        setupConstraintsWeatherCollectionView()
        
        clothingItemsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutClothingItemsCollectionView())
        guard let clothingItemsCollectionView = clothingItemsCollectionView else { return }
        
        clothingItemsCollectionView.delegate = self
        clothingItemsCollectionView.dataSource = self
        
        view.addSubview(clothingItemsCollectionView)
        setupContraintsClothingItemsCollectionView()
        
        // Register cells
        
        weatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        
        clothingItemsCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        
        fetchItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchItems()
    }
    
    // MARK: WeatherCollectionView
    
    func fetchItems(){
        do{
            self.items = try context.fetch(Item.fetchRequest())
            
            DispatchQueue.main.async {
                self.clothingItemsCollectionView?.reloadData()
            }
            
        }catch{
            fatalError("could not fetch items")
        }
    }
    
    func setupConstraintsWeatherCollectionView(){
        weatherCollectionView!.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        weatherCollectionView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        weatherCollectionView!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        weatherCollectionView!.heightAnchor.constraint(equalToConstant: 200).isActive = true
        weatherCollectionView!.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
    
    func layoutWeatherCollectionView()-> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: (view.frame.size.width)-20, height: (view.frame.size.width/2)-10)
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
        clothingItemsCollectionView!.backgroundColor = UIColor.red.withAlphaComponent(0.1)
    }
    
    func layoutClothingItemsCollectionView() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: (view.frame.size.width/4), height: (view.frame.size.width/4))
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        return layout
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.weatherCollectionView{
            return 1
        }
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.weatherCollectionView{
            let cell = weatherCollectionView!.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
            
            if locationName != ""{
                cell.setLabel(location: "\(locationName) (\(String(locationTemp))) \(locationDescription)")
            }
            
            cell.setIcon(iconID: weatherIcon)
            
            return cell
        }else{
            let cell = clothingItemsCollectionView!.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
            
            let image = UIImage(data: (items![indexPath.row].itemImage)!)!
            cell.configureImage(image: image)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

extension WeatherViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("in search")
        let location = searchBar.text
        let weather = WeatherModel()
        weather.getWeatherData(location: location!){(weatherObj)
            in
            self.locationName = weatherObj.name
            self.locationTemp = String(Int(weatherObj.main.temp))
            self.itemSuggestions(temperature: Int(weatherObj.main.temp))
            self.locationDescription = weatherObj.weather[0].description
            self.weatherIcon = weatherObj.weather[0].icon
            self.weatherCollectionView?.reloadData()
            
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        
        fetchItems()
    }
    
    func itemSuggestions(temperature: Int){
        var season = ""
        if temperature >= 20{
            season = "summer"
        }else if temperature >= 8 && temperature <= 19{
            season = "fall"
        }else if temperature >= 1 && temperature <= 8{
            season = "spring"
        }else if temperature < 0{
            season = "winter"
        }
        
        items = items?.filter({ return
            
            $0.itemSeason == season
            
        })
        
        
        DispatchQueue.main.async {
            self.clothingItemsCollectionView?.reloadData()
        }
        
    }
    
}
