//
//  LetterCollectionViewCell.swift
//  Alphabet-ios
//
//  Created by Sergey Kemenov on 02.10.2023.
//

import UIKit

class LetterCollectionViewCell: UICollectionViewCell {
  var titleLetter: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "A"
    $0.textColor = .yellow
    $0.font = UIFont.systemFont(ofSize: 46)
    return $0
  }(UILabel(frame: .zero))

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(titleLetter)

    NSLayoutConstraint.activate([
      titleLetter.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      titleLetter.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    // titleLetter.font = UIFont.systemFont(ofSize: 46) // clean for all cells. Need to save selected status
  }
}
