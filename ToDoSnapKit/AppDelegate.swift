//
//  AppDelegate.swift
//  ToDoSnapKit
//
//  Created by Sarvar Qosimov on 01/02/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        if UserDefaults.standard.bool(forKey: "isLogin") {
            window?.rootViewController = Tabbar()
        } else {
            window?.rootViewController = StartVC()
        }
        window?.makeKeyAndVisible()
        return true
    }
    
    // MARK: - Core Data stack
        lazy var persistentContainer: NSPersistentContainer = {
            
          let container = NSPersistentContainer(name: "ToDoSnapKit")
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              
            if let error = error as NSError? {
              
              fatalError("Unresolved error \(error), \(error.userInfo)")
            }
          })
          return container
        }()

        // MARK: - Core Data Saving support

        func saveContext () {
          let context = persistentContainer.viewContext
          if context.hasChanges {
            do {
              try context.save()
            } catch {
              // Replace this implementation with code to handle the error appropriately.
              // fatalError() causes the application to generate a crash log and terminate.
              /// You should not use this function in a shipping application, although it may be useful during development.
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
          }
        }

}

