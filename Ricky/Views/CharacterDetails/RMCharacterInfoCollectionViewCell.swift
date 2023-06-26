//
//  RMCharacterInfoCollectionViewCell.swift
//  Ricky
//
//  Created by Apple on 20/06/23.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterInfoCollectionViewCell"

    private let valueLbl : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .light)
        label.text = "status"
        return label
    }()
    
    private let titleLbl : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "locations"
        return label
    }()
    
    private let iconImageview : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "globe.americas")
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    private let titleContainerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .secondarySystemBackground
            return view
        }()


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(titleContainerView,valueLbl,iconImageview)
        contentView.backgroundColor = .tertiaryLabel
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 8
        titleContainerView.addSubviews(titleLbl)
        addconstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addconstrains(){
        NSLayoutConstraint.activate([
            titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            titleLbl.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
            titleLbl.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
            titleLbl.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLbl.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            iconImageview.heightAnchor.constraint(equalToConstant: 30),
            iconImageview.widthAnchor.constraint(equalToConstant: 30),
            iconImageview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            iconImageview.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),

            valueLbl.leftAnchor.constraint(equalTo: iconImageview.rightAnchor, constant: 15),
            valueLbl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            valueLbl.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLbl.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor)
            
        ])
    }
    
    override func prepareForReuse() {
       super.prepareForReuse()
        valueLbl.text = nil
        titleLbl.text = nil
        iconImageview.image = nil
   }
    
    public func configure(with viewModel : RMCharacterInfoCollectionCellViewModel){
        titleLbl.text = viewModel.title
        valueLbl.text = viewModel.displayValue
        iconImageview.image = viewModel.iconImage
        iconImageview.tintColor = viewModel.tintColor
        titleLbl.textColor = viewModel.tintColor
    }
}
