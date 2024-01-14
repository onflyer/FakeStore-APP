//
//  CustomTextField.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/13/24.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    let placeholder: String
    @Binding var hasError: Bool
    
    @FocusState var focused: Bool
    
    var body: some View {
        let isActive = focused || text.count > 0
        
        ZStack(alignment: isActive ? .topLeading : .center) {
            TextField("", text: $text)
                .frame(height: 24)
                .font(.system(size: 16, weight: .regular))
                .opacity(isActive ? 1 : 0)
                .offset(y: 7)
                .focused($focused)
            
            HStack {
                Text(placeholder)
                    .foregroundColor(.black.opacity(0.3))
                    .frame(height: 16)
                    .font(.system(size: isActive ? 12 : 16, weight: .regular))
                    .offset(y: isActive ? -7 : 0)
                Spacer()
            }
        }
        .onTapGesture {
            focused = true
        }
        .animation(.linear(duration: 0.2), value: focused)
        .frame(height: 56)
        .padding(.horizontal, 16)
        .background(.white)
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(focused ? .black.opacity(0.6) : .black.opacity(0.2), lineWidth: 2)
        }
        .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(hasError ? .red.opacity(0.6) : .black.opacity(0.0), lineWidth: 2)
            if hasError {
                Text("Username cannot be empty")
                    .foregroundStyle(.red.opacity(0.6))
                    .font(.footnote)
                    .offset(x: -81, y: 37)
            }
        }
        
    }
}


#Preview {
    CustomTextField(text: .constant("Username"), placeholder: "Enter your username", hasError: .constant(true))
        
}
#Preview {
    CustomTextField(text: .constant("Username"), placeholder: "Enter your username", hasError: .constant(false))
}
