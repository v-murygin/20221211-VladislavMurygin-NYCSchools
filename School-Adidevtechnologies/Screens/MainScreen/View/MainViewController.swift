//
//  MainViewController.swift
//  School-Adidevtechnologies
//
//  Created by Vladislav on 11.12.2022.
//

import Foundation
import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 60
        view.register(SchoolCell.self, forCellReuseIdentifier: "DefaultCell")
        view.delegate = self
        view.dataSource = self
        return view
    }()

    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "NYC Schools"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setAndAddViews()
        setConstraints()
        presenter.getFirstSchoolsList()
    }

    private func setAndAddViews(){
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        tableView.backgroundColor = .white
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.beginRefreshing()
    }
    
    private func setConstraints(){
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.presenter.getFirstSchoolsList()
    }
    
    private func showAlert(text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { action in
            self.presenter.getFirstSchoolsList()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: MainViewProtocol {
    func success() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        refreshControl.endRefreshing()
        self.showAlert(text: error.localizedDescription)
       
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.schools?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell") as! SchoolCell
        cell.set(self.presenter.schools?[indexPath.row])
        
        if indexPath.row == (self.presenter.schools?.count ?? 0) - 20 {
                self.presenter.loadMoreSchools()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let school = self.presenter.schools?[indexPath.row]
        if let dbn = school?.dbn {
            self.presenter.tapOnSchool(dbn:dbn)
        }
    }
}
