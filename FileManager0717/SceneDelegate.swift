//
//  SceneDelegate.swift
//  FileManager0717
//
//  Created by leslie on 7/17/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        //TODO: 1- Getting the Documents directory’s URL
        ///The shared file manager object.
        let manager = FileManager.default
        let documents = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = documents.first!
        print(docURL)
        print(documents.count)
        
        //TODO: 2- Creating a file inside Documents
        let newFileURL = docURL.appendingPathComponent("myText.txt")
        let filePath = newFileURL.path
        manager.createFile(atPath: filePath, contents: nil, attributes: nil)
        
        //TODO: 3- Creating a directory inside Documents
        let newDirectoryURL = docURL.appendingPathComponent("myFiles")
        let dirPath = newDirectoryURL.path
        ///This method throws an error if it cannot complete the task, so we have to handle the error with the try keyword.
        do {
            try manager.createDirectory(atPath: dirPath, withIntermediateDirectories: false, attributes: nil)
        } catch {
            print("The directory already exists")
        }
        
        listItems(directory: docURL)
        
        //TODO: 5- Creating files in a custom directory
        let anotherFileURL = docURL.appendingPathComponent("myFiles/anotherfile.txt")
        let anotherFilePath = anotherFileURL.path
        let isCreated = manager.createFile(atPath: anotherFilePath, contents: nil, attributes: nil)
        if !isCreated {
            print("We couldn't create the file")
        }
        
        ///Preparing target dir URL for listing the content of a custom directory
        let customDirURL = docURL.appendingPathComponent("myFiles/")
        listItems(directory: customDirURL)
    }

    //TODO: 4- Listing the content of a directory
    func listItems(directory: URL) {
        ///The shared file manager object.
        let manager = FileManager.default
        if let list = try? manager.contentsOfDirectory(atPath: directory.path) {
            if list.isEmpty {
                print("The directory is empty")
            } else {
                for item in list {
                    print(item)
                }
            }
        }
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

