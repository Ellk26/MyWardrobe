//
//  ClosetViewController.swift
//  MyWardrobe
//
//  Created by elliott kung on 2020-09-21.
//

import UIKit

class ClosetViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource   {

    private var collectionView: UICollectionView?
    var items:[Item]?
    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(self.sortItems))
    
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutCollectionView())
        guard let collectionView = collectionView else { return }
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(self.longTap))
        self.view.addGestureRecognizer(longTap)
        
        fetchItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchItems()
    }
    
    // MARK: Add, Filter, Delete
    @objc func addItem(){
        print("add")
        let addItemVC = UINavigationController(rootViewController: AddItemViewController())
        addItemVC.modalPresentationStyle = .fullScreen
        present(addItemVC, animated: true)
    }
    
    // TODO: give user options to sort items based on certain descriptor categories
    @objc func sortItems(){
        print("filter")
    }
    
    @objc func longTap(){
        print("long tap")
    }

    // MARK: Core Data functions
    
    func fetchItems(){
        do{
            self.items = try context.fetch(Item.fetchRequest())
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            
        }catch{
            
        }
        
        
        
    }
    
    
    
    // MARK: CollectionView Functions
    
    func layoutCollectionView() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-4, height: (view.frame.size.width/3)-4)
        
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
//        cell.configure(label: "Custom \(indexPath.row)")
        
        let image = UIImage(data: (items![indexPath.row].itemImage)!)!
        cell.configureImage(image: image)
        
        return cell
    }
    
    
    
}// end of class
