import SwiftUI

struct TabViewContainer: View {
  

    var body: some View {
        VStack {
            TabView {
                ForEach(tabs) { tab in
                    tab.view
                        .tabItem {
                            Image(systemName: tab.iconName)
                            Text(tab.title)
                        }
                }
            }
            .padding(.top)

        }
    }
}
