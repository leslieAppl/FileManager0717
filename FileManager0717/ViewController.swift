//
//  ViewController.swift
//  FileManager0717
//
//  Created by leslie on 7/17/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var diaryTxt: UITextView!
    
    var fileURL: URL!
    var sceneDelegate: SceneDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneDelegate = SceneDelegate()
        
        diaryTxt.delegate = self
        
        //TODO: 11- Managing (write and read) the file's content | Data
        ///The shared file manager object
        let manager = FileManager.default
        let documents = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = documents.first!
        
        fileURL = docURL.appendingPathComponent("myDiary.txt")
        let filePath = fileURL.path
        
        if manager.fileExists(atPath: filePath) {
            ///Converting Data to String
            if let content = manager.contents(atPath: filePath) {
                diaryTxt.text = String(data: content, encoding: .utf8)
            }
        } else {
            manager.createFile(atPath: filePath, contents: nil, attributes: nil)
        }
        
        //TODO: 13- Encoding and decoding data
        let fileURL13 = docURL.appendingPathComponent("quotes.dat")
        let filePath13 = fileURL13.path
        ///Decoding data
        if manager.fileExists(atPath: filePath13) {
            if let content = manager.contents(atPath: filePath13) {
                if let result = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSString.self, from: content) as String? {
                    let message = result
                    print(message)
                }
            }
        } else {
            ///Endoding data
            let quote = "Fiction is the truth inside the lie."
            if let fileData = try? NSKeyedArchiver.archivedData(withRootObject: quote, requiringSecureCoding: false) {
                manager.createFile(atPath: filePath13, contents: fileData, attributes: nil)
            }
        }
        
        sceneDelegate.listItems(directory: docURL)
    }
}

//MARK: - UITextViewDelegate Protocol
extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let text = diaryTxt.text
        do {
            ///Converting String to Data
            try text?.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error")
        }
    }
}
