//
//  RMCharacterCollectionViewCell.swift
//  Ricky
//
//  Created by Apple on 12/06/23.
//

import UIKit

class RMCharacterCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    private let imageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let namelbl = {
       let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let statusLabel = {
       let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    // MARK:- Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.addSubviews(imageView,namelbl,statusLabel)
        addConstraint()
       

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUP(){
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 4
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    
    private func addConstraint(){
        
        NSLayoutConstraint.activate([
            
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            namelbl.heightAnchor.constraint(equalToConstant: 30),
            
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 7),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -7),
            namelbl.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 7),
            namelbl.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -7),

 
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            namelbl.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: namelbl.topAnchor,constant: -3),

            
        ])
        
    }
    // DARK AND LIGHT MODES
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUP()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        namelbl.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with ViewModel : RMCharacterCollectionViewCellViewModel){
        namelbl.text = ViewModel.characterName
        statusLabel.text = ViewModel.characterStatusText
        ViewModel.fetchImage { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else{return}
                    let image = UIImage(data: data)
                    self.imageView.image = image
                }
            case .failure(_):
                break
            }
        }
    }
}


