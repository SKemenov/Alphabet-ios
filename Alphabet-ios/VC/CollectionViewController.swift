//
//  ViewController.swift
//  Alphabet-ios
//
//  Created by Sergey Kemenov on 01.10.2023.
//
//
import UIKit

// MARK: - Class

class CollectionViewController: UIViewController {
  // MARK: - Private properties

  private let cellIdentifier = "cell"
  private let letters = [
    "а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р",
    "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я"
  ]

  // MARK: - Public properties

  let letterSize: CGFloat = 46
  var collectionView: UICollectionView = {
    UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  }()

  // MARK: - Inits

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - LifeCircle

  override func viewDidLoad() {
    super.viewDidLoad()
    // view.backgroundColor = .yellow
    collectionView.dataSource = self
    collectionView.delegate = self
    setupUI()
    setupSubViews()
    setupLayout()
  }
}

// MARK: - Private methods

private extension CollectionViewController {
  func setupUI() {
    collectionView.register(LetterCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    collectionView.register(
      SupplementaryView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: "header"
    )
    collectionView.register(
      SupplementaryView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
      withReuseIdentifier: "footer"
    )
    collectionView.allowsMultipleSelection = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    // collectionView.backgroundColor = .blue
  }

  func setupSubViews() {
    view.addSubview(collectionView)
  }

  func setupLayout() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
  }

  func makeBold(indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as? LetterCollectionViewCell
    cell?.titleLetter.font = UIFont.boldSystemFont(ofSize: letterSize)
  }

  func makeItalic(indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as? LetterCollectionViewCell
    cell?.titleLetter.font = UIFont.italicSystemFont(ofSize: letterSize)
  }
}

// MARK: - UICollectionViewDataSource

extension CollectionViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    letters.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        as? LetterCollectionViewCell else { return UICollectionViewCell() }
    cell.titleLetter.text = letters[indexPath.row]
    cell.contentView.backgroundColor = .blue
    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath
  ) -> UICollectionReusableView {
    var id: String
    switch kind {
    case UICollectionView.elementKindSectionHeader:
      id = "header"
    case UICollectionView.elementKindSectionFooter:
      id = "footer"
    default:
      id = ""
    }
    guard
      let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath)
        as? SupplementaryView else { return SupplementaryView() }
    view.titleLabel.text = "It's the \(id) Supplementary View "
    return view
  }
}

// MARK: - UICollectionViewDelegate

extension CollectionViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as? LetterCollectionViewCell
    cell?.titleLetter.font = UIFont.boldSystemFont(ofSize: letterSize)
  }

  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as? LetterCollectionViewCell
    cell?.titleLetter.font = UIFont.systemFont(ofSize: letterSize)
  }
  func collectionView(
    _ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint
  ) -> UIContextMenuConfiguration? {
    guard !indexPaths.isEmpty else { return nil }
    let indexPath = indexPaths[0]
    return UIContextMenuConfiguration { _ in
      return UIMenu(children: [
        UIAction(title: "Bold") { [weak self] _ in
          self?.makeBold(indexPath: indexPath)
        },
        UIAction(title: "Italic") { [weak self] _ in
          self?.makeItalic(indexPath: indexPath)
        }
      ])
    }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
  // for calculate the header size
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForHeaderInSection section: Int
  ) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 65)
//    let indexPath = IndexPath(row: 0, section: section)
//    let supplementaryView = self.collectionView(
//      collectionView,
//      viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
//      at: indexPath
//    )
//    return supplementaryView.systemLayoutSizeFitting(
//      CGSize(width: collectionView.frame.width, height: 100),
//      withHorizontalFittingPriority: .required,
//      verticalFittingPriority: .fittingSizeLevel
//    )
  }

  // for calculate the footer size
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForFooterInSection section: Int
  ) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 65)
//    let indexPath = IndexPath(row: 0, section: section)
//    let supplementaryView = self.collectionView(
//      collectionView,
//      viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter,
//      at: indexPath
//    )
//    return supplementaryView.systemLayoutSizeFitting(
//      CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
//      withHorizontalFittingPriority: .required,
//      verticalFittingPriority: .fittingSizeLevel
//    )
  }

  // for calculate the cell size
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(width: collectionView.bounds.width / 2 - 2, height: 65)
  }

  // for calculate the spacing size between lines of cells
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 2
  }

  // for calculate the spacing size between cells
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 2
  }
}
