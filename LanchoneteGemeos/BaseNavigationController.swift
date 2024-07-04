//
//  BaseNavigationController.swift
//  LanchoneteGemeos
//
//  Created by Guilherme Taylor on 09/05/24.
//
import UIKit

extension UINavigationController {
    func applyCustomStyle() {
        // Configure navigation bar appearance
        self.navigationBar.barTintColor = .red // Cor de fundo
        self.navigationBar.isTranslucent = false // Barra de navegação não translúcida
        
        // Customize title color and font if needed
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]
    }
}
