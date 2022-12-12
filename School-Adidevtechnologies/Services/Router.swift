//
//  Router.swift
//  School-Adidevtechnologies
//
//  Created by Vladislav on 11.12.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? {get set}
    var moduleBuilder: ModuleBuilderProtocol? {get set}
}
protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showSchoolAdditionalInformation(dbn: String)
    func popToRoot()
}
class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = self.moduleBuilder?.createMainModule(router: self) else {return}
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showSchoolAdditionalInformation(dbn: String) {
        if let navigationController = navigationController {
            guard let schoolAdditionalInformationViewController = self.moduleBuilder?.createSchoolAdditionalInformation(dbn: dbn, router: self) else {return}
            navigationController.pushViewController(schoolAdditionalInformationViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}

