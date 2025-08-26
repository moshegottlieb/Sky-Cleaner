//
//  Like Handler.swift
//  Sky Cleaner
//
//  Created by Moshe Gottlieb on 26.08.25.
//

import Foundation
import ATProtoKit

struct LikeHandler : RecordHandler {
    var collection: String {
        return AppBskyLexicon.Feed.LikeRecord.type
    }
    
    func extractDate(from record:ComAtprotoLexicon.Repository.GetRecordOutput) -> Date?{
        record.value?.getRecord(ofType: AppBskyLexicon.Feed.LikeRecord.self)?.createdAt
    }
    
    func count() {
        stats.likes += 1
    }
}
