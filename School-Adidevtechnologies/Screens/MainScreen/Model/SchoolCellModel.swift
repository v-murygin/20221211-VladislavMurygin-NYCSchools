//
//  SchoolCellModel.swift
//  School-Adidevtechnologies
//
//  Created by Vladislav on 11.12.2022.
//

import Foundation

struct SchoolCellModel  {

    let schoolName: String
    let dbn: String
    let overview: String?
    let phone: String?
    let website: String?
    let address: String?
  

    init(_ data: [String: String]){
        self.dbn = data["dbn"] ?? ""
        self.schoolName = data["school_name"] ?? ""
        self.overview = data["overview_paragraph"]
        self.phone = data["phone_number"]
        self.website = data["website"]
        self.address = data["primary_address_line_1"]
    }
    
    
}
