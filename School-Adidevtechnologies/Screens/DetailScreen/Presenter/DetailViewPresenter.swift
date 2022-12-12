//
//  DetailViewPresenter.swift
//  School-Adidevtechnologies
//
//  Created by Vladislav on 11.12.2022.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setSchoolInfo(school: SchoolAdditionalInformationModel?)
    func failure(error: Error)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, dbn: String)
    
    func setSchoolInfo()
    func tapBack()
    func reload()
}

class DetailViewPresenter: DetailViewPresenterProtocol {
    
    private let networkService: NetworkServiceProtocol
    weak private var searchViewDelegate: DetailViewPresenterProtocol?
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    
    private var dbn: String
    private var schoolAdditionalInformation: SchoolAdditionalInformationModel?
    
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, dbn: String) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.dbn = dbn
        
        setData(dbn)
    }
    
    private func setData(_ dbn: String) {
        self.networkService.getAdditionalInformation(dbn: dbn) { [weak self] (data, error) in
            if let error = error {
                print(error.localizedDescription)
                self?.view?.failure(error: error)
                return
            }
            if let data = data {
                self?.schoolAdditionalInformation = SchoolAdditionalInformationModel.init(data[0])
                self?.setSchoolInfo()
            }
        }
    }
    
    func reload(){
        setData(dbn)
    }
    
    func setSchoolInfo() {
        self.view?.setSchoolInfo(school: self.schoolAdditionalInformation)
    }
    
    func tapBack() {
        self.router?.popToRoot()
    }

}

