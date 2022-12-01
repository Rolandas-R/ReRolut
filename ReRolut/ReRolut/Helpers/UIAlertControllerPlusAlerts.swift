//
//  Alerts.swift
//  ReRolut
//
//  Created by reromac on 2022-11-26.
//

import UIKit


// nukopinta is QuizApp
//TODO: pakoreguoti, pritaikyti ir suprasti kaip ir kodel sitas alertas veikia

extension UIAlertController {

  static func showErrorAlert(title: String, message: String, controller: UIViewController, onTapAction: ((UIAlertAction) -> Void)? = nil) {
    let action = UIAlertAction(title: "OK", style: .default, handler: onTapAction)
    let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(action)

    controller.present(alert, animated: true)
  }

}
