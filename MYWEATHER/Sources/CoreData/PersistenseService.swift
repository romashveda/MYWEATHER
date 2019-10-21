//
//  CoreDataService.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/21/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit
import CoreData

enum Entity: String {
    case Place, Location, City
}

final class PersistenseService {
    private init() {}
    static let shared = PersistenseService()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MYWEATHER")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    lazy var context =  persistentContainer.viewContext
    lazy var backContext = persistentContainer.newBackgroundContext()
    
    
    func saveContext(completion:() -> Void) {
        if backContext.hasChanges {
            do {
                try backContext.save()
                print("saved successfully")
                completion()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T:NSManagedObject>(_ type: T.Type, completion: @escaping ([T]) -> Void) {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        do {
            let objects = try backContext.fetch(request)
            completion(objects)
        } catch {
            print(error)
            completion([])
        }
    }
}
