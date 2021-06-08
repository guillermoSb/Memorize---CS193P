//
//  Grid.swift
//  Memorize
//
//  Created by Guille on 12/05/21.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
  
  private var items = [Item]()  // Items to be displayed on the Grid
  private var viewForItem: (Item) -> ItemView // View to render for every item
  
  init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
    self.items = items  // Assign the items
    self.viewForItem = viewForItem  // This function can escape the body
  }
  
  var body: some View {
    // Read the available size
    
    
    GeometryReader(content: { geometry in
      let gridLayout = GridLayout(itemCount: items.count, in: geometry.size)
      ForEach(items) { (item) in
      
        self.body(for: item, in: gridLayout)
        
      }
    })
  }
  
  private func body(for item: Item, in layout: GridLayout) -> some View {
    return viewForItem(item) // Generate a view for the Item
      .frame(width: layout.itemSize.width, height: layout.itemSize.height)
      .position(layout.location(ofItemAt: items.index(for: item)!))
  }
}

