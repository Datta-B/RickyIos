//
//  RMFooterLoaderCollectionReusableView.swift
//  Ricky
//
//  Created by Apple on 13/06/23.
//

import UIKit

final class RMFooterLoaderCollectionReusableView: UICollectionReusableView {
    
    static let cellIdentifier = "RMFooterLoaderCollectionReusableView"
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        addSubview(spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints(){
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    public func startAnimation(){
        spinner.startAnimating()
    }
    public func stopAnimation(){
        spinner.stopAnimating()
    }
    
    
}

