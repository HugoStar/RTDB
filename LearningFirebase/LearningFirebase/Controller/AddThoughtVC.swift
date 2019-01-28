//
//  AddVC.swift
//  LearningFirebase
//
//  Created by Мишустин Сергеевич on 15/01/2019.
//  Copyright © 2019 Mishustin Viktor. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController, UITextViewDelegate {
  
  
  
  @IBOutlet private weak var categorySegment: UISegmentedControl!
  @IBOutlet private weak var usernameText: UITextField!
  @IBOutlet private weak var thougthText: UITextView!
  @IBOutlet private weak var postButton: UIButton!
  
  
  private var selectedCategory = ThoughtCategory.funny.rawValue
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      postButton.layer.cornerRadius = 4
      thougthText.layer.cornerRadius = 4
      thougthText.text = "My random throught..."
      thougthText.textColor = UIColor.lightGray
      thougthText.delegate = self


    }
    
  @IBAction func postButtonTapped(_ sender: Any) {
    guard let username = usernameText.text else { return }
    Firestore.firestore().collection(THOUGHTS_REF).addDocument(data: [
      CATEGORY : selectedCategory,
      NUM_COMMENTS : 0,
      NUM_LIKES : 0,
      THOUGHT_TEXT : thougthText.text,
      TIMESTAMP : FieldValue.serverTimestamp(),
      USERNAME : username,
      USER_ID : Auth.auth().currentUser?.uid ?? ""
    ]) { error in
      
      if let error = error {
        debugPrint("Error adding document: \(error)")
      } else {
        self.navigationController?.popViewController(animated: true)
      }
      
    }
    
  }
  @IBAction func categoryChanged(_ sender: Any) {
    
    switch categorySegment.selectedSegmentIndex {
    case 0:
      selectedCategory = ThoughtCategory.funny.rawValue
    case 1:
      selectedCategory = ThoughtCategory.serious.rawValue
    default:
      selectedCategory = ThoughtCategory.crazy.rawValue
    }

  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    textView.text = ""
    textView.textColor = UIColor.darkGray
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text == "" {
      thougthText.text = "My random throught..."
      thougthText.textColor = UIColor.lightGray
    }
  }


}
