//
//  RMCharacterPhotoCollectionViewCell.swift
//  Ricky
//
//  Created by Apple on 20/06/23.
//

import UIKit

final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterPhotoCollectionViewCell"
    
    
    private let imageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addconstrains()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addconstrains(){
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

        ])
    }
    
    override func prepareForReuse() {
       super.prepareForReuse()
        imageView.image = nil
   }
    
    public func configure(with viewModel : RMCharacterPhotoCollectionCellViewModel){
        viewModel.fetchImage { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.imageView.image = UIImage(data: data)
            case .failure(let error):
                print("Error:\(error)")
            }
        }
    }
}
