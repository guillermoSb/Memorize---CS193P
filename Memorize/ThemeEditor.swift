//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Guille on 28/06/21.
//

import SwiftUI

struct ThemeEditor: View {
  @EnvironmentObject var themeStore: ThemeStore
  @State var theme: Theme
  @State var emojiToAdd: String = ""
  
  var body: some View {
    NavigationView {
      VStack {
        Form {
          Section(header: Text("Theme Details")) {
            TextField("Theme Name", text: $theme.name) { started in
              if !started {
                themeStore.save(theme: theme)
                
              }
            }
            Stepper("\(theme.pairs) Card Pairs", value: $theme.pairs, in: 2...theme.content.count, onEditingChanged: { began in
              if !began {
                themeStore.save(theme: theme)
              }
            })
            
            ThemeColorPicker(theme: $theme).environmentObject(self.themeStore)
            
          }
          
        }
      }
      .navigationTitle(Text("Edit Theme"))
    }
    
  }
}

struct ThemeColorPicker: View {
  
  @Binding var theme: Theme
  @EnvironmentObject var themeStore: ThemeStore
  
  private let colors: [UIColor] = [
    UIColor(.red), UIColor(.green), UIColor(.blue),
    UIColor(.orange), UIColor(.yellow), UIColor(.pink),
    UIColor(.black), UIColor(.purple)
  ]
  
  var body: some View {
    VStack {
      Text("Scroll to reveal colors")
      ScrollView(.horizontal, showsIndicators: false, content: {
        HStack {
          ForEach(colors, id: \.self) { color in
            ZStack {
              if theme.rgb == color.rgb {
                Color(color).frame(width: 40, height: 40)
                Image(systemName: "checkmark.circle").font(.system(size: checkMarkSize, weight: .bold, design: .rounded)).foregroundColor(.white).transition(.scale)
              } else {
                Color(color).frame(width: 40, height: 40)
                  .onTapGesture {
                    // Set the color to the theme
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)) {
                      self.theme.rgb = color.rgb
                      themeStore.save(theme: theme)
                    }
                    
                  }
              }
             
            
            }
            
          }
        }
      })
    }
    
  }
  
  private let checkMarkSize: CGFloat = 20.0
}

struct ThemeEditor_Previews: PreviewProvider {
  static var previews: some View {
    let themeStore = ThemeStore()
    return ThemeEditor(theme: ThemeStore.defaultTheme).environmentObject(themeStore)
  }
}
