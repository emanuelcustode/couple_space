//
//  User.swift
//  couple_space
//
//  Created by Emanuel on 07.03.26.
//

import Foundation

public struct User: Codable {
    let id: UUID
    let name: String
    let spaceId: UUID?
}
