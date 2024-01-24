//
//  TextInputField.swift
//  FakeStore APP
//
//  Created by Aleksandar Milidrag on 1/24/24.
//

import SwiftUI

struct TextInputField: View {

    enum EditState {
        case idle
        case firstTime
        case secondOrMore
    }


    private var title: String
    private var prompt: String
    private var isValid: Bool

    @Binding private var text: String

    @State private var height: CGFloat = 0
    @State private var isFocused = false
    @State private var editState: EditState = .idle

    var showValidationErrorPrompt: Bool {
        !isValid && (editState == .secondOrMore)
    }

    init(_ title: String, prompt: String = "", text: Binding<String>, isValid: Bool) {
        self.title = title
        self._text = text
        self.prompt = prompt
        self.isValid = isValid
    }

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(text.isEmpty ? Color(.placeholderText) : .accentColor)
                    .offset(x: text.isEmpty ? 0 : -16, y: text.isEmpty ? 0 : -height * 0.85)
                    .scaleEffect(text.isEmpty ? 1: 0.9, anchor: .leading)
                    .padding()
                    .font(text.isEmpty ? .body: .body.bold())
                TextField("", text: $text) { _ in
                    withAnimation(.default) { isFocused.toggle() }
                    switch editState {
                        case .idle:
                            editState = .firstTime
                        case .firstTime:
                            editState = .secondOrMore
                        case .secondOrMore:
                            break
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(isFocused ? Color.accentColor : Color(.secondarySystemBackground), lineWidth: 2)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(showValidationErrorPrompt ? Color.red : Color.clear, lineWidth: 2)
                )
                .background(
                    GeometryReader { geometry in
                        Color(.clear).onAppear {
                            height = geometry.size.height
                        }
                    }
                )
            }
            .background {
                Color(.secondarySystemBackground)
                    .cornerRadius(5.0)
                    .shadow(radius: 5.0)
            }
            .animation(.default, value: text.isEmpty)
            .animation(.default, value: showValidationErrorPrompt)
            if showValidationErrorPrompt {
                Text(prompt)
                    .padding(.leading, 2)
                    .font(.footnote)
                    .foregroundColor(Color(.systemRed))
            }
        }
    }
}

#Preview {
    TextInputField("placeholder", prompt: "prompt", text: .constant("sss"), isValid: false)
}
