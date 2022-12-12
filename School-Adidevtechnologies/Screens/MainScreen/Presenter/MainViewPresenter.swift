//
//  MainViewPresenter.swift
//  School-Adidevtechnologies
//
//  Created by Vladislav on 11.12.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    var schools: [SchoolCellModel]? {get set}
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getFirstSchoolsList()
    func tapOnSchool(dbn: String)
    func loadMoreSchools()
}

class MainViewPresenter: MainViewPresenterProtocol {
    weak private var searchViewDelegate: MainViewPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    private var router: RouterProtocol?
    private var offsetSchools = 0
    weak var view: MainViewProtocol?
    var schools: [SchoolCellModel]?
    

    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func getFirstSchoolsList() {
        self.offsetSchools = 0
        
        self.networkService.getAllSchools(offset: offsetSchools){ [weak self] (data, error) in
            if let error = error {
                print(error.localizedDescription)
                self?.view?.failure(error: error)
                return
            }
            if let data = data {
                self?.schools = data.map { SchoolCellModel.init($0) }
                                   // .sorted(by: { $0.schoolName < $1.schoolName })
                self?.view?.success()
            }
        }
    }
    
    func tapOnSchool(dbn: String) {
         self.router?.showSchoolAdditionalInformation(dbn: dbn)
    }
    
    func loadMoreSchools(){
        if let count = self.schools?.count {
            self.offsetSchools = count + 30
        }
        
        self.networkService.getAllSchools(offset: offsetSchools){ [weak self] (data, error) in
            if let error = error {
                print(error.localizedDescription)
                self?.view?.failure(error: error)
                return
            }
            if let data = data {
                _ = data.map {
                    self?.schools?.append(SchoolCellModel.init($0))
                }
                self?.view?.success()
            }
        }
    }
    
}
