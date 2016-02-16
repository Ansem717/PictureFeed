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
                        print(record)
                        completion(success: true)
                    }
                    print(error)
                })
            }
        } catch let error { print(error) }
    }
}