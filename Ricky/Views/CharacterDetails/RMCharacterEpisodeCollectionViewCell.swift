//
//  RMCharacterEpisodeCollectionViewCell.swift
//  Ricky
//
//  Created by Apple on 20/06/23.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterEpisodeCollectionViewCell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.blue.cgColor
        contentView.layer.cornerRadius = 8
        addSubviews(nameLabel,airDate,episode)
        addconstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private let airDate : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let episode : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private func addconstrains(){
        NSLayoutConstraint.activate([
            
            episode.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            episode.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 12),
            episode.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -12),
            episode.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            nameLabel.topAnchor.constraint(equalTo: episode.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor,constant: 12),
            nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor,constant: -12),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            
            airDate.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            airDate.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 12),
            airDate.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -12),
            airDate.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),

        ])
    }
    
     override func prepareForReuse() {
        super.prepareForReuse()
         nameLabel.text = nil
         episode.text = nil
         airDate.text = nil
    }
    
    public func configure(with viewModel : RMCharacterEpisodeCollectionCellViewModel){
        
        viewModel.registerForData { [weak self] model in
            self?.nameLabel.text = model.name
            self?.airDate.text = " Aired On" + model.air_date
            self?.episode.text = "Episode " + model.episode
         
        }
        
        viewModel.fetchEpisode()

   
    }
}
