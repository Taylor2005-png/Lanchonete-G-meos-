//
//  HomeViewController.swift
//  LanchoneteGemeos
//
//  Created by Guilherme Taylor on 08/05/24.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupTabBar()
        
        // Exibir a barra de tabulação
        tabBar.isHidden = false
        
        // Ocultar a barra de navegação
      navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func setupTabBar() {
        // Load each view controller from their respective XIB files
        let menu1ViewController = InicioViewController(nibName: "InicioViewController", bundle: nil)
        let menu2ViewController = PedidosViewController(nibName: "PedidosViewController", bundle: nil)
        let menu3ViewController = PerfilViewController(nibName: "PerfilViewController", bundle: nil)
        
        // Optionally, you can customize each tab item further if needed
        menu1ViewController.tabBarItem = UITabBarItem(title: "Inicio", image: UIImage(named: "trairpods.gen3ash"), tag: 0)
        menu2ViewController.tabBarItem = UITabBarItem(title: "Pedidos", image: UIImage(named: "airplayvideo"), tag: 1)
        menu3ViewController.tabBarItem = UITabBarItem(title: "Perfil", image: UIImage(named: "wave.3.forward.circle"), tag: 2)
        
        // Wrap each view controller in a navigation controller
        let navController1 = UINavigationController(rootViewController: menu1ViewController)
        let navController2 = UINavigationController(rootViewController: menu2ViewController)
        let navController3 = UINavigationController(rootViewController: menu3ViewController)
        
        // Set the view controllers for the tab bar controller
        self.viewControllers = [navController1, navController2, navController3]

        // Set delegates
        self.delegate = self
        
        // Customize the appearance of the tab bar
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .blue
    }
}


extension HomeViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Handle tab bar item selection
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
            // Handle each tab index
            switch index {
            case 0:
                // Menu 1 selected
                print("Menu 1 selected")
            case 1:
                // Menu 2 selected
                print("Menu 2 selected")
            case 2:
                // Menu 3 selected
                print("Menu 3 selected")
            default:
                break
            }
        }
     }
  }
