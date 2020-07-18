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
        let filePath2 = newFileURL.path
        manager.createFile(atPath: filePath2, contents: nil, attributes: nil)
        
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
        let anotherFileURL = docURL.appendingPathComponent("myFiles/anotherFile.txt")
        let anotherFilePath = anotherFileURL.path
        let isCreated = manager.createFile(atPath: anotherFilePath, contents: nil, attributes: nil)
        if !isCreated {
            print("We couldn't create the file")
        }
        
        ///Preparing target dir URL for listing the content of a custom directory
        let customDirURL = docURL.appendingPathComponent("myFiles")
        listItems(directory: customDirURL)
        
        //TODO: 6- Moving Files
        let originURL = docURL.appendingPathComponent("myText.txt")
        let destinationURL = docURL.appendingPathComponent("myFiles/myText.txt")
        let originPath = originURL.path
        let destinationPath = destinationURL.path
        do {
            try manager.moveItem(atPath: originPath, toPath: destinationPath)
        } catch {
            print("File was not moved")
        }
        
        ///Checking the content of a custom dir
        print("-- Last checking --")
        listItems(directory: docURL)
        listItems(directory: customDirURL)

        //TODO: 7- Copying Files
        let copyOriginURL = docURL.appendingPathComponent("myFiles/anotherFile.txt")
        let copyDestinationURL = docURL.appendingPathComponent("anotherFile.txt")
        let copyOriginPath = copyOriginURL.path
        let copyDestinationPath = copyDestinationURL.path
        do {
            try manager.copyItem(atPath: copyOriginPath, toPath: copyDestinationPath)
        } catch {
            print("File was not copied")
        }
        
        ///Checking the content of a custom dir
        print("-- Last checking --")
        listItems(directory: docURL)
        listItems(directory: customDirURL)
        
        //TODO: 8- Removing Files
        let removeFileURL = docURL.appendingPathComponent("myText.txt")
        let removeFilePath = removeFileURL.path
        do {
            try manager.removeItem(atPath: removeFilePath)
        } catch {
            print("File was not removed")
        }
        
        ///Checking the content of a custom dir
        print("-- Last checking --")
        listItems(directory: docURL)
        listItems(directory: customDirURL)
        
        //TODO: 9- Removing Directory
        let removeDirURL = docURL.appendingPathComponent("myFiles")
        let removeDirPath = removeDirURL.path
        do {
            try manager.removeItem(atPath: removeDirPath)
        } catch {
            print("Directory was not removed")
        }
        
        ///Checking the content of a custom dir
        print("-- Last checking --")
        listItems(directory: docURL)
        listItems(directory: customDirURL)
        
        //TODO: 10- Reading file's attributes
        let fileURL = docURL.appendingPathComponent("anotherFile.txt")
        let filePath10 = fileURL.path
        do {
            let attributes = try manager.attributesOfItem(atPath: filePath10)
            let type = attributes[.type] as! FileAttributeType
            let size = attributes[.size] as! Int
            let date = attributes[.creationDate] as! Date
            
            if type != FileAttributeType.typeDirectory {
                print("Name: \(fileURL.lastPathComponent)")
                print("size: \(size)")
                print("date: \(date)")
            }
            
        } catch {
            print("couldn't read file's attributes")
        }
        
        ///Checking the content of a custom dir
        print("-- Last checking --")
        listItems(directory: docURL)
        listItems(directory: customDirURL)

        //TODO: 12- Bundle - Loading a project file
        ///main: returns a reference to the app’s bundle
        let bundle = Bundle.main
        let filePath12 = bundle.path(forResource: "quote", ofType: "txt")
        print("TODO: 12- filePath12: \(String(describing: filePath12))")
        if let data = manager.contents(atPath: filePath12!) {
            let message = String(data: data, encoding: .utf8)
            print(message!)
        }
        
        let allBundles = Bundle.allBundles
        print(allBundles)        
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
                    let counter = directory.pathComponents.count
                    print("\(directory.pathComponents[counter-1]) \(item)")
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

