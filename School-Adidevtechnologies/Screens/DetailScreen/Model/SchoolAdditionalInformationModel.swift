//
//  SchoolAdditionalInformationModel.swift
//  School-Adidevtechnologies
//
//  Created by Vladislav on 11.12.2022.
//

import Foundation


struct SchoolAdditionalInformationModel: Codable {
    
    let dbn: String
    let schoolName: String
    let numOfSatTestTakers: String?
    let satCriticalReadingAvgScore: String?
    let satMathAvgScore: String?
    let satWritingAvgScore: String?
    
    init(_ data: SchoolAdditionalInformationNetworkModel) {
        self.dbn = data.dbn ?? ""
        self.schoolName = data.schoolName ?? ""
        self.numOfSatTestTakers = data.numOfSatTestTakers
        self.satCriticalReadingAvgScore = data.satCriticalReadingAvgScore
        self.satMathAvgScore = data.satMathAvgScore
        self.satWritingAvgScore = data.satWritingAvgScore 
    }
}
