//
//  Created by Alex.M on 14.06.2022.
//

import SwiftUI

public struct TextInputView: View {
    
    @Environment(\.chatTheme) private var theme
    
    @EnvironmentObject private var globalFocusState: GlobalFocusState
    
    @Binding var text: String
    var inputFieldId: UUID
    var style: InputViewStyle
    var availableInput: AvailableInputType
    
    public init(text: Binding<String>, inputFieldId: UUID, style: InputViewStyle, availableInput: AvailableInputType) {
        self._text = text
        self.inputFieldId = inputFieldId
        self.style = style
        self.availableInput = availableInput
    }

    public var body: some View {
        TextField("", text: $text, axis: .vertical)
            .customFocus($globalFocusState.focus, equals: .uuid(inputFieldId))
            .placeholder(when: text.isEmpty) {
                Text(style.placeholder)
                    .foregroundColor(theme.colors.buttonBackground)
            }
            .foregroundColor(style == .message ? theme.colors.textLightContext : theme.colors.textDarkContext)
            .padding(.vertical, 10)
            .padding(.leading, availableInput == .textAndAudio ? 12 : 0)
            .onTapGesture {
                globalFocusState.focus = .uuid(inputFieldId)
            }
    }
}
