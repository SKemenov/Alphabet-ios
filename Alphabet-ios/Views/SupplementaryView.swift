//
//  SupplementaryView.swift
//  Alphabet-ios
//
//  Created by Sergey Kemenov on 03.10.2023.
//

import UIKit

class SupplementaryView: UICollectionReusableView {
  let titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .blue
    $0.text = "Supplementary View"
    $0.font = UIFont.systemFont(ofSize: 23)
    return $0
  }(UILabel(frame: .zero))

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(titleLabel)

    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
