//
//  AddItemViewController.swift
//  MyWardrobe
//
//  Created by elliott kung on 2020-09-24.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        configureStackView()
    }
    
    // TODO: give user options to sort items based on certain descriptor categories
    @objc func cancel(){
        dismiss(animated: true, completion: nil)
    }
    
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
    
    func addImageToStack(){
        
        let imgTap = UITapGestureRecognizer(target: self, action: #selector(self.imgTap))
        
        let imgView = UIImageView()
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(imgTap)
        guard let image = UIImage(systemName: "camera") else { return }
        imgView.image = image
        imgView.backgroundColor = .gray
        stackView.addArrangedSubview(imgView)
        
    }
    
    func addTextFieldToStack(field: String){
        let textField = UITextField()
        textField.placeholder = field
        stackView.addArrangedSubview(textField)
    }
    
    // MARK: Configuration and Constraint functions 
    
    func configureStackView(){
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        
        addImageToStack()
        addTextFieldToStack(field: "Category")
        addTextFieldToStack(field: "Sub-Category")
        addTextFieldToStack(field: "Color")
        
        setStackViewConstraints()
    }
    
    func setStackViewConstraints(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    
    
}
