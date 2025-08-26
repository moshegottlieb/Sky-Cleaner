// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Logging
import ATProtoKit

let logger = Logger(label: "com.sharkfood.skycleaner")
nonisolated(unsafe) var config : Config!
nonisolated(unsafe) let stats = Stats()


func main() async throws {
    let at_config = ATProtocolConfiguration()
    try await at_config.authenticate(with: config.user, password: config.password)
    let agent = await ATProtoKit(sessionConfiguration: at_config)
    try await RecordCleaner(agent: agent, handler: LikeHandler()).feed()
    try await RecordCleaner(agent: agent, handler: RepostHandler()).feed()
    try await RecordCleaner(agent: agent, handler: PostHandler()).feed()
    print("Deleted \(stats.posts) posts, \(stats.likes) likes, \(stats.reposts) reposts")
}

do {
    do { // written in a block so that it would go out of scope
        let config_data = try Data(contentsOf: URL(fileURLWithPath: "./config.json"))
        config = try JSONDecoder().decode(Config.self, from: config_data)
    }
    try await main() // debugger loses it when running async code straight from the main context, a function is needed to avoid Xcode quarks
} catch {
    logger.error("Error: \(error)")
    exit(1)
}
