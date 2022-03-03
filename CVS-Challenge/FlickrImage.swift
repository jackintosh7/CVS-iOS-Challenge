//
//  ImageModel.swift
//  CVS-Challenge
//
//  Created by Jack Higgins on 3/1/22.
//

import Foundation

struct FlickrResponseModel: Decodable {
    let title: String?
    let items: [FlickrImage]?
}

struct FlickrImage: Decodable, Identifiable {
    let id = UUID()
    let title: String
    let link: String
    let media: URL
    let dateTaken: String
    let description: String
    let published: String
    let author: String
    let authorID: String
    let tags: String
    
    init(title: String, link: String, media: URL, dateTaken: String, description: String, published: String, author: String, authorID: String, tags: String) {
        self.title = title
        self.link = link
        self.media = media
        self.dateTaken = dateTaken
        self.description = description
        self.published = published
        self.author = author
        self.authorID = authorID
        self.tags = tags
    }

    enum CodingKeys: String, CodingKey {
        case title, link, media, description, published, author, tags
        case authorID = "author_id"
        case dateTaken = "date_taken"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode values
        title = try values.decode(String.self, forKey: .title)
        link = try values.decode(String.self, forKey: .link)
        dateTaken = try values.decode(String.self, forKey: .dateTaken)
        description = try values.decode(String.self, forKey: .description)
        published = try values.decode(String.self, forKey: .published)
        author = try values.decode(String.self, forKey: .author)
        authorID = try values.decode(String.self, forKey: .authorID)
       
        // Decode tags, and spaces to the string to make it easier on the eyes
        let tagString = try values.decode(String.self, forKey: .tags)
        let tagList = tagString.replacingOccurrences(of: " ", with: ", ", options: .literal, range: nil)
        tags = tagList
       
        // Decode and parse media url (this returns us the actual image URL)
        let mediaDictionary = try values.decode([String: String].self, forKey: .media)
        let urlStr = mediaDictionary["m"] ?? ""
        media = try urlStr.asURL()
    }
}
