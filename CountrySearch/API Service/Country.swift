//
//  Country.swift
//  CountrySearch
//
//  Created by Karen Bagotchay on 4/29/25.
//

import Foundation



class Country: Decodable {
    var region: String?
    var commonName: String?
    var officialName: String?
    
    
    enum CodingKeys: String, CodingKey {
        case region
        case name
    }
    
    
    enum NameCodingKeys: String, CodingKey {
        case common
        case official
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.region = try container.decodeIfPresent(String.self, forKey: .region)
        
        let nameContainer = try container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
        self.commonName = try nameContainer.decodeIfPresent(String.self, forKey: .common)
        self.officialName = try nameContainer.decodeIfPresent(String.self, forKey: .official)
    }
    
}
