//
//  RepostHandler.swift
//  Sky Cleaner
//
//  Created by Moshe Gottlieb on 26.08.25.
//

import Foundation


import Foundation
import ATProtoKit

struct RepostHandler : RecordHandler {
    var collection: String {
        return AppBskyLexicon.Feed.RepostRecord.type
    }
    
    func extractDate(from record:ComAtprotoLexicon.Repository.GetRecordOutput) -> Date?{
        record.value?.getRecord(ofType: AppBskyLexicon.Feed.RepostRecord.self)?.createdAt
    }
    
    func count() {
        stats.reposts += 1
    }
}
