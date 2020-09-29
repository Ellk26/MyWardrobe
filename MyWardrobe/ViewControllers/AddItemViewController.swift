//
//  AddItemViewController.swift
//  MyWardrobe
//
//  Created by elliott kung on 2020-09-24.
//

import UIKit

class AddItemViewController: UITableViewController, UINavigationControllerDelegate {
    
    // Define all tableView cells
    var imageCell: UITableViewCell = UITableViewCell()
    let categoryCell: UITableViewCell = UITableViewCell()
    let subCategoryCell: UITableViewCell = UITableViewCell()
    let colorCell: UITableViewCell = UITableViewCell()
    let brandCell: UITableViewCell = UITableViewCell()
    let seasonCell: UITableViewCell = UITableViewCell()
    
    // Define textfields
    var imgView: UIImageView = UIImageView()
    var categoryText: UITextField = UITextField()
    var subCategoryText: UITextField = UITextField()
    var colorText: UITextField = UITextField()
    var brandText: UITextField = UITextField()
    var seasonText: UITextField = UITextField()
    
    
    override func loadView() {
        super.loadView()
        self.title = "Add Item"
        
        // Construct cells
        let imgTap = UITapGestureRecognizer(target: self, action: #selector(self.imgTap))
        self.imageCell.addGestureRecognizer(imgTap)
        self.imageCell.addSubview(imgView)
        imageCell.preservesSuperviewLayoutMargins = false
        imageCell.separatorInset = UIEdgeInsets.zero
        imageCell.layoutMargins = UIEdgeInsets.zero
        
        
        self.categoryText = UITextField(frame: self.categoryCell.contentView.bounds.insetBy(dx: 15,dy: 0))
        self.categoryText.placeholder = "Cateogry"
        self.categoryCell.addSubview(self.categoryText)
        
        self.subCategoryText = UITextField(frame: self.subCategoryCell.contentView.bounds.insetBy(dx: 15,dy: 0))
        self.subCategoryText.placeholder = "Sub-Cateogry"
        self.subCategoryCell.addSubview(self.subCategoryText)
        
        self.colorText = UITextField(frame: self.colorCell.contentView.bounds.insetBy(dx: 15,dy: 0))
        self.colorText.placeholder = "Color"
        self.colorCell.addSubview(self.colorText)
        
        self.brandText = UITextField(frame: self.brandCell.contentView.bounds.insetBy(dx: 15,dy: 0))
        self.brandText.placeholder = "Brand"
        self.brandCell.addSubview(self.brandText)

        self.seasonText = UITextField(frame: self.seasonCell.contentView.bounds.insetBy(dx: 15,dy: 0))
        self.seasonText.placeholder = "Season"
        self.seasonCell.addSubview(self.seasonText)
        
        
        configureImageView()
        
        // set textfield constraints
        setTextFieldConstraints(textField: categoryText, tableViewCell: categoryCell)
        setTextFieldConstraints(textField: subCategoryText, tableViewCell: subCategoryCell)
        setTextFieldConstraints(textField: brandText, tableViewCell: brandCell)
        setTextFieldConstraints(textField: colorText, tableViewCell: colorCell)
        setTextFieldConstraints(textField: seasonText, tableViewCell: seasonCell)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    }
    
    
    @objc func cancel(){
        dismiss(animated: true, completion: nil)
    }
    
    // TODO: save user input to core data object
    @objc func addItem(){
        print("adding item")
    }
    
    @objc func imgTap(){
        print("in img tap")
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    
    // MARK: Configuration and Constraint functions 
    
    func configureImageView(){
        imgView.frame.size = CGSize(width: view.frame.width, height: 500)
        imgView.isUserInteractionEnabled = true
        guard let image = UIImage(systemName: "camera") else { return }
        imgView.image = image
        imgView.backgroundColor = .gray
        
        setImageViewConstraints()
    }
    
    func setImageViewConstraints(){
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: imageCell.topAnchor, constant: 30).isActive = true
        imgView.leadingAnchor.constraint(equalTo: imageCell.leadingAnchor, constant: 50).isActive = true
        imgView.trailingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: -50).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    func setTextFieldConstraints(textField: UITextField, tableViewCell: UITableViewCell){
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: tableViewCell.topAnchor, constant: 5).isActive = true
        textField.bottomAnchor.constraint(equalTo: tableViewCell.bottomAnchor, constant: -5).isActive = true
        textField.leadingAnchor.constraint(equalTo: tableViewCell.leadingAnchor, constant: 15).isActive = true
        textField.trailingAnchor.constraint(equalTo: tableViewCell.trailingAnchor, constant: -15).isActive = true
        tableViewCell.preservesSuperviewLayoutMargins = false
        tableViewCell.separatorInset = UIEdgeInsets.zero
        tableViewCell.layoutMargins = UIEdgeInsets.zero
        
    }
    
    // MARK: TableView functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.row {
            case 0:
                return self.imageCell
            case 1:
                return self.categoryCell
            case 2:
                return self.subCategoryCell
            case 3:
                return self.brandCell
            case 4:
                return self.colorCell
            case 5:
                return self.seasonCell
            default:
                fatalError()
            }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        case 1:
            return 100
        case 2:
            return 100
        case 3:
            return 100
        case 4:
            return 100
        case 5:
            return 100
        default:
            fatalError()
        }
    }
    
    
} // end of class

extension AddItemViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        imgView.image = image
    }
}
