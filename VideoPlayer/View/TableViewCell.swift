//
//  TableViewCell.swift
//  VideoPlayer
//
//  Created by Ильяяя on 28.05.2022.
//

import UIKit
import SnapKit

struct VideoItem {
    let title: String
    let desc: String
    let screen: String
    let file: String
}

class TableViewCell: UITableViewCell {
    private let screenView: UIImageView!
    private let titleLabel: UILabel!
    private let descLabel: UILabel!
    private let buttonPlay: UIButton!
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        titleLabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            return label
        }()
        
        descLabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 17, weight: .thin)
            return label
        }()
                
        screenView = {
            let view = UIImageView()
            view.backgroundColor = .darkGray
            view.contentMode = .scaleAspectFill
            view.clipsToBounds = true
            return view
        }()
        
        buttonPlay = {
            let button = UIButton()
            button.layer.cornerRadius = 25
            button.setImage( UIImage(named: "play"), for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            button.layer.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            button.layer.shadowRadius = 15.0
            button.layer.shadowOpacity = 0.9
            return button
        }()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .darkGray
        
        addSubview(screenView)
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(buttonPlay)
        
        screenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
        }
        
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        buttonPlay.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        buttonPlay.addTarget(self, action: #selector(playDidTouched), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func playDidTouched() {
        UIView.transition(with: buttonPlay, duration: 0.5, options: .transitionCrossDissolve) {
            self.buttonPlay.layer.shadowRadius = 30
        }
    }
    
    func setup( data: VideoItem ) {
        screenView.image = UIImage(named: data.screen)
        titleLabel.text = data.title
        descLabel.text = data.desc
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        screenView.alpha = selected ? 0.9 : 1.0
    }
}
