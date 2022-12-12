//
//  ModuleBuilder.swift
//  School-Adidevtechnologies
//
//  Created by Vladislav on 11.12.2022.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createSchoolAdditionalInformation(dbn: String, router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainViewPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createSchoolAdditionalInformation(dbn: String, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailViewPresenter(view: view, networkService: networkService, router: router, dbn: dbn)
        view.presenter = presenter
        return view
    }
}
