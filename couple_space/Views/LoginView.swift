//
//  LoginView.swift
//  couple_space
//
//  Created by Emanuel on 07.03.26.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.pink)
            
            Text("CoupleSpace")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Euer gemeinsamer Ort für Kalender, Notizen und mehr.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            Button(action: {
                isLoggedIn = true
            }) {
                Text("Jetzt starten")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(14)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
    }
}


#Preview {
    LoginView(isLoggedIn: .constant(false))
}
