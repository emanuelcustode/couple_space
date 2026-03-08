//
//  CloudKitService.swift
//  couple_space
//
//  Created by Emanuel on 07.03.26.
//

import Foundation
internal import Combine

class CloudKitService : ObservableObject {
    
    @Published var isSyncing: Bool = false
    @Published var notes : [Note] = []
    @Published var calendarEvents : [CalendarEvent] = []
    @Published var user: User?
    @Published var coupleSpace: CoupleSpace?
    
    
    func fetchNotes()  async throws{}
    
    func fetchCalendarEvents() async throws {}
    
    func createNote(_ note: Note) async throws{}
    
    func createCalendarEvent(_ event: CalendarEvent) async throws{}
    
    func deleteNote(_ note: Note) async throws{}
    
    func updateNote(_ note: Note) async throws{}
    
    func deleteCalendarEvent(_ event: CalendarEvent) async throws{}
    
    func updateCalendarEvent(_ event: CalendarEvent) async throws{}
    
    
}
