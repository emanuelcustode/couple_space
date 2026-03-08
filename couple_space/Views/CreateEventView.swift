//
//  CreateEventView.swift
//  couple_space
//
//  Created by Emanuel on 08.03.26.
//

import SwiftUI

struct CreateEventView: View {
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var date: Date = Date()
    @State private var repetiotion: Repetition = .none
    
    @Environment(\.dismiss)  var dismiss
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Details") {
                    TextField("Titel", text: $title)
                    TextField("Beschreibung", text: $description)
                }
                Section("Datum"){
                    DatePicker("Datum", selection: $date)
                    Picker("Wiederholung", selection: $repetiotion) {
                        Text("Keine").tag(Repetition.none)
                        Text("Täglich").tag(Repetition.daily)
                        Text("Wöchentlich").tag(Repetition.weekly)
                        Text("Monatlich").tag(Repetition.monthly)
                        Text("Jährlich").tag(Repetition.yearly)
                    }
                }
            }
            .navigationTitle(Text("Neues Ereignis"))
            .toolbar {
                ToolbarItem(placement: .cancellationAction){
                    Button("Abbrechen"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Speichern") {
                    }
                }
            }
        }
    }
}


#Preview {
    CreateEventView()
}
