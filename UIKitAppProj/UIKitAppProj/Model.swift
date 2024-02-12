//
//  Model.swift
//  UIKitAppProj
//
//  Created by Rajat Lakhina on 12/02/24.
//

import Foundation

struct TownHallData: Codable {
    var data: TownHallItem?
    let code: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case code = "code"
        case message = "message"
    }
}

// MARK: - DataClass
struct TownHallItem: Codable {
    //var newPost: [TownHallPost]? = nil
    var oldPost: [TownHallPost]? = nil

    enum CodingKeys: String, CodingKey {
        //case newPost = "new_post"
        case oldPost = "old_post"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        oldPost = try container.decodeIfPresent([TownHallPost].self, forKey: .oldPost)
        
//        if let newPostData = try container.decodeIfPresent([TownHallPost].self, forKey: .newPost) {
//            newPost = newPostData
//        }
        
        
    }
}

// MARK: - OldPost
struct TownHallPost: Codable, Equatable, Hashable, Identifiable {
    var id: String = "\(UUID())"
    let _id: String?
    let roundTableData : TownHallRoundTableData?
    var pollingData: PollingData?
    let type: String?
    let isDraft: Bool?
    let text: String?
    let hashTags: [String]?
    let mentionedUsers: [String]?
    let taggedUsers: [String]?
    let isDeleted: Int?
    var mediaType: MediaTypeNew?
    let media: [TownHallMediaItem]?
    let parentType: String?
    let isConverted: Int?
    let userID: String?
    let lang: String?
    let createdAt: String?
    let lastUpdated: String?
    let v: Int?
    let sortCond: String?
    let child: [TownHallChild]?
    let commentsList: [CommentsList]?
    let likedUsernames: [LikedUsername]?
    var circulateCount: Int?
    var circulateSelf: Int?
    let rawText: String?
    let postID: String?
    let postedBy: String?
    let userType: String?
    let userVerification: Int?
    let userVerificationFlags: Int?
    let name: String?
    let username: String?
    var like: Int?
    var dislike: Int?
    var favorite: Int?
    let dmShareCount: Int?
    var comment: Int?
    let postQuote: Int?
    var likeSelf: Int?
    var dislikeSelf: Int?
    var favoriteSelf: Int?
    let dmShareSelf: Int?
    let selfUser: Int?
    let muted: Int?
    var commentSelf: Int?
    let postQuoteSelf: Int?
    let verified: Verified?
    let actionCount: Int?
    let isFollowing: Int?
    let hasChild: Bool?
    let formattedCreatedAt: String?
    let formattedCreatedAtShort: String?
    let mentionedUsernames: [String]?
    let htmlModifiedText: String?
    let isThread: Bool?
    let isCompressed: Int?
    let parentAccountVerification: Int?
    let parentAccountVerificationFlags: Int?
    let circUsername: String?
    let urls: ChildUrls?
    let keywords: [String]?
    var isMetaAvailable = true
    var formattedPostCreatedAt: String? = nil

    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case roundTableData = "round_table_data"
        case pollingData = "polling_data"
        case type = "type"
        case isDraft = "is_draft"
        case text = "text"
        case hashTags = "hash_tags"
        case mentionedUsers = "mentioned_users"
        case taggedUsers = "tagged_users"
        case isDeleted = "is_deleted"
        case mediaType = "media_type"
        case media = "media"
        case parentType = "parent_type"
        case isConverted = "is_converted"
        case userID = "user_id"
        case lang = "lang"
        case createdAt = "created_at"
        case lastUpdated = "last_updated"
        case v = "__v"
        case sortCond = "sort_cond"
        case child = "child"
        case commentsList = "comments_list"
        case likedUsernames = "liked_usernames"
        case circulateCount = "circulate_count"
        case circulateSelf = "circulate_self"
        case rawText = "raw_text"
        case postID = "post_id"
        case postedBy = "posted_by"
        case userType = "user_type"
        case userVerification = "user_verification"
        case userVerificationFlags = "user_verification_flags"
        case name = "name"
        case username = "username"
        case like = "like"
        case dislike = "dislike"
        case favorite = "favorite"
        case dmShareCount = "dm_share_count"
        case comment = "comment"
        case postQuote = "post_quote"
        case likeSelf = "like_self"
        case dislikeSelf = "dislike_self"
        case favoriteSelf = "favorite_self"
        case dmShareSelf = "dm_share_self"
        case selfUser = "self"
        case muted = "muted"
        case commentSelf = "comment_self"
        case postQuoteSelf = "post_quote_self"
        case verified = "verified"
        case actionCount = "action_count"
        case isFollowing = "is_following"
        case hasChild = "has_child"
        case formattedCreatedAt = "formatted_created_at"
        case formattedCreatedAtShort = "formatted_created_at_short"
        case mentionedUsernames = "mentioned_usernames"
        case htmlModifiedText = "html_modified_text"
        case isThread = "IS_THREAD"
        case isCompressed = "is_compressed"
        case parentAccountVerification = "parent_account_verification"
        case parentAccountVerificationFlags = "parent_account_verification_flags"
        case circUsername = "circ_username"
        case urls = "urls"
        case keywords = "keywords"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        _id = try container.decodeIfPresent(String.self, forKey: ._id)
        roundTableData = try container.decodeIfPresent(TownHallRoundTableData.self, forKey: .roundTableData)
        pollingData = try container.decodeIfPresent(PollingData.self, forKey: .pollingData)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        isDraft = try container.decodeIfPresent(Bool.self, forKey: .isDraft)
        text = try container.decodeIfPresent(String.self, forKey: .text)
        hashTags = try container.decodeIfPresent([String].self, forKey: .hashTags)
        mentionedUsers = try container.decodeIfPresent([String].self, forKey: .mentionedUsers)
        taggedUsers = try container.decodeIfPresent([String].self, forKey: .taggedUsers)
        isDeleted = try container.decodeIfPresent(Int.self, forKey: .isDeleted)
        if let mediaTypeString = try container.decodeIfPresent(String.self, forKey: .mediaType) {
            mediaType = MediaTypeNew.from(rawValue: mediaTypeString)
        }
        media = try container.decodeIfPresent([TownHallMediaItem].self, forKey: .media)
        parentType = try container.decodeIfPresent(String.self, forKey: .parentType)
        isConverted = try container.decodeIfPresent(Int.self, forKey: .isConverted)
        userID = try container.decodeIfPresent(String.self, forKey: .userID)
        lang = try container.decodeIfPresent(String.self, forKey: .lang)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        lastUpdated = try container.decodeIfPresent(String.self, forKey: .lastUpdated)
        v = try container.decodeIfPresent(Int.self, forKey: .v)
        sortCond = try container.decodeIfPresent(String.self, forKey: .sortCond)
        child = try container.decodeIfPresent([TownHallChild].self, forKey: .child)
        commentsList = try container.decodeIfPresent([CommentsList].self, forKey: .commentsList)
        likedUsernames = try container.decodeIfPresent([LikedUsername].self, forKey: .likedUsernames)
        circulateCount = try container.decodeIfPresent(Int.self, forKey: .circulateCount)
        circulateSelf = try container.decodeIfPresent(Int.self, forKey: .circulateSelf)
        rawText = try container.decodeIfPresent(String.self, forKey: .rawText)
        postID = try container.decodeIfPresent(String.self, forKey: .postID)
        postedBy = try container.decodeIfPresent(String.self, forKey: .postedBy)
        userType = try container.decodeIfPresent(String.self, forKey: .userType)
        userVerification = try container.decodeIfPresent(Int.self, forKey: .userVerification)
        userVerificationFlags = try container.decodeIfPresent(Int.self, forKey: .userVerificationFlags)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        like = try container.decodeIfPresent(Int.self, forKey: .like)
        dislike = try container.decodeIfPresent(Int.self, forKey: .dislike)
        favorite = try container.decodeIfPresent(Int.self, forKey: .favorite)
        dmShareCount = try container.decodeIfPresent(Int.self, forKey: .dmShareCount)
        comment = try container.decodeIfPresent(Int.self, forKey: .comment)
        postQuote = try container.decodeIfPresent(Int.self, forKey: .postQuote)
        likeSelf = try container.decodeIfPresent(Int.self, forKey: .likeSelf)
        dislikeSelf = try container.decodeIfPresent(Int.self, forKey: .dislikeSelf)
        favoriteSelf = try container.decodeIfPresent(Int.self, forKey: .favoriteSelf)
        dmShareSelf = try container.decodeIfPresent(Int.self, forKey: .dmShareSelf)
        selfUser = try container.decodeIfPresent(Int.self, forKey: .selfUser)
        muted = try container.decodeIfPresent(Int.self, forKey: .muted)
        commentSelf = try container.decodeIfPresent(Int.self, forKey: .commentSelf)
        postQuoteSelf = try container.decodeIfPresent(Int.self, forKey: .postQuoteSelf)
        verified = try container.decodeIfPresent(Verified.self, forKey: .verified)
        actionCount = try container.decodeIfPresent(Int.self, forKey: .actionCount)
        isFollowing = try container.decodeIfPresent(Int.self, forKey: .isFollowing)
        hasChild = try container.decodeIfPresent(Bool.self, forKey: .hasChild)
        formattedCreatedAt = try container.decodeIfPresent(String.self, forKey: .formattedCreatedAt)
        formattedCreatedAtShort = try container.decodeIfPresent(String.self, forKey: .formattedCreatedAtShort)
        mentionedUsernames = try container.decodeIfPresent([String].self, forKey: .mentionedUsernames)
        htmlModifiedText = try container.decodeIfPresent(String.self, forKey: .htmlModifiedText)
        isThread = try container.decodeIfPresent(Bool.self, forKey: .isThread)
        isCompressed = try container.decodeIfPresent(Int.self, forKey: .isCompressed)
        parentAccountVerification = try container.decodeIfPresent(Int.self, forKey: .parentAccountVerification)
        parentAccountVerificationFlags = try container.decodeIfPresent(Int.self, forKey: .parentAccountVerificationFlags)
        circUsername = try container.decodeIfPresent(String.self, forKey: .circUsername)
        urls = try container.decodeIfPresent(ChildUrls.self, forKey: .urls)
        keywords = try container.decodeIfPresent([String].self, forKey: .keywords)
        
        if let creationTime = self.createdAt {
            self.formattedPostCreatedAt =  self.getFormattedCreatedDateAtText(createdAt: creationTime)
        }
    }
    
    mutating func getMediaType(){
        if media != nil {
            if media!.count == 0 {
                
                if urls != nil ,urls!.youtube == nil, urls!.other != nil {
                    mediaType = .linkPreview
                } else if urls != nil, urls!.other == nil, urls!.youtube != nil {
                    mediaType = .youtube
                }
            }
        } else {
            if urls != nil ,urls!.youtube == nil, urls!.other != nil {
                mediaType = .linkPreview
            }else if urls != nil, urls!.other == nil, urls!.youtube != nil {
                mediaType = .youtube
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(_id)
    }
    
    // Implementing Equatable
    static func ==(lhs: TownHallPost, rhs: TownHallPost) -> Bool {
        return lhs.id == rhs.id && lhs._id == rhs._id
    }
    
    func getFormattedCreatedDateAtText(createdAt: String, from dateFormattedString: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> String {
        let createdAtDate = createdAt.getDateFormatServer(from: dateFormattedString)
        let duration = Date().dateDifferenceFromSortAbrivation(date: createdAtDate)
        var formattedCreatedAt = "\(duration) ago"
        
        switch formattedCreatedAt {
        case "a sec ago":
            formattedCreatedAt = "sec"
        case "a min ago":
            formattedCreatedAt = "min"
        case "an hour ago":
            formattedCreatedAt = "hr"
        case "a day ago":
            formattedCreatedAt = "d"
        case "a week ago":
            formattedCreatedAt = "w"
        case "a month ago":
            formattedCreatedAt = "mn"
        case "a year ago":
            formattedCreatedAt = "yr"
        default:
            break
        }
        return formattedCreatedAt
    }
    
    
}

// MARK: - IsDeleted
struct IsDeletedItem: Codable {
    let status: Int?

    enum CodingKeys: String, CodingKey {
        case status = "status"
    }
}

// MARK: - Child
struct TownHallChild: Codable {
    let id: String?
    let postID: String?
    let userID: String?
    let isDeleted: Int?
    let media: [TownHallMediaItem]?
    var mediaType: MediaTypeNew?
    let createdAt: String?
    let text: String?
    let rawText: String?
    let type: String?
    let parentType: ParentType?
    let mentionedUsers: [String]?
    let name: String?
    let username: String?
    let userType: String?
    let urls: ChildUrls?
    let comment: Int?
    var like: Int?
    var dislike: Int?
    var circulateCount: Int?
    let postQuote: Int?
    var circulateSelf: Int?
    let commentSelf: Int?
    var likeSelf: Int?
    var dislikeSelf: Int?
    let favoriteSelf: Int?
    let selfUser: Int?
    let muted: Int?
    let postQuoteSelf: Int?
    let isConverted: Int?
    let formattedCreatedAt: String?
    let formattedCreatedAtShort: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case postID = "post_id"
        case userID = "user_id"
        case isDeleted = "is_deleted"
        case media = "media"
        case mediaType = "media_type"
        case createdAt = "created_at"
        case text = "text"
        case rawText = "raw_text"
        case type = "type"
        case parentType = "parent_type"
        case mentionedUsers = "mentioned_users"
        case name = "name"
        case username = "username"
        case userType = "user_type"
        case urls = "urls"
        case comment = "comment"
        case like = "like"
        case dislike = "dislike"
        case circulateCount = "circulate_count"
        case postQuote = "post_quote"
        case circulateSelf = "circulate_self"
        case commentSelf = "comment_self"
        case likeSelf = "like_self"
        case dislikeSelf = "dislike_self"
        case favoriteSelf = "favorite_self"
        case selfUser = "self"
        case muted = "muted"
        case postQuoteSelf = "post_quote_self"
        case isConverted = "is_converted"
        case formattedCreatedAt = "formatted_created_at"
        case formattedCreatedAtShort = "formatted_created_at_short"
    }
}

enum MediaTypeNew: Codable, Equatable {
    case audio
    case none
    case image
    case video
    case youtube
    case linkPreview
    case document(Documents)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        
        switch rawValue {
        case "AUDIO":
            self = .audio
        case "IMAGE":
            self = .image
        case "VIDEO":
            self = .video
        case "YOUTUBE":
            self = .youtube
        case "LINKPREVIEW":
            self = .linkPreview
        case Documents.csv.rawValue.uppercased(),
             Documents.doc.rawValue.uppercased(),
             Documents.docx.rawValue.uppercased(),
             Documents.pdf.rawValue.uppercased(),
             Documents.xls.rawValue.uppercased(),
             Documents.xlsx.rawValue.uppercased(),
             Documents.ppt.rawValue.uppercased(),
             Documents.pptx.rawValue.uppercased():
            guard let docType = Documents(rawValue: rawValue.lowercased()) else {
                self = .none
                return
            }
            self = .document(docType)
        default:
            self = .none
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .audio:
            try container.encode("AUDIO")
        case .none:
            try container.encode("")
        case .image:
            try container.encode("IMAGE")
        case .video:
            try container.encode("VIDEO")
        case .youtube:
            try container.encode("YOUTUBE")
        case .linkPreview:
            try container.encode("LINKPREVIEW")
        case .document(let documentType):
            try container.encode(documentType.rawValue)
        }
    }
    
    var rawValue: String {
        switch self {
        case .audio:
            return "AUDIO"
        case .image:
            return "IMAGE"
        case .video:
            return "VIDEO"
        case .youtube:
            return "YOUTUBE"
        case .linkPreview:
            return "LINKPREVIEW"
        case .document(let docType):
            return docType.rawValue
        case .none:
            return ""
        }
    }
    
    static func from(rawValue: String) -> MediaTypeNew? {
        switch rawValue {
        case "AUDIO":
            return .audio
        case "IMAGE":
            return .image
        case "VIDEO":
            return .video
        case "YOUTUBE":
            return .youtube
        case "LINKPREVIEW":
            return .linkPreview
        case Documents.csv.rawValue.uppercased(),
             Documents.doc.rawValue.uppercased(),
             Documents.docx.rawValue.uppercased(),
             Documents.pdf.rawValue.uppercased(),
             Documents.xls.rawValue.uppercased(),
             Documents.xlsx.rawValue.uppercased(),
             Documents.ppt.rawValue.uppercased(),
             Documents.pptx.rawValue.uppercased():
            guard let docType = Documents(rawValue: rawValue.lowercased()) else {
                return nil
            }
            return .document(docType)
        default:
            return nil
        }
    }
}
enum ParentType: String, Codable {
    case empty = ""
    case post = "POST"
    case rss = "RSS"
    case roundTable = "ROUNDTABLE"
}

enum ParentTypeEnum: String, Codable {
    case comment = "COMMENT"
    case empty = ""
    case poll = "POLL"
    case post = "POST"
    case rss = "RSS"
    case requote = "REQUOTE"
}

// MARK: - ChildUrls
struct ChildUrls: Codable {
    let youtube: [YoutubeNew]?
    let other: [Other]?
    enum CodingKeys: String, CodingKey {
        case other = "other"
        case youtube = "youtube"
    }
}
// MARK: - Youtube
struct YoutubeNew: Codable {
    let videoID: String
    let completeURL: String

    enum CodingKeys: String, CodingKey {
        case videoID = "video_id"
        case completeURL = "complete_url"
    }
}
// MARK: - Other
struct Other: Codable {
    let completeURL: String

    enum CodingKeys: String, CodingKey {
        case completeURL = "complete_url"
    }
}

enum ChildUserType: String, Codable {
    case empty = ""
    case rss = "RSS"
    case userTypeDEFAULT = "DEFAULT"
}

// MARK: - CommentsList
struct CommentsList: Codable {
    let id: String?
    let postID: String?
    let userID: String?
    let isDeleted: Int?
    let media: [TownHallMediaItem]?
    let mediaType: String?
    let createdAt: String?
    let text: String?
    let rawText: String?
    let type: String?
    let parentType: String?
    let mentionedUsers: [String]?
    let name: String?
    let username: String?
    let userType: String?
    let urls: CommentsListUrls?
    let isConverted: Int?
    let comment: Int?
    var like: Int?
    var dislike: Int?
    var circulateCount: Int?
    let postQuote: Int?
    var circulateSelf: Int?
    let commentSelf: Int?
    var likeSelf: Int?
    var dislikeSelf: Int?
    let favoriteSelf: Int?
    let selfUser: Int?
    let muted: Int?
    let postQuoteSelf: Int?
    let formattedCreatedAt: String?
    let formattedCreatedAtShort: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case postID = "post_id"
        case userID = "user_id"
        case isDeleted = "is_deleted"
        case media = "media"
        case mediaType = "media_type"
        case createdAt = "created_at"
        case text = "text"
        case rawText = "raw_text"
        case type = "type"
        case parentType = "parent_type"
        case mentionedUsers = "mentioned_users"
        case name = "name"
        case username = "username"
        case userType = "user_type"
        case urls = "urls"
        case isConverted = "is_converted"
        case comment = "comment"
        case like = "like"
        case dislike = "dislike"
        case circulateCount = "circulate_count"
        case postQuote = "post_quote"
        case circulateSelf = "circulate_self"
        case commentSelf = "comment_self"
        case likeSelf = "like_self"
        case dislikeSelf = "dislike_self"
        case favoriteSelf = "favorite_self"
        case selfUser = "self"
        case muted = "muted"
        case postQuoteSelf = "post_quote_self"
        case formattedCreatedAt = "formatted_created_at"
        case formattedCreatedAtShort = "formatted_created_at_short"
    }
}

// MARK: - CommentsListUrls
struct CommentsListUrls: Codable {
}

enum MessageSenderType: String, Codable {
    case speaker = "SPEAKER"
}

//enum Lang: String, Codable {
//    case en = "en"
//    case und = "und"
//    case vi = "vi"
//}

// MARK: - LikedUsername
struct LikedUsername: Codable {
    let username: String?

    enum CodingKeys: String, CodingKey {
        case username = "username"
    }
}

// MARK: - Media
struct TownHallMediaItem: Codable {
    let name: String?
    let tempID: String?
    let caption: String?
    let tags: String?
    let extra: ExtraItem?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case tempID = "temp_id"
        case caption = "caption"
        case tags = "tags"
        case extra = "extra"
    }
}

// MARK: - Extra
struct ExtraItem: Codable {
    let ext: String?
    let orignalFilename: String?
    let filename: String?
    let duration: Duration?
    let convertedFilename: String?

    enum CodingKeys: String, CodingKey {
        case ext = "ext"
        case orignalFilename = "orignalFilename"
        case filename = "filename"
        case duration = "duration"
        case convertedFilename = "convertedFilename"
    }
}

enum Duration: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Duration.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Duration"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PollingData
struct PollingData: Codable {
    let result: ResultItem?
    let anonymousPolled: [String: [String]]?
    let options: [String]?
    let isExpired: Bool?
    let question: String?
    let startDate: String?
    let endDate: String?
    let duration: String?
    let totalCount: Int?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case anonymousPolled = "anonymousPolled"
        case options = "options"
        case isExpired = "is_expired"
        case question = "question"
        case startDate = "start_date"
        case endDate = "end_date"
        case duration = "duration"
        case totalCount = "total_count"
    }
}

// MARK: - Result
struct ResultItem: Codable {
    let options: [String]?
    let percent: [String]?
    let allUserPolled: [String]?

    enum CodingKeys: String, CodingKey {
        case options = "options"
        case percent = "percent"
        case allUserPolled = "allUserPolled"
    }
}

// MARK: - RoundTableData
struct TownHallRoundTableData: Codable {
    let isDeleted: IsDeletedItem?
    let pins: [PinItem]?
    let roundTableId: String?
    let messageSenderType: String?
    let text: String?
    let tempId: String?
    let openToAll: String?
    let isHidden: Int?
    
    enum CodingKeys: String, CodingKey {
        case isDeleted = "is_deleted"
        case pins = "pins"
        case roundTableId = "round_table_id"
        case messageSenderType = "message_sender_type"
        case text = "text"
        case tempId = "temp_id"
        case openToAll = "open_to_all"
        case isHidden = "is_hidden"
    }
}

// MARK: - Verified
struct PinItem: Codable {
    let userId: String?
    let createdAt: String?
    let panelType: String?
    let isDeleted: IsDeletedItem?

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case createdAt = "created_at"
        case panelType = "panel_type"
        case isDeleted = "is_deleted"
    }
}

enum OldPostUserType: String, Codable {
    case respected = "respected"
    case rss = "RSS"
    case userTypeDEFAULT = "DEFAULT"
}

// MARK: - Verified
struct Verified: Codable {
    let verification: Verification?
    let verificationCount: Int?

    enum CodingKeys: String, CodingKey {
        case verification = "verification"
        case verificationCount = "verification_count"
    }
}

// MARK: - Verification
struct Verification: Codable {
    let identity: Addressdocument?
    let addressdocument: Addressdocument?
    let profession: Addressdocument?
    let industry: Addressdocument?
    let interest: Addressdocument?

    enum CodingKeys: String, CodingKey {
        case identity = "identity"
        case addressdocument = "addressdocument"
        case profession = "profession"
        case industry = "industry"
        case interest = "interest"
    }
}

// MARK: - Addressdocument
struct Addressdocument: Codable {
    let flag: Bool?

    enum CodingKeys: String, CodingKey {
        case flag = "flag"
    }
}

enum Documents: String {
    case csv, doc, docx, pdf, xls, xlsx, ppt, pptx, txt
}

struct PostLikeDislikeModel: Codable {
    let data: PostLikeDislikeData
    let code: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case code = "code"
        case message = "message"
    }
}

struct PostLikeDislikeData: Codable {
    let ogPostID: String
    let type: String
    let likes: Int
    let selfDislikes: Int
    let dislikes: Int
    let postID: String
    let selfLikes: Int

    enum CodingKeys: String, CodingKey {
        case ogPostID = "og_post_id"
        case type = "type"
        case likes = "likes"
        case selfDislikes = "self_dislikes"
        case dislikes = "dislikes"
        case postID = "post_id"
        case selfLikes = "self_likes"
    }
}
enum ActionsType : String {
    case like = "LIKE"
    case dislike = "DISLIKE"
    case repost = "REPOST" // its using for Repost
    case favourite = "FAVORITE" // its using for Save post
}
