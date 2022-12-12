//
//  DetailViewController.swift
//  School-Adidevtechnologies
//
//  Created by Vladislav on 11.12.2022.
//

import Foundation
import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    var presenter: DetailViewPresenterProtocol!
    
    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        return spinner
    }()
    
    
    var nameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "nameLabel"
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return titleLabel
    }()
    
    var numOfSatTestTakersLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "emailLabel"
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return titleLabel
    }()
    
    var readingScoreLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "organizationLabel"
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return titleLabel
    }()
    
    var mathScoreLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "organizationLabel"
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return titleLabel
    }()
    
    var writingScoreLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "organizationLabel"
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return titleLabel
    }()
    
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.isHidden = true
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setAndAddViews()
        setConstraints()
    }
    
    private func setAndAddViews(){
        view.addSubview(stackView)
        view.addSubview(spinner)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(numOfSatTestTakersLabel)
        stackView.addArrangedSubview(readingScoreLabel)
        stackView.addArrangedSubview(mathScoreLabel)
        stackView.addArrangedSubview(writingScoreLabel)
    }
    
    private func setConstraints(){
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().inset(5)
        }
        
        spinner.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    private func showAlert(text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { action in
            self.spinner.isHidden = false
            self.spinner.stopAnimating()
            self.presenter.reload()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension DetailViewController:  DetailViewProtocol {
    func setSchoolInfo(school: SchoolAdditionalInformationModel?) {
        spinner.stopAnimating()
        spinner.isHidden = true
        stackView.isHidden = false
        
        if let school = school {
            nameLabel.text = "Name school: \(school.schoolName)"
            numOfSatTestTakersLabel.text = "SAT: \(school.numOfSatTestTakers)"
            readingScoreLabel.text = "Reading score: \(school.satCriticalReadingAvgScore)"
            mathScoreLabel.text = "Mathematics score: \(school.satMathAvgScore)"
            writingScoreLabel.text = "Writing score: \(school.satWritingAvgScore)"
        }

    }
    
   
    func failure(error: Error) {
        spinner.stopAnimating()
        spinner.isHidden = true
        
        self.showAlert(text: error.localizedDescription)
    }
}
