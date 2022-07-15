//
//  ControlImageView.swift
//  Pinch
//
//  Created by Furqan on 01/06/2022.
//

import SwiftUI

struct ControlImageView: View {
    let icon:String
    var body: some View {
        Image(systemName:icon)
            .font(.system(size: 30))
    }
}

struct ControlImageView_Previews: PreviewProvider {
    static var previews: some View {
        ControlImageView(icon:"plus.magnifyingglass").previewLayout(.sizeThatFits).preferredColorScheme(.dark).padding()
    }
}
