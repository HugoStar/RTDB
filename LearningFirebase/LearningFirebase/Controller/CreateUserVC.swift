//
//  CreateUserVC.swift
//  LearningFirebase
//
//  Created by Мишустин Сергеевич on 22/01/2019.
//  Copyright © 2019 Mishustin Viktor. All rights reserved.
//

import UIKit
import Firebase

class CreateUserVC: UIViewController {
  
  @IBOutlet weak var textFieldEmail: UITextField!
  @IBOutlet weak var textFieldPassword: UITextField!
  @IBOutlet weak var textFieldUserName: UITextField!
  
  @IBOutlet weak var buttonCreate: UIButton!
  @IBOutlet weak var buttonCancel: UIButton!
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    buttonCreate.layer.cornerRadius = 10.0
    buttonCancel.layer.cornerRadius = 10.0
    
  }
  
  @IBAction func buttonCreateUserTap(_ sender: Any) {
    
    
    guard let email = textFieldEmail.text,
      let password = textFieldPassword.text,
      let username = textFieldUserName.text else { return }
    
    Auth.auth().createUser(withEmail: email, password: password) { dataResult, error in
      if let error = error {
        debugPrint("Error creating user \(error.localizedDescription)")
      }
      
      let changeRequest = dataResult?.user.createProfileChangeRequest()
      changeRequest?.displayName = username
      changeRequest?.commitChanges(completion: { error in
        if let error = error {
          debugPrint("Error creating user \(error.localizedDescription)")
        }
      })
      guard let userId = dataResult?.user.uid else { return }
      Firestore.firestore().collection(USERS_REF).document(userId).setData([
        USERNAME : username,
        DATE_CREATED : FieldValue.serverTimestamp()
        ], completion: { error in
          if let error = error {
            debugPrint("Error creating user \(error.localizedDescription)")
          } else {
            self.dismiss(animated: true, completion: nil)
          }
      })
      
      
      
    }
    
  }
  
  @IBAction func buttonCancelTap(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
