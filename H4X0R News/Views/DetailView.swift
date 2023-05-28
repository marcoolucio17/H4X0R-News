//
//  DetailView.swift
//  H4X0R News
//
//  Created by Marco Lucio Sosa on 2/6/23.
//

import SwiftUI

//  Generates a web view inside a view based on the url given
struct DetailView: View {
    
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https:google.com")
    }
}
 
