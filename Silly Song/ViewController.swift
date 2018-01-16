//
//  ViewController.swift
//  Silly Song
//
//  Created by Ahmad on 1/16/18.
//  Copyright © 2018 Ahmad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lyricsViewLabel: UITextView!
    var playerName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
    // MARK: - UI Intialization
    
    func initUI()
    {
        nameTextField.delegate = self
        nameTextField.returnKeyType = UIReturnKeyType.done
    }
    
    // MARK: - Actions
    @IBAction func reset(_ sender: Any) {
        nameTextField.text = ""
        lyricsViewLabel.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        playerName = (nameTextField.text?.capitalizingFirstLetter())!
        lyricsViewLabel.text = lyricsFromName(lyricsTemplate: bananaFanaTemplate, fullName: playerName)
    }
    
    // MARK: - Methods
    func shortNameforName (name: String) -> String{
        var result = ""
        let shortName = name.lowercased()
        let vowelSet = CharacterSet(charactersIn: "aeiou")
        
        if let range = shortName.rangeOfCharacter(from: vowelSet, options: String.CompareOptions.caseInsensitive) {
            let startIndex = range.lowerBound
            let newString = shortName.substring(from: startIndex)
            result = newString
        }
        return result
    }
    
    
    func lyricsFromName(lyricsTemplate: String, fullName: String) -> String {
        
        let shortName = shortNameforName(name: fullName)
        var customizedLyrics = ""
        customizedLyrics = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        customizedLyrics = customizedLyrics.replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        return customizedLyrics
    }
    
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
}

// MARK: - Extensions
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ nameTextField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return false
    }
    
    
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}


