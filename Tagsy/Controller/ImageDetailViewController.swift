//
//  ImageDetailViewController.swift
//  Tagsy
//
//  Created by Mandeep Dhillon on 25/01/21.
//

import UIKit

class ImageDetailViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var colorsCollectionView: UICollectionView!
  @IBOutlet weak var tagsCollectionView: UICollectionView!
  
  var uploadedImage: UploadedImage?
  
  override func viewDidLoad() {
        super.viewDidLoad()

    
    colorsCollectionView.delegate = self
    tagsCollectionView.delegate = self
    colorsCollectionView.dataSource = self
    tagsCollectionView.dataSource = self
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // leave if we do not have an UploadImage with properties to render
    guard let uploaded = uploadedImage else { return }
    // image
    imageView.image = uploaded.image
    // tags
    tagsCollectionView.reloadData()
    // colors
    colorsCollectionView.reloadData()
  }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
