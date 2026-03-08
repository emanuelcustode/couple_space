//
//  CalendarEvent.swift
//  couple_space
//
//  Created by Emanuel on 07.03.26.
//

import Foundation

enum Repetition {
    case none
    case daily
    case weekly
    case monthly
    case yearly
}

struct CalendarEvent : Identifiable {
    let id: UUID
    let createdBY: UUID
    let spaceID: UUID
    let title: String
    let start: Date
    let end: Date?
    let repetition: Repetition
    let description: String
}
