//
//  AppDelegate.swift
//  Todoey
//
//  Created by Kyle Garcia on 2/12/19.
//  Copyright © 2019 Kyle Garcia. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let config = Realm.Configuration(
            
            schemaVersion: 1,
            
            migrationBlock: { migration, oldSchemaVersion in
                
                if (oldSchemaVersion < 1) {
                    
                    migration.enumerateObjects(ofType: Category.className()) { (old, new) in
                        new!["dateCreated"] = Date()
                    }
                    migration.enumerateObjects(ofType: Item.className()) { (old, new) in
                        new!["dateCreated"] = Date()
                    }
                }
        })
        
        Realm.Configuration.defaultConfiguration = config
        
        do {
            _ = try Realm()
        
            }
        catch {
            print("Error initializing Realm \(error)")
        }
        
        
        return true
    }

}

