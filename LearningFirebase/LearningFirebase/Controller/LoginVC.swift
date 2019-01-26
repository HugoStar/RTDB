//
//  LoginVC.swift
//  LearningFirebase
//
//  Created by Мишустин Сергеевич on 22/01/2019.
//  Copyright © 2019 Mishustin Viktor. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
  
  @IBOutlet weak var textFieldEmail: UITextField!
  @IBOutlet weak var textFieldPassword: UITextField!
  
  @IBOutlet weak var buttonLogin: UIButton!
  
  @IBOutlet weak var buttonCreateUser: UIButton!
  
  

    override func viewDidLoad() {
        super.viewDidLoad()

      buttonLogin.layer.cornerRadius = 10.0
      buttonCreateUser.layer.cornerRadius = 10.0
      
    }
  
  
  @IBAction func buttonLoginTap(_ sender: Any) {
    guard let email = textFieldEmail.text,
      let password = textFieldPassword.text else { return }
    
    Auth.auth().signIn(withEmail: email, password: password) { user, error in
      if let error = error {
        debugPrint("Error signing in : \(error)")
      } else {
        self.dismiss(animated: true, completion: nil)
      }
    }
    
  }
  

  
}
