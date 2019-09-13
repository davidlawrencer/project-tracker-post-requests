//
//  Client.swift
//  project-tracker-post-requests
//
//  Created by Levi Davis on 9/12/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct ClientResponse: Codable {
    let records: [ClientWrapper]
}



struct ClientWrapper: Codable {
    
    let client: Client
    
    private enum CodingKeys: String, CodingKey {
        case client = "fields"
    }
    
    
    
}

struct Client: Codable {
    var Name: String
    var Logo: [LogoWrapper]?
    var About: String
    
    static func getClients(from jsonData: Data) throws -> [Client] {
        let response = try JSONDecoder().decode(ClientResponse.self, from: jsonData)
        return response.records.map {$0.client}
    }
    
    
}

struct LogoWrapper: Codable {
    let url: String
}

/*
 {
 "id": "recsF7o7mjA5sg31j",
 "fields": {
 "Name": "CUBE Systems Corporation",
 "Logo": [
 {
 "id": "attYQH6JxuMVaPaL0",
 "url": "https://dl.airtable.com/.attachments/7e02232ed461e3e7f305de386d8fb541/ebd0c2a1/scribble1.png",
 "filename": "scribble1.png",
 "size": 156943,
 "type": "image/png",
 "thumbnails": {
 "small": {
 "url": "https://dl.airtable.com/.attachmentThumbnails/05417c3b722ca0a63d9cd4f8c4de5643/bcec01e8",
 "width": 45,
 "height": 36
 },
 "large": {
 "url": "https://dl.airtable.com/.attachmentThumbnails/1d3360e4e3ffcc4027515a387ddcb3e1/44590300",
 "width": 640,
 "height": 512
 },
 "full": {
 "url": "https://dl.airtable.com/.attachmentThumbnails/072bf29d957025ba969abf0d4a84cc35/c15c62f6",
 "width": 3000,
 "height": 3000
 }
 }
 }
 ],
 "Projects": [
 "recM8y5c6im0at9oe",
 "recW2mR5p9GjYRhZc",
 "recqw6RBCGq5hXYpU"
 ],
 "About": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
 },
 "createdTime": "2015-02-10T20:51:40.000Z"
 }*/
