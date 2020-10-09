//
//  ClosetViewController.swift
//  MyWardrobe
//
//  Created by elliott kung on 2020-09-21.
//

import UIKit

class ClosetViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout   {
    
    private var collectionView: UICollectionView?
    
    var items:[Item]?
    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    enum Mode{
        case view
        case select
    }
    
    var mMode: Mode = .view{
        didSet{
            switch mMode {
            case .view:
                for (key, value) in dictionarySelectedIndexPath{
                    if value{
                        collectionView?.deselectItem(at: key, animated: true)
                    }
                }
                dictionarySelectedIndexPath.removeAll()
                
                selectBarBtn.title = "Select"
                navigationItem.rightBarButtonItem = addBarBtn
                navigationItem.leftBarButtonItem = selectBarBtn
                collectionView?.allowsMultipleSelection = false
            case .select:
                selectBarBtn.title = "Cancel"
                navigationItem.leftBarButtonItem = deleteBarBtn
                navigationItem.rightBarButtonItem = selectBarBtn
                collectionView?.allowsMultipleSelection = true
            }
        }
    }
    
    lazy var selectBarBtn: UIBarButtonItem = {
        let barBtnItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(didSelectButtonClicked(_:)))
        return barBtnItem
    }()
    
    lazy var deleteBarBtn: UIBarButtonItem = {
        let barBtnItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didDeleteButtonClicked(_:)))
        return barBtnItem
    }()
    
    lazy var addBarBtn: UIBarButtonItem = {
        let barBtnItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addItem))
        return barBtnItem
    }()
    
    var dictionarySelectedIndexPath: [IndexPath: Bool] = [ : ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutCollectionView())
        guard let collectionView = collectionView else { return }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        // Register Cells
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        
        // Navigation bar
        setupBarButtonItems()
        
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
    
    @objc func didSelectButtonClicked(_ sender: UIBarButtonItem){
        mMode = mMode == .view ? .select : .view
    }
    
    @objc func didDeleteButtonClicked(_ sender: UIBarButtonItem){
        var deleteAtIndexPaths: [IndexPath] = []
        for(key, value) in dictionarySelectedIndexPath{
            if value{
                deleteAtIndexPaths.append(key)
            }
        }
        
        // delete biggest item first to the smallest
        for i in deleteAtIndexPaths.sorted(by: {$0.item > $1.item}){
            self.context.delete(items![i.item])
        }
        
        do{
             try self.context.save()
        }catch{
            fatalError("Could not save context")
        }
        fetchItems()
        
        dictionarySelectedIndexPath.removeAll()
    }
    

    // MARK: Core Data functions
    
    func fetchItems(){
        do{
            self.items = try context.fetch(Item.fetchRequest())
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            
        }catch{
            fatalError("could not fetch items")
        }
    }
    
    // MARK: Setup Functions
    
    func layoutCollectionView() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-4, height: (view.frame.size.width/3)-4)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1

        return layout
    }
    
    private func setupBarButtonItems(){
        navigationItem.rightBarButtonItem = addBarBtn
        navigationItem.leftBarButtonItem = selectBarBtn
    }
    
    
    
    // MARK: CollectionView Functions

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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch mMode {
        case .view:
            collectionView.deselectItem(at: indexPath, animated: true)
            let item = items![indexPath.row]
            let addItemVC = UINavigationController(rootViewController: AddItemViewController())
            addItemVC.modalPresentationStyle = .fullScreen
            let editVC = addItemVC.viewControllers.first as? AddItemViewController
            editVC?.previousItem = item
            editVC?.updateItem = true
            present(addItemVC, animated: true)
        case .select:
           dictionarySelectedIndexPath[indexPath] = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if mMode == .select {
            dictionarySelectedIndexPath[indexPath] = false
        }
    }
    
    
    // Collection View Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        header.configure()
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
    
    
    
    
}// end of class
