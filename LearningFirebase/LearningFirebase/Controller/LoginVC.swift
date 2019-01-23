//
//  LoginVC.swift
//  LearningFirebase
//
//  Created by Мишустин Сергеевич on 22/01/2019.
//  Copyright © 2019 Mishustin Viktor. All rights reserved.
//

import UIKit

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
  }
  

  @IBAction func buttonCreateUserTap(_ sender: Any) {
  }
  
}
