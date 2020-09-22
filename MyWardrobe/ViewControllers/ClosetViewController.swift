//
//  ClosetViewController.swift
//  MyWardrobe
//
//  Created by elliott kung on 2020-09-21.
//

import UIKit

class ClosetViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    private var collectionView: UICollectionView?
    
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
    }
    
    // TODO: call an capture image controller and allow user to take picture and add text to description
    @objc func addItem(){
        print("add")
    }
    
    // TODO: give user options to sort items based on certain descriptor categories
    @objc func sortItems(){
        print("filter")
    }

    // TODO: Add model for item with core data
    
    
    // collection view
    
    func layoutCollectionView() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-4, height: (view.frame.size.width/3)-4)
        
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.configure(label: "Custom \(indexPath.row)")
        
        return cell
    }
    
    // TODO: add VC for editing descriptors or items
    // TODO: add delete method
    
    
}
