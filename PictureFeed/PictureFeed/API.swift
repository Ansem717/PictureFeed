//
//  API.swift
//  PictureFeed
//
//  Created by Andy Malik on 2/16/16.
//  Copyright © 2016 Andy Malik. All rights reserved.
//

import Foundation
import CloudKit

typealias APICompletion = (success: Bool) -> ()

class API {
    
    static let shared = API()
    
    let container: CKContainer
    let db: CKDatabase
    
    private init() {
        self.container = CKContainer.defaultContainer()
        self.db = self.container.privateCloudDatabase
    }
    
    func POST(post: Post, completion: APICompletion) {
        
        do {
            if let record = try Post.recordWith(post) {
                self.db.saveRecord(record, completionHandler: { (record, error) -> Void in
                    if error == nil {
                        completion(success: true)
                    } else {
                        print("")
                        print("Error on line 35 - API.swift")
                        print(error)
                        print("")
                    }
                })
            }
        } catch let error { print(error) }
    }
    
    func GETall(completion: (success: Bool, results: [CKRecord]?) -> ()) {

        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Post", predicate: predicate)
        
        self.db.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error == nil {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    completion(success: true, results: results)
                })
            } else {
                print("")
                print("Error on line 56 - API.swift")
                print(error)
                print("")
            }
        }
        
    }
}



















