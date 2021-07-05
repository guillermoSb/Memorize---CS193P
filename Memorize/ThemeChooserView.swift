//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by Guille on 27/06/21.
//

import SwiftUI

struct ThemeChooserView: View {
  @ObservedObject var themeStore: ThemeStore
  @State var editMode: EditMode = EditMode.inactive
  
  var body: some View {
    NavigationView {
      List {
        // MARK: - TODO REMOVE LATER AND USE LIBRARY THEMES
        ForEach(themeStore.themes) { theme in
          NavigationLink(
            destination: EmojiMemoryGameView(theme: theme),
            label: {
              ThemeOption(editMode: $editMode, theme: theme).environmentObject(themeStore)
            }
          )
          
        }
        .onDelete(perform: { indexSet in
          // Remove all the themes from the indexSet
          for index in indexSet {
            themeStore.removeTheme(at: index)
          }
        })
      }
      
      .navigationBarTitle("Themes")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar(content: {
        ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
          Button(action: {
            themeStore.addTheme()
          }, label: {
            Image(systemName: "plus").imageScale(.large)
          })
        }
        ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
          EditButton()
        }
        
      })
      .environment(\.editMode, $editMode)
    }
    
  }
  
}



struct ThemeOption: View {
  @Binding var editMode: EditMode
  @State var showEditThemeSheet: Bool = false
  @EnvironmentObject var themeStore: ThemeStore
  var theme: Theme
  
  var body: some View {
    VStack {
      HStack {
        if editMode == .active {
          Circle()
            .foregroundColor(theme.color)
            .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .overlay(Image(systemName: "pencil").foregroundColor(.white))
            .onTapGesture {
              showEditThemeSheet = true
            }
        } else {
          Circle()
            .foregroundColor(theme.color)
            .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        Text(theme.name)
          .font(.system(size: 20, weight: .regular, design: .rounded))
      }.frame(maxWidth: .infinity, alignment: .leading)
      HStack {
        Text("\(theme.pairs) Pairs using")
        Text("\(theme.content.joined(separator: " ").truncate(lenght: 12))")
        
      }.frame(maxWidth: .infinity, alignment: .leading)
      
    }
    .sheet(isPresented: $showEditThemeSheet, content: {
      ThemeEditor(theme: theme).environmentObject(themeStore)
    })
  }
}

struct ThemeChooser_Previews: PreviewProvider {
  static var previews: some View {
    ThemeChooserView(themeStore: ThemeStore())
  }
}
