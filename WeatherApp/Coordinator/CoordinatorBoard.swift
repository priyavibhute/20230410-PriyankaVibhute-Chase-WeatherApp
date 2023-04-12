//
//  CoordinatorBoard.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 10/04/23.
//

import Foundation
import UIKit

protocol CoordinatorBoard: UIViewController {
    static func launchFromStoryBoard() -> Self
}

extension CoordinatorBoard {
    static func launchFromStoryBoard() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let id = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
