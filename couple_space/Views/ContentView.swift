//
//  ContentView.swift
//  couple_space
//
//  Created by Emanuel on 07.03.26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        #if os(iOS)
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }
            CalenderView()
                .tabItem {
                    Label("Kalender", systemImage: "calendar")
                }
            NotesView()
                .tabItem {
                    Label("Notizen", systemImage: "note.text")
                }
            Text("Profil kommt noch")
                .tabItem {
                    Label("Profil", systemImage: "person.2")
                }
        }
        #else
        NavigationSplitView {
            List {
                NavigationLink("Dashboard", destination: DashboardView())
                NavigationLink("Kalender", destination:CalenderView())
                NavigationLink("Notizen", destination: NotesView())
                NavigationLink("Profil", destination: Text("Profil"))
            }
            .navigationTitle("Couple Space")
        } detail: {
            Text("Wähle einen Bereich")
        }
        #endif
    }
}

#Preview {
    ContentView()
}
