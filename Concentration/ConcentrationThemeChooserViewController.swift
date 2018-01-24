//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Miretz Dev on 21/01/2018.
//  Copyright © 2018 Miretz. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {

    let themes = [
        "Halloween": Theme.halloween.rawValue,
        "Devices": Theme.devices.rawValue,
        "Food": Theme.food.rawValue,
        "Emojis": Theme.emojis.rawValue,
        "Sports": Theme.sports.rawValue,
        "People": Theme.people.rawValue,
        "Animals": Theme.animals.rawValue,
        "Flags": Theme.flags.rawValue,
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    private func checkAndGetTheme(themeName: String) -> String {
        if let theme = themes[themeName]{
            return theme
        } else {
            return Theme.randomTheme().rawValue
        }
    }
    
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle {
                cvc.theme = checkAndGetTheme(themeName: themeName)
            }
        } else if let cvc = lastSeguedToViewController {
            if let themeName = (sender as? UIButton)?.currentTitle {
                cvc.theme = checkAndGetTheme(themeName: themeName)
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }

    // MARK: - Navigation
    
    private var lastSeguedToViewController : ConcentrationViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let cvc = segue.destination as? ConcentrationViewController {
                if let themeName = (sender as? UIButton)?.currentTitle {
                    cvc.theme = checkAndGetTheme(themeName: themeName)
                    lastSeguedToViewController = cvc
                }
            }
        }
    }

}
