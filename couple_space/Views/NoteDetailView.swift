//
//  NoteDetailView.swift
//  couple_space
//
//  Created by Emanuel on 08.03.26.
//

import SwiftUI

struct NoteDetailView: View {
    
    let note: Note
    @State private var title: String
    @State private var description: String
    @State private var hasChanges: Bool = false
    
    init(note: Note) {
        self.note = note
        _title = State(initialValue: note.title)
        _description = State(initialValue: note.description)
    }
    
    var body: some View {
        Form {
            Section("Titel") {
                TextField("Titel", text: $title)
                    .onChange(of: title) {
                        hasChanges = true
                    }
            }
            
            Section("Inhalt") {
                TextEditor(text: $description)
                    .frame(minHeight: 200)
                    .onChange(of: description) {
                        hasChanges = true
                    }
            }
            
            Section("Info") {
                HStack {
                    Text("Erstellt am")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(note.createdAt, style: .date)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle(title)
        .toolbar {
            if hasChanges {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Speichern") {
                    }
                }
            }
        }
    }
}

