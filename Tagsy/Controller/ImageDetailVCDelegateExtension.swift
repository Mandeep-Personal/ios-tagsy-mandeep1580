import UIKit

extension ImageDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{


func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  switch collectionView {
    case tagsCollectionView:
      return uploadedImage?.tags.count ?? 0
    case colorsCollectionView:
      return uploadedImage?.colors.count ?? 0
    default:
      return 0
  }
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  switch collectionView {
    case tagsCollectionView:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as? TagCell
      cell?.textLabel.text = uploadedImage?.tags[indexPath.row]
      return cell!
    case colorsCollectionView:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
      if let color: ImageColor = uploadedImage?.colors[indexPath.row] {
        cell.contentView.backgroundColor = UIColor(red: CGFloat(color.red)/255, green: CGFloat(color.green)/255, blue: CGFloat(color.blue)/255, alpha: 1.0)
      }
      return cell
    default:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
      return cell
  }
}

}
