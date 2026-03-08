//
//  CalenderViewModel.swift
//  couple_space
//
//  Created by Emanuel on 07.03.26.
//


import Foundation
internal import Combine

@MainActor
class CalenderViewModel: ObservableObject {
    
    @Published var calenderEvents: [CalendarEvent] = []
    @Published var selectedDate: Date? = nil
    @Published var isLoading: Bool = false
    @Published var error: Error? = nil
    
    
    private let service:  CloudKitService
    
    init(service: CloudKitService) {
        self.service = service
    }
    
    func fetchCalenderEvents() async {
        isLoading = true
        do {
            try await service.fetchCalendarEvents()
            self.calenderEvents = service.calendarEvents
        } catch {
            self.error = error
        }
        isLoading=false
    }
    
    func createCalendarEvent(_ event: CalendarEvent) async {
        isLoading = true
        do {
            try await service.createCalendarEvent(event)
            self.calenderEvents.append(event)
        } catch {
            self.error = error
        }
        isLoading=false
    }
    
    func deleteCalendarEvent(_ event: CalendarEvent) async {
        isLoading = true
        do {
            try await service.deleteCalendarEvent(event)
            self.calenderEvents.removeAll { $0.id == event.id }
        } catch {
            self.error = error
        }
        isLoading=false
    }
    
    func updateCalendarEvent(_ event: CalendarEvent) async {
        isLoading = true
        do {
                try await service.updateCalendarEvent(event)
                self.calenderEvents = self.calenderEvents.map {
                    $0.id == event.id ? event : $0
                }
        } catch {
            self.error = error
        }
        isLoading=false
    }
}
