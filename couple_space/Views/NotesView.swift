//
//  NotesView.swift
//  couple_space
//
//  Created by Emanuel on 08.03.26.
//

import SwiftUI

struct NotesView: View {
    
    @State private var showCreateNote: Bool = false
    
    private let mockNotes = [
        Note(id: UUID(), title: "Einkaufsliste", description: "Milch, Eier, Brot...", createdAt: Date(), updatedAt: Date(), createdBy: UUID(), updatedBy: UUID(), spaceID: UUID()),
        Note(id: UUID(), title: "Urlaubsplanung", description: "Flüge nach Barcelona...", createdAt: Date(), updatedAt: Date(), createdBy: UUID(), updatedBy: UUID(), spaceID: UUID()),
        Note(id: UUID(), title: "Ideen", description: "Gemeinsames Hobby finden...", createdAt: Date(), updatedAt: Date(), createdBy: UUID(), updatedBy: UUID(), spaceID: UUID()),
        Note(id: UUID(), title: "Rezepte", description: "Pasta Carbonara Rezept...", createdAt: Date(), updatedAt: Date(), createdBy: UUID(), updatedBy: UUID(), spaceID: UUID())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {
                    ForEach(mockNotes) { note in
                        NavigationLink(destination: NoteDetailView(note: note)) {
                            NoteCard(title: note.title, preview: note.description)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .navigationTitle("Notizen")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showCreateNote = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
#if os(iOS)
            .sheet(isPresented: $showCreateNote) {
                CreateNoteView()
            }
#else
            .popover(isPresented: $showCreateNote) {
                CreateNoteView()
                    .frame(width: 400, height: 400)
            }
#endif
        }
    }
}

#Preview {
    NotesView()
}
