//
//  PageModel.swift
//  Pinch
//
//  Created by Furqan on 01/06/2022.
//

import Foundation

struct Page:Identifiable
{
    let id:Int
    let imageName:String
}
extension Page{
    var thum:String{
        return "thumb-"+imageName
    }
}
