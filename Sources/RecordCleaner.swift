//
//  RecordCleaner.swift
//  Sky Cleaner
//
//  Created by Moshe Gottlieb on 23.08.25.
//

import Foundation
import ATProtoKit


class RecordCleaner {
    init(agent:ATProtoKit,handler:RecordHandler){
        self.agent = agent
        self.handler = handler
    }
    
    func feed() async throws{
        guard let session = try await agent.getUserSession() else {
            throw CleanerError.runtimeError("Could not get user session")
        }
        var list:ComAtprotoLexicon.Repository.ListRecordsOutput
        var cursor:String?
        repeat {
            list = try await agent.listRecords(from: session.sessionDID, collection:handler.collection,limit: Self.LIMIT,cursor: cursor,isArrayReverse: true)
            cursor = list.cursor // for next time
            for record in list.records {
                if let created = handler.extractDate(from: record){
                    if created < config.oldest {
                        if let key = record.uri.components(separatedBy: "/").last {
                            try await agent.deleteRecord(repositoryDID: session.handle, collection: handler.collection, recordKey: key)
                            handler.count()
                        }
                    } else {
                        return // done
                    }
                }
            }
            
        } while list.records.count == Self.LIMIT // if we got less than the limit, we're done
        

    }
    
    
    private static let LIMIT = 100
    private let handler : RecordHandler
    private let agent : ATProtoKit
}

protocol RecordHandler {
    var collection : String { get }
    func extractDate(from record:ComAtprotoLexicon.Repository.GetRecordOutput) -> Date?
    func count() // add to stats
}
