//
//  SchoolCell.swift
//  School-Adidevtechnologies
//
//  Created by Vladislav on 11.12.2022.
//


import UIKit
import SnapKit

class SchoolCell: UITableViewCell {

    var schoolLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "schoolLabel"
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return titleLabel
    }()
    
    var addressLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "criticalLabel"
        subtitleLabel.numberOfLines = 1
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        return subtitleLabel
    }()
    
    var phoneLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "mathLabel"
        subtitleLabel.numberOfLines = 1
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        return subtitleLabel
    }()
    
    var websiteLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "writingLabel"
        subtitleLabel.numberOfLines = 1
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        return subtitleLabel
    }()

    var overviewLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "writingLabel"
        subtitleLabel.numberOfLines = 4
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        return subtitleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        setConstraints()
        return contentView.frame.size
    }
    
    func set(_ data: SchoolCellModel?) {
        schoolLabel.text = "School name: \(data?.schoolName ?? "")"
        addressLabel.text = "Address: \(data?.address ?? "" )"
        phoneLabel.text = "Phone: \(data?.phone ?? "" )"
        websiteLabel.text = "Website: \(data?.website ?? "" )"
        overviewLabel.text = "Overview: \(data?.overview ?? "" )"
        layoutSubviews()
    }
    
    private func setUpViews(){
        contentView.addSubview(schoolLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(websiteLabel)
        contentView.addSubview(overviewLabel)
    }
    
    private func setConstraints(){
        schoolLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
        }

        addressLabel.snp.makeConstraints {
            $0.top.equalTo(schoolLabel.snp.bottom).offset(5)
            $0.left.equalTo(schoolLabel)
            $0.right.equalTo(schoolLabel).inset(20)
        }
        
            phoneLabel.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(5)
            $0.left.equalTo(addressLabel)
            $0.right.equalTo(addressLabel).inset(20)
        }
        
        websiteLabel.snp.makeConstraints {
            $0.top.equalTo(phoneLabel.snp.bottom).offset(5)
            $0.left.equalTo(phoneLabel)
            $0.right.equalTo(phoneLabel).inset(20)
        }
        
        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(websiteLabel.snp.bottom).offset(5)
            $0.left.equalTo(websiteLabel)
            $0.right.equalTo(websiteLabel).inset(20)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
}
