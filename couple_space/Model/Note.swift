//
//  Note.swift
//  couple_space
//
//  Created by Emanuel on 07.03.26.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let createdAt: Date
    let updatedAt: Date
    let createdBy: UUID
    let updatedBy: UUID
    let spaceID: UUID
}
