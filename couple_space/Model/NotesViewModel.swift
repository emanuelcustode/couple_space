//
//  NotesViewModel.swift
//  couple_space
//
//  Created by Emanuel on 07.03.26.
//


import Foundation
internal import Combine

@MainActor
class NotesViewModel: ObservableObject {

    @Published var notes: [Note] = []
    @Published var isLoading: Bool = false
    @Published var error: Error? = nil
    
    private let service: CloudKitService
    
    init(service: CloudKitService) {
        self.service = service
    }
    
    func fetchNotes() async {
        isLoading = true
        do {
            try await service.fetchNotes()
            self.notes = service.notes
        } catch {
            self.error = error
        }
        isLoading = false
    }
    
    func createNote(_ note: Note) async {
        isLoading = true
        do {
            try await service.createNote(note)
             await fetchNotes()
        } catch {
            self.error = error
        }
        isLoading = false
    }
    
    func deleteNote(_ note: Note) async {
        do {
            try await service.deleteNote(note)
            await fetchNotes()
        } catch {
            self.error = error
        }
    }
    
    func updateNote(_ note: Note) async {
        do {
            try await service.updateNote(note)
            await fetchNotes()
        } catch {
            self.error = error
        }
    }
}
