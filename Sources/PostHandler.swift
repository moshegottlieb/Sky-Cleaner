//
//  PostHandler.swift
//  Sky Cleaner
//
//  Created by Moshe Gottlieb on 26.08.25.
//

import Foundation
import ATProtoKit

struct PostHandler : RecordHandler {
    var collection: String {
        return AppBskyLexicon.Feed.PostRecord.type
    }
    
    func extractDate(from record:ComAtprotoLexicon.Repository.GetRecordOutput) -> Date?{
        record.value?.getRecord(ofType: AppBskyLexicon.Feed.PostRecord.self)?.createdAt
    }
    
    func count() {
        stats.posts += 1
    }
}
