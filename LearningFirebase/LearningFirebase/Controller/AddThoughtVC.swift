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
  
  
  
  @IBOutlet weak var categorySegment: UISegmentedControl!
  @IBOutlet weak var usernameText: UITextField!
  @IBOutlet weak var thougthText: UITextView!
  @IBOutlet weak var postButton: UIButton!
  
  
  private var selectedCategory = ThoughtCategory.funny
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      postButton.layer.cornerRadius = 4
      thougthText.layer.cornerRadius = 4
      thougthText.text = "My random throught..."
      thougthText.textColor = UIColor.lightGray
      thougthText.delegate = self


    }
    
  @IBAction func postButtonTapped(_ sender: Any) {
    
    Firestore.firestore().collection("thoughts").addDocument(data: [
      "category" : selectedCategory,
      "numComments" : 0,
      "numLikes" : 0,
      "thoughtText" : thougthText.text,
      "timestamp" : FieldValue.serverTimestamp(),
      "username" : usernameText.text!
    ]) { error in
      
      if let error = error {
        debugPrint("Error adding document: \(error)")
      } else {
        self.navigationController?.popViewController(animated: true)
      }
      
    }
    
  }
  @IBAction func categoryChanged(_ sender: Any) {

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
