//
//  School_AdidevtechnologiesTests.swift
//  School-AdidevtechnologiesTests
//
//  Created by Vladislav on 11.12.2022.
//

import XCTest
@testable import School_Adidevtechnologies

final class School_AdidevtechnologiesTests: XCTestCase {

    var schoolCellModel: SchoolCellModel!
    var schoolModel: SchoolAdditionalInformationModel!
    var schoolNetworkModel: SchoolAdditionalInformationNetworkModel!
    
    override func setUpWithError() throws {
        schoolCellModel = SchoolCellModel([:])
        
        schoolNetworkModel = SchoolAdditionalInformationNetworkModel(dbn: "Test", schoolName: "Test", numOfSatTestTakers: nil, satCriticalReadingAvgScore: nil, satMathAvgScore: nil, satWritingAvgScore: "Test")
        schoolModel = SchoolAdditionalInformationModel(schoolNetworkModel)
    }

    override func tearDownWithError() throws {
         schoolCellModel = nil
         schoolModel = nil
         schoolNetworkModel = nil
     
    }

    func testExample() throws {
   
        XCTAssertNotNil(schoolModel.schoolName, "Model checking")
        XCTAssertNotNil(schoolModel.dbn, "Model checking")
        
        XCTAssertNil(schoolModel.satWritingAvgScore, "Model checking")
        XCTAssertNil(schoolModel.satMathAvgScore, "Model checking")
        XCTAssertNil(schoolModel.satCriticalReadingAvgScore, "Model checking")
        XCTAssertNotNil(schoolModel.numOfSatTestTakers, "Model checking")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
