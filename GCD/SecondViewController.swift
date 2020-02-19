//
//  SecondViewController.swift
//  GCD
//
//  Created by Artur Anissimov on 19.02.2020.
//  Copyright © 2020 Artur Anissimov. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL? /* Ссылка на изображение */
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.contentMode = .scaleAspectFill
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
        delay(3) {
            self.loginAlert()
        }
    }
    
    fileprivate func delay(_ delay: Int, closure: @escaping () -> () ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "Зарегистрированы?", message: "Введи ваш логин и пароль", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (usernameTextField) in
            usernameTextField.placeholder = "Введите логин"
        }
        
        ac.addTextField { (userPasswordTextField) in
            userPasswordTextField.placeholder = "Введите пароль"
            userPasswordTextField.isSecureTextEntry = true
        }
        
        self.present(ac, animated: true, completion: nil)
    }
    
    fileprivate func fetchImage() {
        
        imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
        

        
    }
    
}
