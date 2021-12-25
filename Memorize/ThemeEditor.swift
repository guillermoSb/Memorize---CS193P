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
  @State var showEmojiAlert = false

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
          
          
          Section(header: Text("Theme Emoji")) {
            Text("Tap Emoji to remove")
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
              LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize))], content: {
                ForEach(theme.content, id: \.self) { emoji in
                  Text(emoji)
                    .font(.system(size: emojiFont))
                    .padding()
                    .onTapGesture {
                      // Remove emoji from the theme
                      if let index = theme.content.firstIndex(of: emoji) {
                        if theme.content.count > 2 {
                          withAnimation {
                            theme.content.remove(at: index)
                            // Set the pairs
                            theme.pairs = min(theme.pairs, theme.content.count)
                            // Save the theme
                            themeStore.save(theme: theme)
                          }
                        } else {
                          showEmojiAlert = true
                        }
                        
                      }
                    }
                }
              })
            }
            .padding()
            .frame(minHeight: gridSize)
            Text("Add Emoji")
     
            TextField("Type Emoji", text: $emojiToAdd) { began in
              if !began {

                var newEmoji = theme.content
                //  Create array of emojis
                let emojis = Array(emojiToAdd)
                
               newEmoji.append(contentsOf: emojis.map({ character in
                  String(character)
                }))
                // Filter emojis
                var set = Set<String>()
                newEmoji = newEmoji.filter { character in
                  return set.insert(character).inserted
                }
                theme.content = newEmoji
                
                themeStore.save(theme: theme)
                emojiToAdd = ""
      
              }
            }
          }
          .alert(isPresented: $showEmojiAlert, content: {
            Alert(title: Text("Can't delete Emoji"), message: Text("Your theme must have at least two Emoji."), dismissButton: .default(Text("OK")))
          })
          
        }
      }
      .navigationTitle(Text("Edit Theme"))
    }
    
  }
  private let emojiFont: CGFloat = 50.0
  private let gridSize: CGFloat = 300.0
  private let gridItemSize: CGFloat = 80.0
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
