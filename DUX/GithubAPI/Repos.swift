//
//  Repo.swift
//  DUX
//
//  Created by dohankim on 2023/06/01.
//

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let keysURL, statusesURL, issuesURL: String?
//    let license: JSONNull?
    let issueEventsURL: String?
    let hasProjects: Bool?
    let id: Int?
    let allowForking: Bool?
    let owner: Owner?
    let visibility, defaultBranch: String?
    let eventsURL, subscriptionURL: String?
    let watchers: Int?
    let gitCommitsURL: String?
    let subscribersURL: String?
    let cloneURL: String?
    let hasWiki: Bool?
    let url: String?
    let pullsURL: String?
    let fork: Bool?
    let notificationsURL: String?
    let description: String?
    let collaboratorsURL: String?
    let deploymentsURL: String?
    let archived: Bool?
    let topics: [String]?
    let languagesURL: String?
    let hasIssues: Bool?
    let commentsURL: String?
    let isTemplate, welcomePrivate: Bool?
    let size: Int?
    let gitTagsURL: String?
    let updatedAt: Date?
    let sshURL, name: String?
    let webCommitSignoffRequired: Bool?
    let contentsURL, archiveURL, milestonesURL, blobsURL: String?
    let nodeID: String?
    let contributorsURL: String?
    let openIssuesCount: Int?
    let permissions: Permissions?
    let forksCount: Int?
    let hasDiscussions: Bool?
    let treesURL: String?
    let svnURL: String?
    let commitsURL: String?
    let createdAt: Date?
    let forksURL: String?
    let hasDownloads: Bool?
    let mirrorURL: JSONNull?
    let homepage: String?
    let teamsURL: String?
    let branchesURL: String?
    let disabled: Bool?
    let issueCommentURL: String?
    let mergesURL: String?
    let gitRefsURL, gitURL: String?
    let forks, openIssues: Int?
    let hooksURL, htmlURL, stargazersURL: String?
    let assigneesURL, compareURL, fullName: String?
    let tagsURL: String?
    let releasesURL: String?
    let pushedAt: Date?
    let labelsURL: String?
    let downloadsURL: String?
    let stargazersCount, watchersCount: Int?
    let language: JSONNull?
    let hasPages: Bool?

    enum CodingKeys: String, CodingKey {
        case keysURL
        case statusesURL
        case issuesURL
//        case license
        case issueEventsURL
        case hasProjects
        case id
        case allowForking
        case owner, visibility
        case defaultBranch
        case eventsURL
        case subscriptionURL
        case watchers
        case gitCommitsURL
        case subscribersURL
        case cloneURL
        case hasWiki
        case url
        case pullsURL
        case fork
        case notificationsURL
        case description
        case collaboratorsURL
        case deploymentsURL
        case archived, topics
        case languagesURL
        case hasIssues
        case commentsURL
        case isTemplate
        case welcomePrivate
        case size
        case gitTagsURL
        case updatedAt
        case sshURL
        case name
        case webCommitSignoffRequired
        case contentsURL
        case archiveURL
        case milestonesURL
        case blobsURL
        case nodeID
        case contributorsURL
        case openIssuesCount
        case permissions
        case forksCount
        case hasDiscussions
        case treesURL
        case svnURL
        case commitsURL
        case createdAt
        case forksURL
        case hasDownloads
        case mirrorURL
        case homepage
        case teamsURL
        case branchesURL
        case disabled
        case issueCommentURL
        case mergesURL
        case gitRefsURL
        case gitURL
        case forks
        case openIssues
        case hooksURL
        case htmlURL
        case stargazersURL
        case assigneesURL
        case compareURL
        case fullName
        case tagsURL
        case releasesURL
        case pushedAt
        case labelsURL
        case downloadsURL
        case stargazersCount
        case watchersCount
        case language
        case hasPages
    }
}

// MARK: - Owner
struct Owner: Codable {
    let id: Int?
    let organizationsURL, receivedEventsURL: String?
    let followingURL, login: String?
    let avatarURL, url: String?
    let nodeID: String?
    let subscriptionsURL, reposURL: String?
    let type: String?
    let htmlURL: String?
    let eventsURL: String?
    let siteAdmin: Bool?
    let starredURL, gistsURL, gravatarID: String?
    let followersURL: String?

    enum CodingKeys: String, CodingKey {
        case id
        case organizationsURL
        case receivedEventsURL
        case followingURL
        case login
        case avatarURL
        case url
        case nodeID
        case subscriptionsURL
        case reposURL
        case type
        case htmlURL
        case eventsURL
        case siteAdmin
        case starredURL
        case gistsURL
        case gravatarID
        case followersURL
    }
}

// MARK: - Permissions
struct Permissions: Codable {
    let push, admin, maintain, triage: Bool?
    let pull: Bool?
}

typealias ReposDTO = [WelcomeElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
