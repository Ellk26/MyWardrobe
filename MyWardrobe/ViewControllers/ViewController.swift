//
//  ViewController.swift
//  MyWardrobe
//
//  Created by elliott kung on 2020-09-21.
//

import UIKit

class ViewController: UITabBarController {

    let weatherVC = UINavigationController(rootViewController: WeatherViewController())
    let closetVC = UINavigationController(rootViewController: ClosetViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        weatherVC.title = "Todays Weather"
        closetVC.title = "My Closet"
        
        self.setViewControllers([weatherVC, closetVC], animated: false)
        guard let items = self.tabBar.items else {return}
        let images = ["sparkles", "star"]
        for x in 0..<items.count{
            items[x].image = UIImage(systemName: images[x])
        }
        
    }


}

